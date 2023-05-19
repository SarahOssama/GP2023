import os
from django.db import models
from django.utils import timezone
from .validators import file_size

# Create your models here.

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = f'{instance.id}.{ext}'
    return f'videos/{instance.id}'

def upload_to(instance, filename):
    now = timezone.now()
    base, extension = os.path.splitext(filename.lower())
    milliseconds = now.microsecond // 1000
    return f"{now:%Y%m%d%H%M%S}{milliseconds}{extension}"

class Video(models.Model):
    caption=models.CharField(max_length=100)

    media_file=models.FileField(upload_to=upload_to,validators=[file_size])
    # command=models.CharField(max_length=1000,null=True,blank=True)
    def __str__(self):
        return self.caption
    
# class Video(models.Model):
#     title = models.CharField(max_length=200)
#     media_file=models.FileField(upload_to=f'video/{upload_to}',validators=[file_size])
#     versions = models.ManyToManyField('self', blank=True)
#     height = models.IntegerField()
#     width = models.IntegerField()
#     new_insert = models.FileField(upload_to='inserts/', null=True, blank=True)

#     def __str__(self):
#         return self.title
