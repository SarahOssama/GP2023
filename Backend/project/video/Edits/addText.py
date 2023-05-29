import subprocess


def add_text_to_video(input_file, output_file, text, start_time, end_time, color="white", font_size=24):
    # Use subprocess to execute the ffmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                # Input video file
        # Add text overlay
        '-vf', f"drawtext=text='{text}':fontsize={font_size}:fontcolor={color}:x=(w-text_w)/2:y=(h-text_h)/2",
        '-ss', str(start_time),
        '-to', str(end_time),
        '-c:a', 'copy',                  # Copy audio stream
        '-y',                            # Overwrite output file if it exists
        output_file                      # Output file
    ])


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_addText.mp4"
text = "Hello, Test!"
start_time = 10
end_time = 20
color = "#FFFFFF"
font_size = 24

add_text_to_video(input_file, output_file, text,
                  start_time, end_time, color, font_size)
################################################################################
