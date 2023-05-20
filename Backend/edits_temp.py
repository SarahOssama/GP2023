import re
import cv2
from moviepy.editor import *
from skimage.filters import gaussian
import asyncio
from rest_framework.response import Response

from azure.storage.blob import BlobServiceClient
from datetime import datetime, timedelta
from azure.storage.blob import generate_blob_sas, BlobSasPermissions
from video.serializers import VideoSerializer
from .models import Video


global i
i=0

    
def preEditVideoNER(entities,reqCommand,clip):
    # Create a Clip with video
    clip="media/"+str(clip)
    clip=createClip(clip)
    actions = ['TRIM','SPEED','TEXT','BLUR','BRIGHT','DARK','ANIMATE','MONOC']
    extractedLabels=[entity.label_ for entity in entities]
    allAction=[entity.label_ for entity in entities if entity.label_ in actions]
    edit_features={}
    if len(allAction) == 0 :
        # Sorry We Have No Action Given
        edit_features["message"]="Please enter a valid command"
        return edit_features
    if len(allAction) > 1 :
        # Handle Multiple actions
        edit_features["message"]="Multiple actions are not supported yet"
        return edit_features
    if len(allAction) == 1 :
        # Handle 1 action
        if 'TRIM' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="trim"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features


        if 'TEXT' in extractedLabels:
            #first intialize default values for color,size,position,start time and end time
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            defaultColor = 'black'
            defaultSize = "medium"
            defaultPosition = 'center'
            #now extract the actual values if found from the user command
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            extractedColour=[entity.text for entity in entities if entity.label_ == 'COLOR']
            extractedSize=[entity.text for entity in entities if entity.label_ == 'SIZE']
            extractedPosition=[entity.text for entity in entities if entity.label_ == 'POSITION']
            extractedWatermark=[entity.text for entity in entities if entity.label_ == 'TEXT']
            watermark= True if extractedWatermark[0]=="watermark" else False
            #now check if the extracted values are valid or not and if not then use the default values
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            colour= extractedColour[0] if len(extractedColour) > 0 else defaultColor
            size= extractedSize[0] if len(extractedSize) > 0 else defaultSize
            position= extractedPosition[0] if len(extractedPosition) > 0 else defaultPosition
            #now extract the text from the user command
            text=""
            pattern = "'(.*?)'"
            match = re.search(pattern, reqCommand)
            if match is not None:
                text = match.group(1)
            else:
                # Handle the case when no match is found
                text=""
            # now either i got features from user or i give him default features
            # now lets return our response to the user
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="Add Text"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime,"color":colour,"fontSize":size,"textPosition":position,"listOfAvailableColors":['black','white','red','green','blue','yellow','cyan','magenta','grey','lightgrey'],"listOfAvailableSizes":['small','medium','large'],"listOfAvailablePositions":['center','top','bottom'],"text":text}
            return edit_features
        
        if 'BLUR' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="blur"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features
        if 'BRIGHT' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="brighten"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features
        if 'DARK' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="darken"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features
        if 'ANIMATE' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="animate"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features
        if 'MONOC' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            edit_features["message"]="Confirm your Edit Command"
            edit_features["action"]="monoc"
            edit_features["videoDuration"]=defaultEndTime
            edit_features["features"]={"startTime":startTime,"endTime":endTime}
            return edit_features 
    return edit_features
def editConfirmedVideo(clip,action,features,id=0):
    # Create a Clip with video
    clip="media/"+str(clip)
    clip=createClip(clip)
    clip=restoreClipSize(clip)
    if action=='trim':
        clip= trim(clip,features["startTime"],features["endTime"])
        pass
    if action=='blur':
        clip= edit_video_duration(clip,features["startTime"],features["endTime"],"blur")
        pass
    if action=='brighten':
        clip= edit_video_duration(clip,features["startTime"],features["endTime"],"brighten")
        pass
    if action=='darken':
        clip= edit_video_duration(clip,features["startTime"],features["endTime"],"darken")
        pass
    if action=='animate':
        clip= animate(clip)
        pass
    if action=='monoc':
        clip= monochrome(clip)
        pass
    if action=='Add Text':
        clip= addText(clip,features["text"],features["textPosition"],features["color"],features["fontSize"],features["startTime"],features["endTime"])
        pass
    if finalFit(clip,id) : return True


    

        


