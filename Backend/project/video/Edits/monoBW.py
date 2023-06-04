import subprocess


def convert_to_black_and_white(input_file, output_file):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                # Input video file
        # Apply black and white filter
        '-vf', 'colorchannelmixer=.3:.4:.3:0:.3:.4:.3:0:.3:.4:.3',
        '-c:a', 'copy',                  # Copy audio stream
        '-y',                            # Overwrite output file if it exists
        output_file                      # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_monoBW.mp4"

convert_to_black_and_white(input_file, output_file)

################################################################################
