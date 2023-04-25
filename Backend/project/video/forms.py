from django import forms
from .models import Video

class Video_Form(forms.ModelForm):
    class Meta:
        model = Video
        fields = ['caption','media_file']