def editVideo(clip,commandParams):

    command = commandParams[0] if len(commandParams) > 0 else None
    param = commandParams[1:]
    clip="media/"+str(clip)
    print(command)
    if command=='text':
        clip=addText(createClip(clip),*param)
        print(clip ,command)
        
        if finalFit(clip) : return True
        # mediafile="videos/Out.mp4"   
        # cap = "Outputted Video"
   
        # fVideo = Video(caption=cap,media_file=mediafile)
        # fVideo.save()
        # serializer=VideoSerializer(fVideo)
        # return Response(serializer.data)
        





def createClip(path):
    return VideoFileClip(path)

def trim(clip, start, end):
    return clip.subclip(start, end)

def addText(clip, text, position, color, size,starttime,endTime):
    
    #first map font size string to values
    size_map = {
        'small': 50,
        'medium': 75,
        'large': 100
            }
    size = size_map.get(size, None)
    txt_clip=TextClip(text, fontsize=size, color=color).set_position(position)
    txt_clip = txt_clip.set_start(int(starttime))
    txt_clip = txt_clip.set_duration(endTime)
    return CompositeVideoClip([clip, txt_clip]) 

def finalFit(clip,id):

    clip.write_videofile(f'media/videos/Out{id}.mp4')
    return True
    
    



def blur_helper(image):
    """ Returns a blurred (radius=2 pixels) version of the image """
    return gaussian(image.astype(float), sigma=6)

def blur(clip):
    return clip.fl_image(blur_helper)


def Brighten(clip):
    return  clip.fx(vfx.gamma_corr, 0.5)

def Darken(clip):
    return  clip.fx(vfx.gamma_corr, 1.5)


def animate(clip ):
    return clip.fx(vfx.painting, saturation = 1.6, black = 0.006)

def monochrome(clip):
    return clip.fx(vfx.blackwhite)


def fade_in(clip, duration):
    return clip.fadein(duration)

def fade_out(clip, duration):
    return clip.fadeout(duration)

def speedx(clip, factor):
    return clip.speedx(factor)

def volumex(clip, factor):
    return clip.volumex(factor)

def resize(clip, width, height):
    return clip.resize(width, height)

def crop(clip, x1, y1, x2, y2):
    return clip.crop(x1, y1, x2, y2)



# def set_duration(clip, duration):
#     return clip.set_duration(duration)

# def set_start(clip, start):
#     return clip.set_start(start)

# def set_end(clip, end):
#     return clip.set_end(end)

# def set_position(clip, position):   
#     return clip.set_position(position)

# clip=createClip("media/videos/23/Test1.mp4")
# final = clip.fx( vfx.speedx, 2)



# clip.write_videofile("media/videos/combina5v.mp4")

#------------------------------------------------------------------------helper functions------------------------------------------------------------
def restoreClipSize(clip):
    rotation = clip.rotation
    width = clip.w
    height = clip.h
    if rotation in [90, 270]:
        width, height = height, width
    restoredClip = clip.fx(vfx.resize,(width,height))
    return restoredClip


def edit_video_duration(clip,start_time, end_time,effect_type):
    if start_time <= clip.duration and end_time <= clip.duration:
        if effect_type=="blur":
            edited_sub_clip=clip.subclip(start_time, end_time).fl_image(lambda image: gaussian(image.astype(float), sigma=6))

        elif effect_type=="brighten":
            edited_sub_clip=clip.subclip(start_time, end_time).fx(vfx.gamma_corr, 0.5)

        elif effect_type=="darken":
            edited_sub_clip=clip.subclip(start_time, end_time).fx(vfx.gamma_corr, 1.5)
        # Concatenate the modified subclip with the remaining part of the main video
        edited_video = concatenate_videoclips([clip.subclip(0, start_time),edited_sub_clip,clip.subclip(end_time)])
    return edited_video

def getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime):
    #if there is extracted times the start time will be the minimum of the extracted times and the end time will be the maximum of the extracted times
    #if not then the start time will be the default start time and the end time will be the default end time
    if len(extractedtime) > 0:
        #there is 2 cases for start time 
            #first is to be minimum of the extracted time
            #second is to be invalid start time which is donated by (float('-inf'))
        startTime= float(min(extractedtime)) if float(min(extractedtime))<=defaultEndTime else defaultStartTime
        #there is 3 cases for the end time 
            #first is to be maximum of the extracted time if there is more than one extracted time
            #second is to be equal to -1 which means that there is no end time specified
            #third is to be invalid end time which is donated by (float('-inf')) 
        endTime= float(max(extractedtime)) if float(max(extractedtime)) != startTime and float(max(extractedtime))<=defaultEndTime else defaultEndTime
        # endTime= float('-inf') if float(max(extractedtime))>=defaultEndTime else endTime
        
    else:
        startTime=defaultStartTime
        endTime=defaultEndTime
    return startTime,endTime
