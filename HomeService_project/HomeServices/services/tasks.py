from django_q.tasks import schedule
from .models import OrderService

def update_status_to_Underway(order_id ):
    try:
        order = OrderService.objects.get(pk =order_id)
    except OrderService.DoesNotExist:
        pass 
    order.status = "Pending"
    order.save()
    print("yooohooo")
