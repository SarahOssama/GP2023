import asyncio
from io import BytesIO
import io
import tempfile
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import JSONParser

from moviepy.editor import *

from .models import Video
from .forms import Video_Form
from .views_functions import check_existence_of_media_file,upload_video
from .serializers import VideoSerializer
from .parameters import getParams
from .edits import editConfirmedVideo, preEditVideoNER
from .NER import getParamsNER

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
    empty,msg,response = check_existence_of_media_file(request.data)

    serializer=VideoSerializer(data=request.data)
    if empty :
        return Response( {'message': str(msg)}, status=response)
    
    if serializer.is_valid():
        file_field = request.FILES['media_file']
        message,response,success= upload_video(file_field)
        if success:
            serializer.save()
            # increment the count of media 
            return Response({'message': str(message)},status=response)
        else:
            return Response({'message': str(message)}, status=response)  
    else:
        return Response(
            serializer.errors, status=status.HTTP_400_BAD_REQUEST)

  

@api_view(['GET'])
def viewVideo(request):
    video = Video.objects.all()
    serializer=VideoSerializer(video,many=True)
    # editVideo(serializer.data[0])
     
    return Response(serializer.data)

@api_view(['GET'])
def preEditConfirmation(request):
    video = Video.objects.last()
    clip= video.media_file
    reqCommand = request.data['command']
    result= getParamsNER(reqCommand)
    #now i have results of parameters NER model
    #now i have to check if the parameters are valid or not
    edit_features=preEditVideoNER(result,reqCommand,clip)
    return Response(edit_features)


#the edit request wil get 2 things from front end -->action and features
@api_view(['GET'])
def edit(request):
    #getting the uploaded video which we will edit
    video = Video.objects.last()
    id = Video.objects.last().id
    clip= video.media_file
    #getting the action and features from front end
    action = request.data['action']
    features=request.data['features']
    # Edit Video
    flag=editConfirmedVideo(clip,action,features,id)
    if( flag):
        video.media_file=f'videos/Out{id}.mp4'
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