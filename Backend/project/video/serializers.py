from rest_framework import serializers
from moviepy.video.io.VideoFileClip import VideoFileClip
from .models import Video

class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = '__all__'

        

class VideoFileClipSerializer(serializers.Serializer):
    duration = serializers.FloatField()
    size = serializers.ListField(child=serializers.IntegerField())

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        representation['fps'] = instance.fps
        return representation

    def to_internal_value(self, data):
        return VideoFileClip(None, duration=data['duration'], size=tuple(data['size']), fps=data['fps'])
