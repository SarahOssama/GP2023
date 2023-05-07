import re
from moviepy.editor import *
from skimage.filters import gaussian
import asyncio
from rest_framework.response import Response


from video.serializers import VideoSerializer
from .models import Video


global i
i=0


def editVideoNER(clip,entities,reqCommand,id):

    # Create a Clip with video
    clip="media/"+str(clip)
    clip=createClip(clip)
    print(clip.size)
    #,clip.duration,clip.fps,clip.w,clip.h,clip.ro

    actions = ['TRIM','SPEED','TEXT','BLUR','BRIGHT','DARK','ANIMATE','MONOC']
    extractedLabels=[entity.label_ for entity in entities]
    allAction=[entity.label_ for entity in entities if entity.label_ in actions]
    

    edits_Items = [[ent.label_,ent.text] for ent in entities]
    print(edits_Items)
    print(allAction)
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
            size = 75
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


            extractedPosition=[entity.text for entity in entities if entity.label_ == 'POSITION']
            position= extractedPosition[0] if len(extractedPosition) > 0 else position

            pattern = "'(.*?)'"
            text = re.search(pattern, reqCommand).group(1)
            print(text,position,colour,size,start,duration)    
            clip= addText(clip,text,position,colour,size,start,duration)
            pass
        
        if 'BLUR' in extractedLabels:
            clip= blur(clip)
            pass

        if 'BRIGHT' in extractedLabels:
            clip= Brighten(clip)
            
            pass

        if 'DARK' in extractedLabels:
            clip= Darken(clip)
            pass

        if 'ANIMATE' in extractedLabels:
            clip= animate(clip)
            pass

        if 'MONOC' in extractedLabels:
            clip= monochrome(clip)
            pass
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

def addText(clip, text='Hello Test', position='center', color='black', size=75,starttime=0,duration=5):
    starttime=0
    duration=5
    # duration=int(duration) if int(duration) < clip.duration else clip.duration
    # print(position,color,size,int(starttime),duration)
    txt_clip=TextClip(text, fontsize=size, color=color).set_position(position)
    txt_clip = txt_clip.set_start(int(starttime))
    txt_clip = txt_clip.set_duration(duration)
    return CompositeVideoClip([clip, txt_clip]) 

def finalFit(clip,id, width=848, height=1280):
    combine = clips_array([[clip]])
    cambiado = combine.fx(vfx.resize,(width,height),width= width)
    print("Hamada in final fit")
    cambiado.write_videofile(f'media/videos/Out{id}.mp4')
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



