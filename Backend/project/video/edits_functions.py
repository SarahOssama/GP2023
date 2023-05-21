from moviepy.editor import *
from skimage.filters import gaussian

# ------------------------------------------------------------------------helper functions------------------------------------------------------------


def restoreClipSize(clip):
    rotation = clip.rotation
    width = clip.w
    height = clip.h
    if rotation in [90, 270]:
        width, height = height, width
    restoredClip = clip.fx(vfx.resize, (width, height))
    return restoredClip
    # combine = clips_array([[clip]])
    # cambiado = combine.fx(vfx.resize, (848, 1280), width=848)
    # return cambiado


def fitSizePadding(clip1, clip2):
    # print(clip1.size,clip2.size)
    # Compare the widths of the two clips
    if clip1.w == clip2.w and clip1.h == clip2.h:
        return clip1, clip2
    if clip1.w > clip2.w:
        # Resize clip2 to match the width of clip1 and add black padding
        # clip2_resized = resize(clip2, width=clip1.w)
        padding_size_W = (clip1.w - clip2.w) // 2
        padding_size_H = (clip1.h - clip2.h) // 2
        # print(padding_size_W,padding_size_H)
        clip2 = clip2.fx(vfx.margin, left=padding_size_W, right=padding_size_W,
                         top=padding_size_H, bottom=padding_size_H, color=(0, 0, 0))
    else:
        # Resize clip1 to match the width of clip2 and add black padding
        # clip1_resized = resize(clip1, width=clip2.w)
        padding_size_W = (clip2.w - clip1.w) // 2
        padding_size_H = (clip2.h - clip1.h) // 2
        # print(padding_size_W,padding_size_H)
        clip1 = clip1.fx(vfx.margin, left=padding_size_W, right=padding_size_W,
                         top=padding_size_H, bottom=padding_size_H, color=(0, 0, 0))
    return clip1, clip2


def edit_video_duration(clip, start_time, end_time, effect_type):
    if start_time <= clip.duration and end_time <= clip.duration:
        if effect_type == "blur":
            edited_sub_clip = clip.subclip(start_time, end_time).fl_image(
                lambda image: gaussian(image.astype(float), sigma=6))

        elif effect_type == "brighten":
            edited_sub_clip = clip.subclip(
                start_time, end_time).fx(vfx.gamma_corr, 0.5)

        elif effect_type == "darken":
            edited_sub_clip = clip.subclip(
                start_time, end_time).fx(vfx.gamma_corr, 1.5)
        # Concatenate the modified subclip with the remaining part of the main video
        edited_video = concatenate_videoclips(
            [clip.subclip(0, start_time), edited_sub_clip, clip.subclip(end_time)])
    return edited_video


def getVideoStartAndEndTime(extractedtime, defaultStartTime, defaultEndTime):
    # if there is extracted times the start time will be the minimum of the extracted times and the end time will be the maximum of the extracted times
    # if not then the start time will be the default start time and the end time will be the default end time
    # print(extractedtime, defaultStartTime, defaultEndTime)
    extractedtime = [float(i) for i in extractedtime]
    if len(extractedtime) > 0:
        # there is 2 cases for start time
        # first is to be minimum of the extracted time
        # second is to be invalid start time which is donated by (float('-inf'))
        startTime = float(min(extractedtime)) if float(
            min(extractedtime)) <= defaultEndTime else defaultStartTime
        # there is 3 cases for the end time
        # first is to be maximum of the extracted time if there is more than one extracted time
        # second is to be equal to -1 which means that there is no end time specified
        # third is to be invalid end time which is donated by (float('-inf'))
        endTime = float(max(extractedtime)) if float(max(extractedtime)) != startTime and float(
            max(extractedtime)) <= defaultEndTime else defaultEndTime
        # endTime= float('-inf') if float(max(extractedtime))>=defaultEndTime else endTime

    else:
        startTime = defaultStartTime
        endTime = defaultEndTime
    # print(startTime, endTime)
    return startTime, endTime


def getEditFeatures(action: str, features: dict, message="Confirm your Edit Command"):
    edit_features = {}
    edit_features["message"] = message
    edit_features["action"] = action
    edit_features["features"] = features
    return edit_features
