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


def preEditVideoNER(entities, reqCommand, clip):
    # Create a Clip with video
    clip = "media/"+str(clip)
    clip = createClip(clip)
    actions = ['TRIM', 'SPEED', 'TEXT', 'BLUR',
               'BRIGHT', 'DARK', 'ANIMATE', 'MONOC', 'FADEIN', 'FADEOUT', 'SLIDEIN', 'SLIDEOUT']
    extractedLabels = [entity.label_ for entity in entities]
    allAction = [
        entity.label_ for entity in entities if entity.label_ in actions]
    edit_features = {}
    if len(allAction) == 0:
        # Sorry We Have No Action Given
        edit_features["message"] = "Please enter a valid command"
        return edit_features
    if len(allAction) > 1:
        # Handle Multiple actions
        edit_features["message"] = "Multiple actions are not supported yet"
        return edit_features
    if len(allAction) == 1:
        # Handle 1 action
        if 'TRIM' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("trim", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'TEXT' in extractedLabels:
            # first intialize default values for color,size,position,start time and end time
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            defaultColor = 'black'
            defaultSize = "medium"
            defaultPosition = 'center'
            # now extract the actual values if found from the user command
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            extractedColour = [
                entity.text for entity in entities if entity.label_ == 'COLOR']
            extractedSize = [
                entity.text for entity in entities if entity.label_ == 'SIZE']
            extractedPosition = [
                entity.text for entity in entities if entity.label_ == 'POSITION']
            extractedWatermark = [
                entity.text for entity in entities if entity.label_ == 'TEXT']
            watermark = True if extractedWatermark[0] == "watermark" else False
            # now check if the extracted values are valid or not and if not then use the default values
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            colour = extractedColour[0] if len(
                extractedColour) > 0 else defaultColor
            size = extractedSize[0] if len(extractedSize) > 0 else defaultSize
            position = extractedPosition[0] if len(
                extractedPosition) > 0 else defaultPosition
            # now extract the text from the user command
            text = ""
            pattern = "'(.*?)'"
            match = re.search(pattern, reqCommand)
            if match is not None:
                text = match.group(1)
            else:
                # Handle the case when no match is found
                text = ""
            # now either i got features from user or i give him default features
            # now lets return our response to the user
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            action = "Add Text" if watermark == False else "Add Watermark"
            features = {"startTime": startTime, "endTime": endTime, "color": colour, "fontSize": size, "textPosition": position, "listOfAvailableColors": [
                'black', 'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'magenta', 'grey', 'lightgrey'], "listOfAvailableSizes": ['small', 'medium', 'large'], "listOfAvailablePositions": ['center', 'top', 'bottom'], "text": text}
            edit_features = getEditFeatures(action, features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'BLUR' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            print(extractedtime)
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("blur", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'BRIGHT' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            #   PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("brighten", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'DARK' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            #   PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("darken", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'ANIMATE' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            #   PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("animate", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'MONOC' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']
            # default start time will have the value 0 and default end time will have the value of the duration of the video
            defaultStartTime = float(0)
            defaultEndTime = float(clip.duration)
            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            #   PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("monoc", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'FADEIN' in extractedLabels:
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            return getEditFeatures("fadein", {})

        if 'FADEOUT' in extractedLabels:
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            return getEditFeatures("fadeout", {})

        if 'SLIDEIN' in extractedLabels:
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            return getEditFeatures("slidein", {})

        if 'SLIDEOUT' in extractedLabels:
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            return getEditFeatures("slideout", {})

    return edit_features


def editConfirmedVideo(clip, action, features, new_clip=None, id=0, edited_versions_count=0):
    # Create a Clip with video
    clip = "media/"+str(clip)
    clip = createClip(clip)
    clip = restoreClipSize(clip)
    # Create new Clip
    if new_clip is not None:
        new_clip = "media/"+str(new_clip)
        new_clip = createClip(new_clip)
        new_clip = restoreClipSize(new_clip)
    if features != {}:
        if action == 'trim':
            clip = trim(clip, features["startTime"], features["endTime"])
            pass
        if action == 'blur':
            clip = edit_video_duration(
                clip, features["startTime"], features["endTime"], "blur")
            pass
        if action == 'brighten':
            clip = edit_video_duration(
                clip, features["startTime"], features["endTime"], "brighten")
            pass
        if action == 'darken':
            clip = edit_video_duration(
                clip, features["startTime"], features["endTime"], "darken")
            pass
        if action == 'animate':
            clip = animate(clip)
            pass
        if action == 'monoc':
            clip = monochrome(clip)
            pass
        if action == 'Add Text':
            clip = addText(clip, features["text"], features["textPosition"], features["color"],
                           features["fontSize"], features["startTime"], features["endTime"])
            pass
        if action == 'Add Watermark':
            clip = addText(clip, features["text"], features["textPosition"], features["color"],
                           features["fontSize"], features["startTime"], features["endTime"], True)
            pass
    else:
        if action == 'fadein':
            clip = fadein(clip, new_clip)
            pass
        if action == 'fadeout':
            clip = fadeout(clip, new_clip)
            pass
        if action == 'slidein':
            clip = slidein(clip, new_clip)
            pass
        if action == 'slideout':
            clip = slideout(clip, new_clip)
            pass
    if finalFit(clip, id, edited_versions_count):
        return True


def createClip(path):
    return VideoFileClip(path)


def trim(clip, start, end):
    return clip.subclip(start, end)


def addText(clip, text, position, color, size, startTime, endTime, watermark=False):
    # first map font size string to values
    size_map = {
        'small': 50,
        'medium': 75,
        'large': 100
    }
    size = size_map.get(size, None)
    if watermark:

        txt_clip = TextClip(text, font='Aldhabi', fontsize=size,
                            color=color).set_position((position, 'bottom'))
        txt_clip = txt_clip.set_start(int(startTime))
        txt_clip = txt_clip.set_duration(endTime)
    else:

        # duration=int(duration) if int(duration) < clip.duration else clip.duration
        # print(position,color,size,int(starttime),duration)
        txt_clip = TextClip(text, fontsize=size,
                            color=color).set_position(position)
        txt_clip = txt_clip.set_start(int(startTime))
        txt_clip = txt_clip.set_duration(endTime)
    return CompositeVideoClip([clip, txt_clip])


def finalFit(clip, id, edited_versions_count):
    clip.write_videofile(f'media/videos/Out_{id}_{edited_versions_count}.mp4')
    return True


def blur_helper(image):
    """ Returns a blurred (radius=2 pixels) version of the image """
    return gaussian(image.astype(float), sigma=6)


def blur(clip):
    return clip.fl_image(blur_helper)


def Brighten(clip):
    return clip.fx(vfx.gamma_corr, 0.5)


def Darken(clip):
    return clip.fx(vfx.gamma_corr, 1.5)


def animate(clip):
    return clip.fx(vfx.painting, saturation=1.6, black=0.006)


def monochrome(clip):
    return clip.fx(vfx.blackwhite)


def speedx(clip, factor):
    return clip.speedx(factor)


def fadein(clip1, clip2, padding=-1, duration=2):
    clip1, clip2 = fitSizePadding(clip1, clip2)
    clips = [clip1, clip2]

    faded_clips = [CompositeVideoClip(
        [clip.fx(transfx.crossfadein, duration=duration)])for clip in clips]
    final_clip = concatenate_videoclips(faded_clips, padding=padding)

    return final_clip


def fadeout(clip1, clip2, padding=-1, duration=2):
    clip1, clip2 = fitSizePadding(clip1, clip2)
    clips = [clip1, clip2]

    faded_clips = [CompositeVideoClip(
        [clip.fx(transfx.crossfadeout, duration=duration)])for clip in clips]
    final_clip = concatenate_videoclips(faded_clips, padding=padding)

    return final_clip


def slidein(clip1, clip2, padding=-1, duration=2, side="left"):
    clip1, clip2 = fitSizePadding(clip1, clip2)
    clips = [clip1, clip2]
    slided_clips = [CompositeVideoClip(
        [clip.fx(transfx.slide_in, duration=duration, side=side)])for clip in clips]
    final_clip = concatenate_videoclips(slided_clips, padding=padding)
    return final_clip


def slideout(clip1, clip2, padding=-1, duration=2, side="left"):
    clip1, clip2 = fitSizePadding(clip1, clip2)
    clips = [clip1, clip2]
    slided_clips = [CompositeVideoClip(
        [clip.fx(transfx.slide_out, duration=duration, side=side)])for clip in clips]
    final_clip = concatenate_videoclips(slided_clips, padding=padding)
    return final_clip


# def volumex(clip, factor):
#     return clip.volumex(factor)

# def resize(clip, width, height):
#     return clip.resize(width, height)

# def crop(clip, x1, y1, x2, y2):
#     return clip.crop(x1, y1, x2, y2)


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

# def editVideoNER(clip, entities, reqCommand, id=0, edited_versions_count=0):
#     # Create a Clip with video
#     clip = "media/"+str(clip)
#     clip = createClip(clip)
#     clip = restoreClipSize(clip)
#     actions = ['TRIM', 'SPEED', 'TEXT', 'BLUR',
#                'BRIGHT', 'DARK', 'ANIMATE', 'MONOC']
#     extractedLabels = [entity.label_ for entity in entities]
#     allAction = [
#         entity.label_ for entity in entities if entity.label_ in actions]
#     print("entities:::", entities)
#     # print("extractedLabels:::",extractedLabels)
#     # print("allAction:::",allAction)
#     if len(allAction) == 0:
#         # Sorry We Have No Action Given
#         pass
#     if len(allAction) > 1:
#         # Handle Multiple actions
#         pass
#     if len(allAction) == 1:
#         # Handle 1 action
#         if 'TRIM' in extractedLabels:
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             start = 0
#             end = clip.duration
#             # Handle Trim
#             start = min(extractedtime) if len(extractedtime) > 0 else start
#             end = max(extractedtime) if max(extractedtime) != start else end
#             clip = trim(clip, start, end)
#             pass
#         if 'SPEED' in extractedLabels:
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             factor = 1
#             # Handle Speed
#             factor = extractedtime[0] if len(extractedtime) > 0 else factor
#             print(factor)
#             clip = speedx(clip, int(factor))
#             pass

#         if 'TEXT' in extractedLabels:

#             start = 0
#             duration = clip.duration
#             colour = 'black'
#             size = 'medium'
#             position = 'center'
#             # Handle Trim
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             start = min(extractedtime) if len(extractedtime) > 0 else start
#             duration = max(extractedtime) if max(
#                 extractedtime) != start else duration

#             extractedColour = [
#                 entity.text for entity in entities if entity.label_ == 'COLOR']
#             colour = extractedColour[0] if len(extractedColour) > 0 else colour

#             extractedSize = [
#                 entity.text for entity in entities if entity.label_ == 'SIZE']
#             size = extractedSize[0] if len(extractedSize) > 0 else size
#             size_map = {
#                 'small': 50,
#                 'medium': 75,
#                 'large': 100
#             }

#             size = size_map.get(size.lower(), None)

#             extractedWatermark = [
#                 entity.text for entity in entities if entity.label_ == 'TEXT']
#             watermark = True if extractedWatermark[0] == "watermark" else False

#             extractedPosition = [
#                 entity.text for entity in entities if entity.label_ == 'POSITION']
#             position = extractedPosition[0] if len(
#                 extractedPosition) > 0 else position

#             pattern = "'(.*?)'"
#             text = re.search(pattern, reqCommand).group(1)
#             print(text, position, colour, size, start, duration)
#             clip = addText(clip, watermark, text, position,
#                            colour, size, start, duration)
#             pass

#         if 'BLUR' in extractedLabels:
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             start = 0
#             end = clip.duration
#             start = min(extractedtime) if len(extractedtime) > 0 else start
#             end = max(extractedtime) if max(extractedtime) != start else end
#             clip = edit_video_duration(clip, int(start), int(end), "blur")
#             pass

#         if 'BRIGHT' in extractedLabels:
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             start = 0
#             end = clip.duration
#             start = min(extractedtime) if len(extractedtime) > 0 else start
#             end = max(extractedtime) if max(extractedtime) != start else end
#             clip = edit_video_duration(clip, int(start), int(end), "brighten")
#             pass

#         if 'DARK' in extractedLabels:
#             extractedtime = [
#                 entity.text for entity in entities if entity.label_ == 'TIME']
#             start = 0
#             end = clip.duration
#             start = min(extractedtime) if len(extractedtime) > 0 else start
#             end = max(extractedtime) if max(extractedtime) != start else end
#             clip = edit_video_duration(clip, int(start), int(end), "darken")
#             pass

#         if 'ANIMATE' in extractedLabels:
#             clip = animate(clip)
#             pass

#         if 'MONOC' in extractedLabels:
#             clip = monochrome(clip)
#             pass
#         pass

#     if finalFit(clip, id, edited_versions_count):
#         return True
