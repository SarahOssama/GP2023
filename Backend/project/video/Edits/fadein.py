import subprocess


def fade_in_video(input_file, fade_duration, output_file):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                               # Input video file
        '-vf', f'fade=t=in:st=0:d={fade_duration}',      # Apply fade in effect
        # # Apply audio fade in effect
        # '-af', f'afade=t=in:st=0:d={fade_duration}',
        '-c:v', 'libx264',                                 # Copy video stream
        '-c:a', 'copy',                                 # Copy audio stream
        '-y',                                           # Overwrite output file if it exists
        output_file                                     # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_fadein.mp4"

fade_duration = 2  # Fade in duration in seconds


fade_in_video(input_file, fade_duration, output_file)

################################################################################
