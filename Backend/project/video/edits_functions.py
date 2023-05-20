from moviepy.editor import *
from skimage.filters import gaussian

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

