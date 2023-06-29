from django_q.tasks import schedule
from .models import OrderService

def update_status_to_Underway(order_id ):
    try:
        order = OrderService.objects.get(pk =order_id)
        if order.status == "Under review":
            order.status = "Underway"
            order.save()
        print("yooohooo")
    except OrderService.DoesNotExist:
        pass 
