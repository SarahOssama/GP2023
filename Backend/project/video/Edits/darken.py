import subprocess


def darken_video(input_file, output_file, darkness):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                # Input video file
        '-vf', f'eq=brightness={-darkness}',  # Apply darkness filter to video
        '-c:a', 'copy',                  # Copy audio stream
        '-y',                            # Overwrite output file if it exists
        output_file                      # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_darken.mp4"


darkness = 0.2

darken_video(input_file, output_file, darkness)
################################################################################
