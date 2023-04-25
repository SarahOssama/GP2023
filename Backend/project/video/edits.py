from moviepy.editor import *
import asyncio
from rest_framework.response import Response


from video.serializers import VideoSerializer
from .models import Video


global i
i=0


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

def addText(clip, text='Hello Test', position='center', color='black', size=75,starttime=0,duration=5):
    starttime=0
    duration=5
    # duration=int(duration) if int(duration) < clip.duration else clip.duration
    # print(position,color,size,int(starttime),duration)
    txt_clip=TextClip(text, fontsize=size, color=color).set_position(position)
    txt_clip = txt_clip.set_start(int(starttime))
    txt_clip = txt_clip.set_duration(duration)
    return CompositeVideoClip([clip, txt_clip]) 

def finalFit(clip, width=848, height=1280):
    combine = clips_array([[clip]])
    cambiado = combine.fx(vfx.resize,(width,height),width= width)
    print("Hamada in final fit")
    cambiado.write_videofile("media/videos/Out.mp4")
    return True
    
    
    


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



