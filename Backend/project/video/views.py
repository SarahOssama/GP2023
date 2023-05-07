import asyncio
from io import BytesIO
from django.http import HttpResponse
from django.shortcuts import render

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status


from .models import Video
from .forms import Video_Form
from .views_functions import check_existence_of_media_file,upload_video
from .serializers import VideoSerializer
from .parameters import getParams
from .edits import editVideo,editVideoNER
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
def edit(request):
    video = Video.objects.last()
    # serializer=VideoSerializer(video,many=True)
    reqCommand = request.data['command']
    id = Video.objects.last().id
    print(reqCommand)
    # Get Parameters 
    # result =getParams(reqCommand)
    result= getParamsNER(reqCommand)
    clip= video.media_file
    print("clip",clip)
    # Edit Video
    ## Pass parameters 
    flag=editVideoNER(clip,result,reqCommand,id)
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
