import os
from django.db import models
from .validators import file_size

# Create your models here.

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = f'{instance.id}.{ext}'
    return f'videos/{instance.id}'

class Video(models.Model):
    caption=models.CharField(max_length=100)

    media_file=models.FileField(upload_to='videos/%d',validators=[file_size])
    # command=models.CharField(max_length=1000,null=True,blank=True)
    def __str__(self):
        return self.caption