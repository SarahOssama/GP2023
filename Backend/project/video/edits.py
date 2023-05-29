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
from .edits_applied import *


def preEditVideoNERNew(entities, reqCommand, clip):
    # Create a Clip with video
    clip = "media/"+str(clip)
    clip = createClip(clip)
    actions = ['TRIM', 'SPEED', 'TEXT', 'BLUR',
               'BRIGHT', 'DARK', 'ANIMATE', 'MONOC', 'FADEIN', 'FADEOUT', 'SLIDEIN', 'SLIDEOUT']
    colours = ['red', 'black', 'blue', 'yellow', 'green',
               'white', 'pink', 'orange', 'brown', 'brown']
    extractedLabels = [entityLabel for text, entityLabel in entities]
    allAction = [
        entityLabel for text, entityLabel in entities if entityLabel in actions]
    edit_features = {}
    # default start time will have the value 0 and default end time will have the value of the duration of the video
    defaultStartTime = float(0)
    defaultEndTime = float(clip.duration)
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
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("trim", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'TEXT' in extractedLabels:

            defaultColor = 'black'
            defaultSize = "medium"
            defaultPosition = 'center'
            # now extract the actual values if found from the user command
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']
            extractedColour = [
                text for text, entityLabel in entities if text.lower() in colours]
            extractedSize = [
                text for text, entityLabel in entities if entityLabel == 'SIZE']
            extractedPosition = [
                text for text, entityLabel in entities if entityLabel == 'POSITION']
            extractedWatermark = [
                text for text, entityLabel in entities if entityLabel == 'TEXT']
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
                text for text, entityLabel in entities if entityLabel == 'TIME']

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
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("brighten", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'DARK' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("darken", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'SPEED' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']
            print(extractedtime)
            # detect if there's an x
            x_position = extractedtime.index(
                'x') if 'x' in extractedtime else False
            # filter factor
            if x_position:
                factor = float(extractedtime[x_position+1])
                # remove x and number
                del extractedtime[x_position+1]
                del extractedtime[x_position]
            else:
                # check which element is x
                x_index = [extractedtime.index(t)
                           for t in extractedtime if 'x' in t]
                x_index = x_index[0] if len(x_index) > 0 else False
                if x_index:
                    factor = float(extractedtime[x_index][1:])
                    del extractedtime[x_index]
                else:
                    factor = 1

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime,
                        "endTime": endTime, "factor": factor}
            edit_features = getEditFeatures("speed", features)
            edit_features["videoDuration"] = defaultEndTime

            return edit_features

        if 'ANIMATE' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("animate", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'MONOC' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("monoc", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'FADEIN' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": endTime}
            return getEditFeatures("fadein", features)

        if 'FADEOUT' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("fadeout", features)

        if 'SLIDEIN' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("slidein", features)

        if 'SLIDEOUT' in extractedLabels:
            extractedtime = [
                text for text, entityLabel in entities if entityLabel == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("slideout", features)

    return edit_features


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
    # default start time will have the value 0 and default end time will have the value of the duration of the video
    defaultStartTime = float(0)
    defaultEndTime = float(clip.duration)
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

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("trim", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'TEXT' in extractedLabels:

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

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("brighten", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'DARK' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("darken", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'ANIMATE' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("animate", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'MONOC' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            edit_features = getEditFeatures("monoc", features)
            edit_features["videoDuration"] = defaultEndTime
            return edit_features

        if 'FADEIN' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": endTime}
            return getEditFeatures("fadein", features)

        if 'FADEOUT' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("fadeout", features)

        if 'SLIDEIN' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("slidein", features)

        if 'SLIDEOUT' in extractedLabels:
            extractedtime = [
                entity.text for entity in entities if entity.label_ == 'TIME']

            startTime, endTime = getVideoStartAndEndTime(
                extractedtime, defaultStartTime, defaultEndTime)
            # Call to get Edit features and send Parameters
            # PS Message has default value : "Confirm your Edit Command"
            features = {"startTime": startTime, "endTime": endTime}
            return getEditFeatures("slideout", features)

    return edit_features


def editConfirmedVideo(clip, action, features, new_clip=None, id=0, edited_versions_count=0):
    # Create a Clip with video
    clip = "media/"+str(clip)
    clip = createClip(clip)
    clip = restoreClipSize(clip)
    # Create new Clip
    if new_clip:
        new_clip = "media/"+str(new_clip)
        new_clip = createClip(new_clip)
        new_clip = new_clip if isinstance(
            new_clip, ImageClip) else restoreClipSize(new_clip)
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
        if action == 'fadein' or action == 'fadeout':
            clip = fade(clip, new_clip, features["startTime"])
            pass
        if action == 'slidein' or action == 'slideout':
            clip = slide(clip, new_clip, features["startTime"])
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
    content_type = path.split('.')[-1]
    valid_extensions = ['mp4', 'mov', 'avi']
    if content_type in valid_extensions:
        return VideoFileClip(path)
    else:
        return ImageClip(path, duration=1)


def finalFit(clip, id, edited_versions_count):
    clip.write_videofile(
        f'media/videos/Out_{id}_{edited_versions_count}.mp4', codec="libx264")
    return True
