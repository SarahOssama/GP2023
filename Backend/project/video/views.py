import asyncio
from io import BytesIO
from django.http import HttpResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response



from .models import Video
from .forms import Video_Form
from .serializers import VideoSerializer
from .parameters import getParams
from .edits import editVideo

# Create your views here.

# @api_view(['GET'])
def index(request):
    # api_urls = {
    #     'upload':'/upload/',
    # }
    # return Response(api_urls)
    video = Video.objects.all()
  
    return render(request,'index.html',{"video":video})


@api_view(['POST'])
def upload(request):
    #upload video one at a time
    # video=Video.objects.all()
    # print(request.data)
    serializer=VideoSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()

  
    return Response(serializer.data)

@api_view(['GET'])
def viewVideo(request):
    video = Video.objects.all()
    serializer=VideoSerializer(video,many=True)
    # editVideo(serializer.data[0])
     
    return Response(serializer.data)


@api_view(['GET'])
def edit(request):
    video = Video.objects.last()
    # serializer=VideoSerializer(video,many=True)
    reqCommand = request.data['command']
    print(reqCommand)
    # Get Parameters 
    result =getParams(reqCommand)
    clip= video.media_file
    print("clip",clip)
    # Edit Video
    ## Pass parameters 
    flag=editVideo(clip,result)
    if( flag):
        video.media_file="videos/Out.mp4"
        video.save()
        serializer=VideoSerializer(video)
        return Response(serializer.data)

    # edited_video = BytesIO()
    # edited_video = clip.write_videofile(edited_video, codec='libx264', audio_codec='aac')
    
    # # Clean up
    # clip.close()
    # print(edited_video.getvalue())
    
    
    # return Response("Processing")

    ## return output video
