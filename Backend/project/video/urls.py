
from django.urls import path
from . import views

urlpatterns = [
    path('',views.index),
    path('upload/',views.upload,name='upload'),
    path('viewVideo/',views.viewVideo,name='viewVideo'),
    path('edit/',views.edit,name='edit')
]
