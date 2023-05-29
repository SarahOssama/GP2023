import subprocess


def blur_video(input_file, output_file, sigma=5):
    # Use subprocess to execute the ffmpeg command
    horizontal_radius = int(sigma * 2)
    vertical_radius = int(sigma * 0.2)
    boxblur_parameters = f"{horizontal_radius}:{vertical_radius}"

    subprocess.call([
        'ffmpeg',
        '-i', input_file,                # Input video file
        # Apply blur filter
        '-vf', f'boxblur={boxblur_parameters}',
        '-c:a', 'copy',                  # Copy audio stream
        '-y',                            # Overwrite output file if it exists
        output_file                      # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/IMG_0939.MOV"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_blur.mp4"


blur_video(input_file, output_file, 6)
################################################################################
