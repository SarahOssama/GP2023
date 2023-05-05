from django.conf import settings
from rest_framework import status


def check_existence_of_media_file(data):
    bool=False
    message=''
    response=''
    if ('media_file' not in data):
        bool=True
        message = {'message': 'File is missing'}
        response = status.HTTP_400_BAD_REQUEST
    return bool,message ,response  


def upload_video(file_field):
    message='uploaded'
    bool=False

    response = status.HTTP_201_CREATED  

    content_type = file_field.name.split('.')[-1]
    valid_extensions =  ['mp4', 'mov', 'avi']  
    # print("HEllo ",content_type.lower())
    if content_type.lower() in valid_extensions:
        if file_field.size > 8e+8:
            message =  'File too large. Size should not exceed 100 MB.'
            response = status.HTTP_400_BAD_REQUEST
        bool = True
    else:
        message=  'upload video file. This is not a video file '
        response = status.HTTP_400_BAD_REQUEST

    return message,response,bool