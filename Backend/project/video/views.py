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
from .views_functions import *
from .serializers import VideoSerializer
from .parameters import getParams
from .edits import editVideoNER, preEditVideoNER
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
            
            video = serializer.save()
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
    correctMessage,errorMessage,=preEditVideoNER(result,reqCommand,clip)
    return Response({'confirmationMessage': str(correctMessage),'errorMessage':str(errorMessage),'parameters':str(result)})


@api_view(['POST'])
def editInsert(request):
    #upload video one at a time
    empty,msg,response = check_existence_of_media_file_insert(request.data)
    video = Video.objects.last()
    if empty :
        return Response( {'message': str(msg)}, status=response)
    
    if True:
        added_file_field = request.FILES['new_insert']
        message,response,success= upload_video_insert(added_file_field)
        if success:
            video.new_insert = added_file_field
            video.save()
            serializer=VideoSerializer(video)

            # increment the count of media 
            return Response({'message': str(message)},status=response)
        else:
            return Response({'message': str(message)}, status=response)  
    else:
        return Response(
            serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    reqCommand = request.data['command']
    id = Video.objects.last().id
    print(reqCommand)

  

@api_view(['GET'])
def edit(request):
    video = Video.objects.last()
    reqCommand = request.data['command']
    id = Video.objects.last().id
    edited_versions_count = video.get_versions_stack_count()+1

    result= getParamsNER(reqCommand)
    clip= video.media_file
    video.push_to_versions_stack(clip.name)
    print("clip",clip)
    # Edit Video
    ## Pass parameters 
    flag=editVideoNER(clip,result,reqCommand,id,edited_versions_count)
    if( flag):
        video.media_file=f'videos/Out_{id}_{edited_versions_count}.mp4'
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


@api_view(['GET'])
def revert(request):
    video = Video.objects.last()
    # if the stack is emplty give an error msg that no more revers are viable else revert
    if video.get_versions_stack_count() == 0 :
        message=  'No More Reverts are available '
        response = status.HTTP_400_BAD_REQUEST

        return Response({'message': str(message)}, status=response)

    previous =video.pop_from_versions_stack()
    video.media_file=previous
    video.save()
    serializer=VideoSerializer(video)
    return Response(serializer.data)
