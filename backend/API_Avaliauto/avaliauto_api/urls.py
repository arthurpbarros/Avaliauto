from django import urls
from django.urls import include,path
from avaliauto_api.views import *
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('Type',TypeViewSet)
router.register('Consultancy',ConsultancyViewSet)
router.register('User',UserViewSet)
router.register('Review',ReviewViewSet)
# router.register('Vehicle',VehicleViewSet)


urlpatterns = router.urls