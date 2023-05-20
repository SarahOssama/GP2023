from django import forms
from .models import Video

class Video_Form(forms.ModelForm):
    class Meta:
        model = Video
        fields = ['title','media_file','height','width','new_insert','versions']