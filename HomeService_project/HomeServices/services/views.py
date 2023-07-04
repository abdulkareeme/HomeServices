from django.shortcuts import render
from rest_framework.views import APIView
from .models import Category ,Area,HomeService ,Rating  ,GeneralServicesPrice , Beneficiary , Earnings , InputData , InputField , OrderService
from .serializers import AreaSerializer ,CategorySerializer  , RatingSerializer,InputFieldSerializer  , ListOrdersSerializer  ,ListHomeServicesSerializer , RetrieveHomeServices , CreateHomeServiceSerializer ,RetrieveUpdateHomeServiceSerializer,InputFieldSerializerAll ,InputDataSerializer,RetrieveInputDataSerializer ,RatingDetailSerializer
from rest_framework.response import Response
from rest_framework import status , generics
from rest_framework import permissions
from drf_spectacular.utils import extend_schema
from django.utils import timezone
from django.db.models import Q ,Avg ,F , Sum
from django.db import transaction
from datetime import datetime , timedelta
from .spectacular import ListOrdersSpectacular ,MakeOrderSpectacular ,SellerCommentSpectacular , RetrieveRatingsSpectacular
from django_q.tasks import async_task
from datetime import datetime, timedelta
from django_q.tasks import schedule
from django_q.models import Schedule
import arrow

@transaction.atomic
def taking_money(user , required_balance, order, general_services):
    order.status = 'Under review'
    order.save()
    user.balance.total_balance -= required_balance
    user.balance.save()
    for beneficiary in general_services:
        Earnings.objects.create(order = order, earnings  = beneficiary.price ,beneficiary=beneficiary.beneficiary)
    return True

def get_from_data(order):
    serializer = RetrieveInputDataSerializer(data = order.input_data_set , many=True)
    serializer.is_valid(raise_exception=False)
    return serializer.data

