import subprocess
import re


def get_video_duration(input_file):
    result = subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of',
                            'default=noprint_wrappers=1:nokey=1', input_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    output = result.stdout.strip()
    duration = float(output)
    return duration


def fade_out_video(input_file, fade_duration, output_file):
    duration = get_video_duration(input_file)
    fade_start = duration - fade_duration

    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                               # Input video file
        # Apply fade out effect
        '-vf', f'fade=t=out:st={fade_start}:d={fade_duration}',
        # # Apply audio fade out effect
        # '-af', f'afade=t=out:st={fade_start}:d={fade_duration}',
        # Re-encode video using libx264 codec
        '-c:v', 'libx264',
        '-c:a', 'copy',                                 # Copy audio stream
        '-y',                                           # Overwrite output file if it exists
        output_file                                     # Output file
    ])


################################## Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_fadeout.mp4"

fade_duration = 2  # Fade in duration in seconds


fade_out_video(input_file, fade_duration, output_file)

################################################################################
