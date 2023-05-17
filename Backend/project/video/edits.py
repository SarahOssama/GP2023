import re
import cv2
from moviepy.editor import *
from skimage.filters import gaussian
import asyncio
from rest_framework.response import Response

from datetime import datetime, timedelta
from video.serializers import VideoSerializer
from .models import Video
from .edits_functions import *

global i
i=0

    
def preEditVideoNER(entities,reqCommand,clip):
    # Create a Clip with video
    clip="media/"+str(clip)
    clip=createClip(clip)
    actions = ['TRIM','SPEED','TEXT','BLUR','BRIGHT','DARK','ANIMATE','MONOC']
    extractedLabels=[entity.label_ for entity in entities]
    allAction=[entity.label_ for entity in entities if entity.label_ in actions]
    correctMessage=""
    errorMessage=""
    if len(allAction) == 0 :
        # Sorry We Have No Action Given
        errorMessage="Please enter a valid command"
        return correctMessage,errorMessage
    if len(allAction) > 1 :
        # Handle Multiple actions
        errorMessage="multiple actions are not supported"
        return correctMessage,errorMessage
    if len(allAction) == 1 :
        # Handle 1 action
        if 'TRIM' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            #default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("trim","trimming",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage

        if 'TEXT' in extractedLabels:
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            defaultColor = 'black'
            defaultSize = 75
            defaultPosition = 'center'
            # Handle timing for text
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)

            extractedColour=[entity.text for entity in entities if entity.label_ == 'COLOR']
            colour= extractedColour[0] if len(extractedColour) > 0 else defaultColor

            extractedSize=[entity.text for entity in entities if entity.label_ == 'SIZE']
            size= extractedSize[0] if len(extractedSize) > 0 else defaultSize
            size_map = {
                'small': 50,
                'medium': 75,
                'large': 100
            }

            size = size_map.get(size.lower(), None)
            extractedPosition=[entity.text for entity in entities if entity.label_ == 'POSITION']
            position= extractedPosition[0] if len(extractedPosition) > 0 else defaultPosition
    
            ### now we have start time,end time,colour,size,position
            pattern = "'(.*?)'"
            text = re.search(pattern, reqCommand).group(1) 
            correctMessage,errorMessage= confirmingUserTextEditCommand(defaultStartTime,defaultEndTime,startTime,endTime,defaultColor,colour,defaultSize,size,defaultPosition,position)
            return correctMessage,errorMessage
        
        if 'BLUR' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("blur","blurring",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage
        if 'BRIGHT' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("brighten","brightening",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage
        if 'DARK' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("darken","darkening",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage
        if 'ANIMATE' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("animate","animating",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage
        if 'MONOC' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            defaultStartTime=float(0)
            defaultEndTime=float(clip.duration)
            startTime,endTime=getVideoStartAndEndTime(extractedtime,defaultStartTime,defaultEndTime)
            correctMessage,errorMessage= confirmingUserEditCommand("monoc","monocing",defaultStartTime,defaultEndTime,startTime,endTime)
            return correctMessage,errorMessage    
        errorMessage="Please enter a valid command"
        return correctMessage,errorMessage
    
def editVideoNER(clip,entities,reqCommand,id=0):
    # Create a Clip with video
    clip="media/"+str(clip)
    clip=createClip(clip)
    clip=restoreClipSize(clip)
    actions = ['TRIM','SPEED','TEXT','BLUR','BRIGHT','DARK','ANIMATE','MONOC']
    extractedLabels=[entity.label_ for entity in entities]
    allAction=[entity.label_ for entity in entities if entity.label_ in actions]
    print("entities:::",entities)
    # print("extractedLabels:::",extractedLabels)
    # print("allAction:::",allAction)
    if len(allAction) == 0 :
        # Sorry We Have No Action Given
        pass
    if len(allAction) > 1 :
        # Handle Multiple actions
        pass
    if len(allAction) == 1 :
        # Handle 1 action
        if 'TRIM' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            start=0
            end=clip.duration
            # Handle Trim
            start= min(extractedtime) if len(extractedtime) > 0 else start
            end= max(extractedtime) if max(extractedtime) != start else end
            clip= trim(clip,start,end)
            pass
        if 'SPEED' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            factor=1
            # Handle Speed
            factor= extractedtime[0] if len(extractedtime) > 0 else factor
            print(factor)
            clip= speedx(clip,int(factor))
            pass

        if 'TEXT' in extractedLabels:
            
            start=0
            duration=clip.duration
            colour = 'black'
            size = 'medium'
            position = 'center'
            # Handle Trim
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            start= min(extractedtime) if len(extractedtime) > 0 else start
            duration= max(extractedtime) if max(extractedtime) != start else end

            extractedColour=[entity.text for entity in entities if entity.label_ == 'COLOR']
            colour= extractedColour[0] if len(extractedColour) > 0 else colour

            extractedSize=[entity.text for entity in entities if entity.label_ == 'SIZE']
            size= extractedSize[0] if len(extractedSize) > 0 else size
            size_map = {
                'small': 50,
                'medium': 75,
                'large': 100
            }

            size = size_map.get(size.lower(), None)

            extractedWatermark=[entity.text for entity in entities if entity.label_ == 'TEXT']
            watermark= True if extractedWatermark[0]=="watermark" else False

            extractedPosition=[entity.text for entity in entities if entity.label_ == 'POSITION']
            position= extractedPosition[0] if len(extractedPosition) > 0 else position

            pattern = "'(.*?)'"
            text = re.search(pattern, reqCommand).group(1)
            print(text,position,colour,size,start,duration)    
            clip= addText(clip,watermark,text,position,colour,size,start,duration)
            pass
        
        if 'BLUR' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            start=0
            end=clip.duration
            start= min(extractedtime) if len(extractedtime) > 0 else start
            end= max(extractedtime) if max(extractedtime) != start else end
            clip= edit_video_duration(clip,int(start),int(end),"blur")
            pass

        if 'BRIGHT' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            start=0
            end=clip.duration
            start= min(extractedtime) if len(extractedtime) > 0 else start
            end= max(extractedtime) if max(extractedtime) != start else end
            clip= edit_video_duration(clip,int(start),int(end),"brighten")
            pass

        if 'DARK' in extractedLabels:
            extractedtime=[entity.text for entity in entities if entity.label_ == 'TIME']
            start=0
            end=clip.duration
            start= min(extractedtime) if len(extractedtime) > 0 else start
            end= max(extractedtime) if max(extractedtime) != start else end
            clip= edit_video_duration(clip,int(start),int(end),"darken")
            pass

        if 'ANIMATE' in extractedLabels:
            clip= animate(clip)
            pass

        if 'MONOC' in extractedLabels:
            clip= monochrome(clip)
            pass
        pass


    if finalFit(clip,id) : return True


    

        
    



def createClip(path):
    return VideoFileClip(path)

def trim(clip, start, end):
    return clip.subclip(start, end)

def addText(clip, watermark,text='Hello Test', position='center', color='black', size=75,starttime=0,duration=5):
    if watermark :
        starttime=0
        duration=5
        txt_clip=TextClip(text, font ='cursive' ,fontsize=size, color=color).set_position(position)
        txt_clip = txt_clip.set_start(int(starttime))
        txt_clip = txt_clip.set_duration(duration)
    else:  
        starttime=0
        duration=5
        # duration=int(duration) if int(duration) < clip.duration else clip.duration
        # print(position,color,size,int(starttime),duration)
        txt_clip=TextClip(text, fontsize=size, color=color).set_position(position)
        txt_clip = txt_clip.set_start(int(starttime))
        txt_clip = txt_clip.set_duration(duration)
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
