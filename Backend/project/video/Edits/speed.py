import subprocess


def speed_up_video(input_file, output_file, speed):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                 # Input video file
        # Apply speed effect to video and audio
        '-filter_complex', f'[0:v]setpts={1/speed}*PTS[v];[0:a]atempo={speed}[a]',
        '-map', '[v]',                    # Map the modified video stream
        '-map', '[a]',                    # Map the modified audio stream
        '-c:v', 'libx264',                # Video codec
        '-c:a', 'aac',                    # Audio codec
        '-b:a', '192k',                   # Audio bitrate
        '-preset', 'ultrafast',           # Encoding preset (adjust as needed)
        '-y',                             # Overwrite output file if it exists
        output_file                       # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_speed.mp4"
speed = 2

speed_up_video(input_file, output_file, speed)
################################################################################
