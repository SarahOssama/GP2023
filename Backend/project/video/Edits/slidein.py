import subprocess


def slide_in_video(input_file, output_file, duration, slide_distance):
    # Use FFmpeg to slide in the video
    command = [
        'ffmpeg',
        '-i', input_file,
        '-vf', f"crop=in_w-{slide_distance}:in_h:0:0, pad=in_w+{slide_distance}:in_h:0:0:black@0, setpts=PTS+{(slide_distance/duration)}/TB",
        '-c:a', 'copy',
        '-t', str(duration),
        '-y',
        output_file
    ]
    subprocess.run(command)


################################## Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_slidein.mp4"

duration = 5  # Slide duration in seconds
slide_distance = 100  # Slide distance in pixels

slide_in_video(input_file, output_file, duration, slide_distance)

################################################################################
