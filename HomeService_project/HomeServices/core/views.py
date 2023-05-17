from rest_framework.decorators import api_view , parser_classes
from rest_framework.response import Response
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.auth import AuthToken
from .serializers import RegisterSerializer, UserConfirmEmailSerializer , NormalUserSerializer
from rest_framework.views import APIView
from django.shortcuts import render
from drf_spectacular.utils import extend_schema, OpenApiExample
from rest_framework import parsers
import os
from django.conf import settings
from django.http import FileResponse
from .models import Balance 

@extend_schema(
    request=AuthTokenSerializer,
    responses={200: AuthTokenSerializer},
)
@api_view(['POST'])
def login_api(request):
    serializer = AuthTokenSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']
    _, token = AuthToken.objects.create(user)
    return Response({
        'user_info': {
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'first_name':user.first_name,
            'last_name':user.last_name,
            'mode':user.mode,
            'photo':user.photo.url,
            'birth_date':user.birth_date,
            'join_date' : user.date_joined,
            'gender':user.gender,
            'bio':user.normal_user.bio,

        },
        'token': {token}
    })

@parser_classes([parsers.MultiPartParser])
@api_view(['GET'])
def user_info(request):
    user = request.user
    if user.is_authenticated:
        return Response({
            'user_info': {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'first_name':user.first_name,
                'last_name':user.last_name,
                'mode':user.mode,
                'photo':user.photo.url,
                'birth_date':user.birth_date,
                'join_date' : user.join_date,
                'gender':user.gender,
                'bio':user.normal_user.bio,

            },
        })


@extend_schema(
    request=RegisterSerializer,
    responses=RegisterSerializer,
)
@api_view(['POST'])
def register_api(request):
    serializer = RegisterSerializer(
        data=request.data, context={'request': request})
    serializer.is_valid(raise_exception=True)
    normal_user = NormalUserSerializer(data = request.data)
    normal_user.is_valid(raise_exception=True)
    user = serializer.save()
    normal_user = normal_user.save(user=user)
    Balance.objects.create(user=normal_user)
    # _, token = AuthToken.objects.create(user)
    return Response({'detail': 'account registered please confirm your email.'})


class UserConfirmEmailView(APIView):
    serializer_class = UserConfirmEmailSerializer

    def get(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=kwargs)
        if not serializer.is_valid():
            return render(request, 'core/error_confirming.html')
        return render(request, 'core/confirmed.html')
    
# class PhotoView(APIView):
#     def get(self, request, filename):
#         photo_path = os.path.join(settings.MEDIA_ROOT+'profile', filename)
#         if os.path.exists(photo_path):
#             return FileResponse(open(photo_path, 'rb'), content_type='image/jpeg')
#         else:
#             return Response({'detail':'The requested photo was not found.'})

