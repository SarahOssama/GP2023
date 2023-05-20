
from django.urls import path
from . import views

urlpatterns = [
    path('',views.index),
    path('upload/',views.upload,name='upload'),
    path('viewVideo/',views.viewVideo,name='viewVideo'),
    path('edit/',views.edit,name='edit'),
    path('preEditConfirmation/',views.preEditConfirmation,name='preEditConfirmation'),
    path('editInsert/',views.editInsert,name='editInsert'),
    path('revert/',views.revert,name='revert')
]