class IsOwner(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        return obj.seller == request.user.normal_user

class ListCategories(APIView):
    @extend_schema(
            responses={200:CategorySerializer(many=True)}
    )
    def get(self , request):
        queryset = Category.objects.all()
        serializer = CategorySerializer(data=queryset, many=True)
        serializer.is_valid()
        return Response(serializer.data , status=status.HTTP_200_OK)
def is_rateable(order):
    rateable = None
    try :
        order.rating
        rateable = False
    except :
        pass
    if order.expected_time_by_day_to_finish is not None and order.answer_time is not None :
        expected_finish_time = order.answer_time + timedelta(days=order.expected_time_by_day_to_finish)
    else :
        expected_finish_time = None
    if order.status != 'Pending' and rateable is None and (order.is_rateable or (expected_finish_time is not None and (timezone.now() > expected_finish_time))):
        rateable = True
    return rateable

class MyOrders(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={200:ListOrdersSpectacular(many=True) , 401:None}
    )
    def get(self, request):
        queryset= OrderService.objects.filter(client = request.user.normal_user)
        serializer = ListOrdersSerializer(data = queryset , many=True)
        serializer.is_valid(raise_exception=False)
        i = 0
        for order in queryset :
            serializer.data[i]['client']=order.client.user.username
            serializer.data[i]['home_service']['seller']=order.home_service.seller.user.username
            serializer.data[i]['form'] = get_from_data(order=order)
            serializer.data[i]['is_rateable'] = is_rateable(order=order)
            serializer.data[i]['expected_time_by_day_to_finish'] = order.expected_time_by_day_to_finish
            photo = None
            if order.client.user.photo :
                photo = order.client.user.photo.url
            serializer.data[i]['photo'] = photo
            i+=1
        return Response(serializer.data )

class ReceivedOrders(APIView):
    permission_classes=[permissions.IsAuthenticated]
    @extend_schema(
        responses={200:ListOrdersSpectacular , 403:None , 401:None},
    )
    def get(self , request):
        if request.user.mode == 'client':
            return Response({"detail":"Error 403 Forbidden , you are a buyer you don't receive orders"} , status=status.HTTP_403_FORBIDDEN)
        queryset= OrderService.objects.filter(home_service__seller = request.user.normal_user ).filter(~Q(status="Rejected"))
        serializer = ListOrdersSerializer(data = queryset , many=True)
        serializer.is_valid()
        i = 0
        for order in queryset :
            serializer.data[i]['client']=order.client.user.username
            serializer.data[i]['home_service']['seller']=order.home_service.seller.user.username
            if order.status != 'Pending':
                serializer.data[i]['form'] = get_from_data(order=order)
            else :
                serializer.data[i]['form'] = []
            serializer.data[i]['is_rateable'] = is_rateable(order=order)
            serializer.data[i]['expected_time_by_day_to_finish'] = order.expected_time_by_day_to_finish
            photo = None
            if order.client.user.photo :
                photo = order.client.user.photo.url
            serializer.data[i]['photo'] = photo
            i+=1
        return Response(serializer.data )


@extend_schema(
    description="NOTE : When you use this api use :<br> 1 - ( services/list_home_services?username=\{username\} ) to filter \
       the services for this user <br> 2 -  ( services/list_home_services?category=\{category name\} ) to filter the services by category\
        3 - ( services/list_home_services?category=\{category name\}&title=\{string you want to contains in the title\} ) to filter the services by category and title<br>\
            4 - else it will returns all services\
                NOTE 2 : If the user is logged in it will be filter by service area depending on his area "

)
class ListHomeServices(generics.ListAPIView):
    queryset = HomeService.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = ListHomeServicesSerializer
    def get_queryset(self):
        if not self.request.user.is_authenticated :
            area = Area.objects.all()
        else:
            area = [self.request.user.area]
        if 'username' in self.request.GET:
            return HomeService.objects.filter(seller__user__username = self.request.GET.get('username')).order_by('-average_ratings')
        if 'category' in self.request.GET and 'title' in self.request.GET:
            return HomeService.objects.filter(title__contains = self.request.GET.get('title'),category__name = self.request.GET.get('category'),service_area__in =area ).order_by('-average_ratings')
        if 'title' in self.request.GET :
            return HomeService.objects.filter(title__contains = self.request.GET.get('title'),service_area__in =area).order_by('-average_ratings')
        if 'category' in self.request.GET:
            return HomeService.objects.filter(category__name = self.request.GET.get('category'),service_area__in =area).order_by('-average_ratings')
        return HomeService.objects.filter(service_area__in =area).order_by('-average_ratings')

@extend_schema(
    responses={200:RetrieveHomeServices}
)
class HomeServiceDetail(generics.RetrieveAPIView):
    permission_classes=[permissions.AllowAny]
    serializer_class = RetrieveHomeServices
    queryset = HomeService.objects.all()

@extend_schema(
    request= CreateHomeServiceSerializer
)
class CreateHomeService(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CreateHomeServiceSerializer

@extend_schema(
    request=RetrieveUpdateHomeServiceSerializer,
    responses={200 : RetrieveUpdateHomeServiceSerializer , 403 : None, 401 : None}
)
class RetrieveUpdateHomeService(generics.RetrieveUpdateAPIView):
    permission_classes =[permissions.IsAuthenticated , IsOwner]
    serializer_class = RetrieveUpdateHomeServiceSerializer
    lookup_url_kwarg = 'home_service_id'
    queryset = HomeService.objects.all()

class ListArea(generics.ListAPIView):
    queryset = Area.objects.all()
    serializer_class = AreaSerializer
    permission_classes = [permissions.AllowAny]

@extend_schema(
    responses= {403 : None , 204:None , 401 : None}
)
class DeleteHomeService(generics.DestroyAPIView):
    queryset = HomeService
    serializer_class = CreateHomeServiceSerializer
    permission_classes = [permissions.IsAuthenticated , IsOwner]
    lookup_url_kwarg = 'home_service_id'

def delete_data(data):
    data.delete()
    return True


class UpdateFormHomeService(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={200 : InputFieldSerializer(many=True)}
    )
    def get(self , request , home_service_id):
        try :
            home_service = HomeService.objects.get(pk=home_service_id)
        except HomeService.DoesNotExist :
            return Response("404 NOT FOUND", status=status.HTTP_404_NOT_FOUND)

        if home_service.seller != request.user.normal_user :
            return Response({"detail" : "403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        queryset= InputField.objects.filter(home_service= home_service , home_service__seller = request.user.normal_user)
        serializer = InputFieldSerializer(data = queryset ,  many=True)
        serializer.is_valid(raise_exception=False)
        return Response(serializer.data , status=status.HTTP_200_OK)
    @extend_schema(
    request=InputFieldSerializer(many=True),
    responses={200:InputFieldSerializer(many=True) , 400 : None , 403 : None , 401 : None}
    )
    def put(self , request , home_service_id):
        try :
            home_service = HomeService.objects.get(pk=home_service_id)
        except HomeService.DoesNotExist :
            return Response("404 NOT FOUND", status=status.HTTP_404_NOT_FOUND)

        if home_service.seller != request.user.normal_user :
            return Response({"detail" : "403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)

        queryset= InputField.objects.filter(home_service = home_service, home_service__seller = request.user.normal_user)
        serializer  = InputFieldSerializer(data= request.data , many=True)
        serializer.is_valid(raise_exception=True)
        if len(serializer.validated_data) < 3 or len(serializer.validated_data) >10 :
            return Response({'detail':["Number of fields must be between 3 and 10"]}, status=status.HTTP_400_BAD_REQUEST)

        delete_data(queryset)
        serializer.save(home_service= home_service)
        return Response(serializer.data ,status=status.HTTP_200_OK )


class MakeOrderService(APIView):
    permission_classes = [permissions.IsAuthenticated]
    @extend_schema(
            responses={404 : None , 200 : InputFieldSerializerAll(many=True) , 401:None}
    )
    def get(self , request , service_id) :
        try :
            home_service = HomeService.objects.get(pk= service_id)
        except HomeService.DoesNotExist :
            return Response({"detail":["404 NOT FOUND"] }, status= status.HTTP_404_NOT_FOUND)
        form  = home_service.field
        serializer = InputFieldSerializerAll(data=form , many=True)
        serializer.is_valid(raise_exception=False)
        return Response(serializer.data , status= status.HTTP_200_OK)

    @extend_schema(
            request=MakeOrderSpectacular,
            responses={200:None , 400:None , 401:None}
    )
    def post(self , request , service_id):
        try :
            home_service = HomeService.objects.get(pk= service_id)
        except HomeService.DoesNotExist :
            return Response({"detail":["404 NOT FOUND"] }, status= status.HTTP_404_NOT_FOUND)
        if 'form_data' not in request.data:
            return Response({"form_data":"This field is required"},status = status.HTTP_400_BAD_REQUEST)
        if not isinstance(request.data['form_data'], list):
            return Response({"form_data":"This field must be list"},status = status.HTTP_400_BAD_REQUEST)
        if 'expected_time_by_day_to_finish' not in request.data :
            return Response({"expected_time_by_day_to_finish":"This field is required"},status = status.HTTP_400_BAD_REQUEST)
        if home_service.seller == request.user.normal_user :
            return Response({"detail":"You can't order service from yourself"},status = status.HTTP_400_BAD_REQUEST)
        rateable_services = OrderService.objects.filter(client= request.user.normal_user , is_rateable = True)

        if rateable_services.count() >0 :
            return Response({"detail":"You have unrated services please rate it and order again"},status = status.HTTP_400_BAD_REQUEST)
        check_sended_orders = OrderService.objects.filter(client = request.user.normal_user , home_service = home_service , status = "Pending" )
        if check_sended_orders.count()>0:
            return Response({"detail":"you have already ordered this service"} , status=status.HTTP_400_BAD_REQUEST)
        try :
            expected_time_by_day_to_finish =int( request.data['expected_time_by_day_to_finish'])
        except ValueError :
            return Response({"expected_time_by_day_to_finish":"This value must be integer"},status=status.HTTP_400_BAD_REQUEST)
        serializer = InputDataSerializer(data = request.data['form_data'] , many=True )
        serializer.is_valid(raise_exception=True)
        if expected_time_by_day_to_finish is not None and (expected_time_by_day_to_finish < 1 or expected_time_by_day_to_finish > 90) :
            return Response({"expected_time_by_day_to_finish":"expected_time_by_day_to_finish must be between 1 and 90"}, status=status.HTTP_400_BAD_REQUEST)

        # make sure that all fields belong to this service are exist
        validated_data = []
        for input_field_1 in home_service.field.all() :
            is_exists = False
            for input_field_2 in serializer.data :
                if input_field_1.id == input_field_2['field'] :
                    is_exists =True
                    validated_data.append(input_field_2)
                    break
            if not is_exists:
                return Response({"detail":f"Error fields are not compatible (you did'nt send field : {input_field_1.id})"} , status= status.HTTP_400_BAD_REQUEST)
        new_order = OrderService.objects.create(client = request.user.normal_user , home_service=home_service , expected_time_by_day_to_finish=expected_time_by_day_to_finish)
        new_order.save()
        index = 0
        all_fields = home_service.field.all()
        for input_data in validated_data:
            InputData.objects.create(field = all_fields[index] , content = input_data['content'] , order = new_order).save()
            index+=1

        return Response("Success", status=status.HTTP_200_OK)

class CancelOrder(APIView):
    parser_classes = [permissions.IsAuthenticated]
    @extend_schema(
        responses={401:None , 204:None ,404:None , 403:None}
    )
    def delete(self , request , order_id):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if request.user.normal_user != order.client :
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Pending':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)
        order.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class RejectOrder(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        responses={204:None ,401 :None , 403:None , 404:None }
    )
    def put(self , request  , order_id):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Pending':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)
        order.status="Rejected"
        order.answer_time=timezone.now()
        average_fast_answer = OrderService.objects.exclude(status='Pending').annotate(average = Avg(F('answer_time')-F('create_date'))).values('average')[0]['average']
        order.home_service.seller.average_fast_answer = average_fast_answer
        order.save()
        order.home_service.seller.save()
        return Response(status=status.HTTP_204_NO_CONTENT)

@extend_schema(
    responses={401:None , 403:None ,404 : None , 200:RetrieveInputDataSerializer(many=True) , 400:None}
)
class AcceptOrder(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def put(self , request , order_id):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Pending':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)

        required_balance = GeneralServicesPrice.objects.all().aggregate(Sum('price'))['price__sum']
        if required_balance is not None and request.user.normal_user.balance.total_balance < required_balance:
            return Response({"detail":"You don't have enough money"}, status=status.HTTP_400_BAD_REQUEST)

        general_services = GeneralServicesPrice.objects.all()

        if not taking_money(general_services=general_services,order=order,required_balance=required_balance,user=request.user.normal_user) :
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)

        order.answer_time=timezone.now()
        average_fast_answer = OrderService.objects.filter(~Q(status='Pending')).annotate(time = F('answer_time')-F('create_date')).aggregate(Avg('time'))['time__avg']
        order.home_service.seller.average_fast_answer = average_fast_answer
        order.save()
        order.home_service.seller.save()
        schedule('services.tasks.update_status_to_Underway',order.id ,schedule_type=Schedule.ONCE, minutes=15,next_run=arrow.utcnow().shift(minutes=15).datetime)
        return Response(get_from_data(order=order),status=status.HTTP_200_OK)

@extend_schema(
    responses={200:None,400:None,401:None,404:None,403:None}
)
class AcceptAfterUnderReview(APIView):
    permission_classes=[permissions.IsAuthenticated]

    def put(self , request, order_id ):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Under review':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)
        order.status="Underway"
        order.save()
        return Response('Success')
@extend_schema(
    responses={200:None,400:None,401:None,404:None,403:None}
)
class RejectAfterUnderReview(APIView):
    permission_classes=[permissions.IsAuthenticated]

    def put(self , request, order_id ):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Under review':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)
        order.status='Rejected'
        order.save()
        return Response('Success')
@extend_schema(
    responses={200:None,400:None,401:None,404:None,403:None}
)
class FinishOrder(APIView):
    permission_classes= [permissions.IsAuthenticated]
    def put(self , request, order_id ):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if order.status != 'Underway':
            return Response({"detail":"Unexpected error"}, status=status.HTTP_400_BAD_REQUEST)
        order.end_service=timezone.now()
        order.is_rateable = True
        order.status="Expire"
        order.save()
        return Response("Order finished" , status=status.HTTP_200_OK)
@extend_schema(
    request=RatingSerializer,
    responses={200:RatingSerializer ,400:None,401:None,404:None,403:None }
)
class MakeRateAndComment(APIView):
    permission_classes=[permissions.IsAuthenticated]
    def post(self , request , order_id):
        try :
            order = OrderService.objects.get(pk= order_id)
        except OrderService.DoesNotExist :
            return Response({"detail":"404 NOT FOUND"} , status=status.HTTP_404_NOT_FOUND)
        if order.client != request.user.normal_user :
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        try:
            rate = Rating.objects.get(order_service = order)
        except Rating.DoesNotExist:
            rate = None
        if rate is not None :
            return Response({"detail":"You have already rated this service"} , status=status.HTTP_400_BAD_REQUEST)
        if is_rateable(order=order) :
            serializer = RatingSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            print(serializer.validated_data)
            serializer.save(order_service = order)
            print("tow")
            order.status="Expire"
            order.is_rateable=False
            average_rate_for_this_order = float(serializer.validated_data['quality_of_service'] + serializer.validated_data['commitment_to_deadline'] + serializer.validated_data['work_ethics']) /3
            order.home_service.average_ratings = (float(order.home_service.average_ratings * order.home_service.number_of_served_clients) + average_rate_for_this_order ) / (order.home_service.number_of_served_clients+1)
            order.home_service.number_of_served_clients +=1
            order.home_service.save()
            order.save()
            return Response(serializer.data , status=status.HTTP_200_OK)
        else :
            return Response({"detail":"The order has not finished yet"} , status=status.HTTP_400_BAD_REQUEST)
@extend_schema(
    request=SellerCommentSpectacular ,
    responses={200:None , 404:None , 400 : None , 403 : None , 401:None}
)
class SellerComment(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def post(self , request , rating_id):
        try :
            rating = Rating.objects.get(pk= rating_id)
        except Rating.DoesNotExist :
            return Response({"detail":"The client does not rate this service yet"} , status=status.HTTP_404_NOT_FOUND)
        if rating.order_service.home_service.seller != request.user.normal_user:
            return Response({"detail":"403 FORBIDDEN"} , status=status.HTTP_403_FORBIDDEN)
        if 'seller_comment' not in request.data :
            return Response({"seller_comment":"This field is required "}, status=status.HTTP_400_BAD_REQUEST)
        rating.seller_comment = request.data['seller_comment']
        rating.save()
        return Response("Success",status=status.HTTP_200_OK)

@extend_schema(
    responses={200:RetrieveRatingsSpectacular(many=True)}
)
class ListRating(APIView):
    def get(self , request , service_id ):
        ratings= Rating.objects.filter(order_service__home_service__id = service_id)
        serializer  = RatingDetailSerializer(data = ratings, many=True )
        serializer.is_valid(raise_exception=False)
        index = 0
        for rate in ratings:
            serializer.data[index]['client'] = rate.order_service.client.user.username
        return Response(serializer.data,status=status.HTTP_200_OK)