import os
from django.db import models
from django.utils import timezone
from .validators import file_size
import json 

# Create your models here.

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = f'{instance.id}.{ext}'
    return f'videos/{instance.id}'

def upload_to(instance, filename):
    now = timezone.now()
    base, extension = os.path.splitext(filename.lower())
    milliseconds = now.microsecond // 1000
    return f"video/{now:%Y%m%d%H%M%S}{milliseconds}{extension}"

class Video(models.Model):
    title = models.CharField(max_length=200,null=True,blank=True)
    media_file=models.FileField(upload_to=upload_to,validators=[file_size])
    height = models.IntegerField(null=True, blank=True)
    width = models.IntegerField(null=True, blank=True)
    new_insert = models.FileField(upload_to='inserts/', null=True, blank=True)

    def __str__(self):
        return self.title
    versions = models.CharField(max_length=200,null=True, blank=True)

    def push_to_versions_stack(self, value):
        if self.versions:
            # Deserialize the stack from JSON to a list
            stack_list = json.loads(self.versions)
        else:
            stack_list = []

        stack_list.append(value)

        # Serialize the updated stack list back to JSON
        self.versions = json.dumps(stack_list)
        self.save()

    def pop_from_versions_stack(self):
        if self.versions:
            # Deserialize the stack from JSON to a list
            stack_list = json.loads(self.versions)
        else:
            stack_list = []

        if stack_list:
            value = stack_list.pop()
        else:
            value = None

        # Serialize the updated stack list back to JSON
        self.versions = json.dumps(stack_list)
        self.save()

        return value
    def get_versions_stack_count(self):
        if self.versions:
            # Deserialize the stack from JSON to a list
            stack_list = json.loads(self.versions)
        else:
            stack_list = []

        return len(stack_list)