# def confirmingUserEditCommand(action,actioning,defaultStartTime,defaultEndTime,startTime,endTime):
#     correctMessage=""
#     errorMessage=""
#     print("------------------------------------",defaultStartTime,defaultEndTime,startTime,endTime)
#     #now we have start time and end time if user already entered the time else we have default values
#     #if there is no start time and no end time and action is trim return this errpr message
#     if startTime==defaultStartTime and endTime==defaultEndTime and action=="trim":
#         errorMessage="You haven't mentioned the time to "+action+", "+actioning+" the whole video won't be useful, please cancel and mention the time"
#     #if there is no start time and no end time and action is not trim return this confirmation message
#     elif startTime==defaultStartTime and endTime==defaultEndTime and action!="trim":
#         correctMessage="please confirm if you want to "+action+" the whole video"
#     elif startTime==defaultStartTime and endTime==-1 and action =="trim":
#         errorMessage="You haven't mentioned the end time to "+action+", "+actioning+" the whole video won't be useful, please cancel and mention the end time"
#     #check if there is valid start time and no end time and action is not trim
#     elif startTime>=defaultStartTime and endTime==-1 and action !="trim":
#         correctMessage=actioning+" the video from second "+str(startTime)+" to the video end, please confirm to proceed"
#     #check if there is valid start time but invalid end time
#     elif startTime>=defaultStartTime and endTime==float('-inf'):
#         errorMessage=actioning+" the video is not possible because the end time you picked is larger than the duration of the video,  please cancel and mention valid end time"
#     #check if there is not valid start time
#     elif startTime==float('-inf'):
#         errorMessage=actioning+" the video is not possible because the start time you picked is larger than the duration of the video,  please cancel and mention valid start time"
#     #this means that he has mentioned both start and end time so we can trim the video
#     #just return a confirmation message that he is gonna trim the video from start time to end time
#     else:
#         correctMessage=actioning+" the video from second "+str(startTime)+" to second "+str(endTime)+" please confirm to proceed"
#     return correctMessage,errorMessage    
# def confirmingUserTextEditCommand(defaultStartTime,defaultEndTime,startTime,endTime,defaultColor,color,defaultSize,size,defaultPosition,position):
#     correctMessage=""
#     errorMessage=""
#     #now we have start time and end time if user already entered the time else we have default values
#     if startTime==defaultStartTime and endTime==defaultEndTime:
#         correctMessage="please confirm if you want to add the text to the whole video"
#     #check if there is valid start time and no end time
#     elif startTime>=defaultStartTime and endTime==-1:
#         correctMessage="Adding the text to the video from "+str(startTime)+" to the video end, please confirm to proceed"
#     #check if there is valid start time but invalid end time
#     elif startTime>=defaultStartTime and endTime==float('-inf'):
#         errorMessage="Adding the text to the video is not possible because the end time you picked is larger than the duration of the video,  please cancel and mention valid end time"
#     #check if there is not valid start time
#     elif startTime==float('-inf'):
#         errorMessage="Adding the text to the video is not possible because the start time you picked is larger than the duration of the video,  please cancel and mention valid start time"
#     #this means that he has mentioned both start and end time so we can trim the video
#     #just return a confirmation message that he is gonna trim the video from start time to end time
#     else:#this means that he has mentioned both start and end time so we can trim the video
#         #next step check for color
#         if color ==defaultColor:
#             correctMessage="please confirm if you want to add default color to the text or cancel to choose your text color"
#         elif size ==defaultSize:
#             correctMessage="please confirm if you want to add default size to the text or cancel to choose your text size"
#         elif position ==defaultPosition:
#             correctMessage="please confirm if you want to add default position to the text or cancel to choose your text position"
#         else:
#             #just return a confirmation message that he is gonna add the text the video from start time to end time with color,size,position
#             correctMessage="Adding the text to the video from second "+str(startTime)+" to second "+str(endTime)+" with color "+color+", size "+str(size)+", position "+position+" please confirm to proceed"
#     return correctMessage,errorMessage            
            


