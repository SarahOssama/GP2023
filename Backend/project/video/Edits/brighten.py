import subprocess


def brighten_video(input_file, output_file, brightness):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                 # Input video file
        # Apply brightness filter to video
        '-vf', f'eq=brightness={brightness}',
        '-c:a', 'copy',                   # Copy audio stream
        '-y',                             # Overwrite output file if it exists
        output_file                       # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_brighten.mp4"


brightness = 0.2

brighten_video(input_file, output_file, brightness)
################################################################################
