from moviepy.editor import *
from skimage.filters import gaussian
from .edits_functions import *


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


def fadein(main_clip, new_clip, padding=-1, duration=2):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    clips = [main_clip, new_clip]

    faded_clips = [CompositeVideoClip(
        [clip.fx(transfx.crossfadein, duration=duration)])for clip in clips]
    final_clip = concatenate_videoclips(faded_clips, padding=padding)

    return final_clip


def fadeout(main_clip, new_clip, padding=-1, duration=2):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    clips = [main_clip, new_clip]

    faded_clips = [CompositeVideoClip(
        [clip.fx(transfx.crossfadeout, duration=duration)])for clip in clips]
    final_clip = concatenate_videoclips(faded_clips, padding=padding)

    return final_clip


def slidein(main_clip, new_clip, padding=-1, duration=2, side="left"):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    clips = [main_clip, new_clip]
    slided_clips = [CompositeVideoClip(
        [clip.fx(transfx.slide_in, duration=duration, side=side)])for clip in clips]
    final_clip = concatenate_videoclips(slided_clips, padding=padding)
    return final_clip


def slideout(main_clip, new_clip, padding=-1, duration=2, side="left"):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    clips = [main_clip, new_clip]
    slided_clips = [CompositeVideoClip(
        [clip.fx(transfx.slide_out, duration=duration, side=side)])for clip in clips]
    final_clip = concatenate_videoclips(slided_clips, padding=padding)
    return final_clip


def fade(main_clip, new_clip, startTime):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    # Specify the fade duration in seconds
    fade_duration = 1

    # Split the main video into two parts at the desired point where you want to insert the new video
    start_time = startTime  # Specify the start time in seconds
    end_time = new_clip.duration    # Specify the end time in seconds

    part1 = main_clip.subclip(0, start_time)
    part2 = main_clip.subclip(end_time, main_clip.duration)

    # Apply fade-in effect to the new video
    new_clip_fadein = new_clip.fx(transfx.crossfadein, fade_duration)

    # Apply fade-out effect to the second part of the main video
    part2_fadeout = part2.fx(transfx.crossfadeout, fade_duration)

    # Concatenate the clips with fade effects
    final_video = concatenate_videoclips(
        [part1, new_clip_fadein, part2_fadeout])
    return final_video


def slide(main_clip, new_clip, startTime, side="left"):
    if main_clip.h < new_clip.h:
        default_width = main_clip.w
        default_height = main_clip.h
    else:
        default_height = new_clip.h
        default_width = new_clip.w
    main_clip = fitSizePadding(
        main_clip, height_default=default_height, width_default=default_width)
    new_clip = fitSizePadding(
        new_clip, height_default=default_height, width_default=default_width)

    # Specify the slide duration in seconds
    slide_duration = 3

    # Split the main video into two parts at the desired point where you want to insert the new video
    start_time = startTime  # Specify the start time in seconds
    end_time = new_clip.duration    # Specify the end time in seconds

    part1 = main_clip.subclip(0, start_time)
    part2 = main_clip.subclip(end_time, main_clip.duration)

    # Apply slide-in effect to the new video
    new_clip_slidein = new_clip.fx(transfx.slide_in, slide_duration, side)

    # Apply slide-out effect to the second part of the main video
    part2_slideout = part2.fx(transfx.slide_out, slide_duration, side)

    # Concatenate the clips with slide effects
    final_video = concatenate_videoclips(
        [part1, new_clip_slidein, part2_slideout])
    return final_video
