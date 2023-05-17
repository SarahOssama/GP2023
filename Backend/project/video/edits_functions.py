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
    print("extractedtime",extractedtime,"defaultStartTime",defaultStartTime,"defaultEndTime",defaultEndTime)
    if len(extractedtime) > 0:
        #there is 2 cases for start time 
            #first is to be minimum of the extracted time
            #second is to be invalid start time which is donated by (float('-inf'))
        startTime= float(min(extractedtime)) if float(min(extractedtime))<=defaultEndTime else float('-inf')
        #there is 3 cases for the end time 
            #first is to be maximum of the extracted time if there is more than one extracted time
            #second is to be equal to -1 which means that there is no end time specified
            #third is to be invalid end time which is donated by (float('-inf')) 
        endTime= float(max(extractedtime)) if float(max(extractedtime)) != startTime else -1
        endTime= float('-inf') if float(max(extractedtime))>=defaultEndTime else endTime
    else:
        startTime=defaultStartTime
        endTime=defaultEndTime
    return startTime,endTime
def confirmingUserEditCommand(action,actioning,defaultStartTime,defaultEndTime,startTime,endTime):
    correctMessage=""
    errorMessage=""
    print("------------------------------------",defaultStartTime,defaultEndTime,startTime,endTime)
    #now we have start time and end time if user already entered the time else we have default values
    if startTime==defaultStartTime and endTime==defaultEndTime and action=="trim":
        errorMessage="You haven't mentioned the time to "+action+", "+actioning+" the whole video won't be useful, please cancel and mention the time"
    elif startTime==defaultStartTime and endTime==defaultEndTime and action!="trim":
        correctMessage="please confirm if you want to "+action+" the whole video"
    #check if there is valid start time and no end time
    elif startTime>=defaultStartTime and endTime==-1:
        correctMessage=actioning+" the video from second "+str(startTime)+" to the video end, please confirm to proceed"
    #check if there is valid start time but invalid end time
    elif startTime>=defaultStartTime and endTime==float('-inf'):
        errorMessage=actioning+" the video is not possible because the end time you picked is larger than the duration of the video,  please cancel and mention valid end time"
    #check if there is not valid start time
    elif startTime==float('-inf'):
        errorMessage=actioning+" the video is not possible because the start time you picked is larger than the duration of the video,  please cancel and mention valid start time"
    #this means that he has mentioned both start and end time so we can trim the video
    #just return a confirmation message that he is gonna trim the video from start time to end time
    else:
        correctMessage=actioning+" the video from second "+str(startTime)+" to second "+str(endTime)+" please confirm to proceed"
    return correctMessage,errorMessage    
def confirmingUserTextEditCommand(defaultStartTime,defaultEndTime,startTime,endTime,defaultColor,color,defaultSize,size,defaultPosition,position):
    correctMessage=""
    errorMessage=""
    #now we have start time and end time if user already entered the time else we have default values
    if startTime==defaultStartTime and endTime==defaultEndTime:
        correctMessage="please confirm if you want to add the text to the whole video"
    #check if there is valid start time and no end time
    elif startTime>=defaultStartTime and endTime==-1:
        correctMessage="Adding the text to the video from "+str(startTime)+" to the video end, please confirm to proceed"
    #check if there is valid start time but invalid end time
    elif startTime>=defaultStartTime and endTime==float('-inf'):
        errorMessage="Adding the text to the video is not possible because the end time you picked is larger than the duration of the video,  please cancel and mention valid end time"
    #check if there is not valid start time
    elif startTime==float('-inf'):
        errorMessage="Adding the text to the video is not possible because the start time you picked is larger than the duration of the video,  please cancel and mention valid start time"
    #this means that he has mentioned both start and end time so we can trim the video
    #just return a confirmation message that he is gonna trim the video from start time to end time
    else:#this means that he has mentioned both start and end time so we can trim the video
        #next step check for color
        if color ==defaultColor:
            correctMessage="please confirm if you want to add default color to the text or cancel to choose your text color"
        elif size ==defaultSize:
            correctMessage="please confirm if you want to add default size to the text or cancel to choose your text size"
        elif position ==defaultPosition:
            correctMessage="please confirm if you want to add default position to the text or cancel to choose your text position"
        else:
            #just return a confirmation message that he is gonna add the text the video from start time to end time with color,size,position
            correctMessage="Adding the text to the video from second "+str(startTime)+" to second "+str(endTime)+" with color "+color+", size "+str(size)+", position "+position+" please confirm to proceed"
    return correctMessage,errorMessage            
            


