import subprocess
import os


def resize_video(input_file, output_file, width, height):
    # Use FFmpeg to resize the video
    command = [
        'ffmpeg',
        '-i', input_file,
        '-vf', f'scale={width}:{height}',
        '-c:a', 'copy',
        output_file
    ]
    subprocess.run(command)


# def concatenate_videos(input_files, output_file):
#     # Get the resolution of the first input video
#     probe_command = ['ffprobe', '-v', 'error', '-select_streams',
#                      'v:0', '-show_entries', 'stream=width,height', '-of', 'csv=p=0']
#     first_video_info = subprocess.check_output(
#         probe_command + [input_files[0]]).decode('utf-8').strip().split(',')
#     width, height = int(first_video_info[0]), int(first_video_info[1])

#     # Resize all input videos to the same resolution
#     resized_files = []
#     for i, file in enumerate(input_files):
#         resized_file = f'resized_{i}.mp4'
#         resize_video(file, resized_file, width, height)
#         resized_files.append(resized_file)

#     # Generate the FFmpeg command to concatenate the resized videos
#     command = ['ffmpeg']

#     # Add inputs
#     for file in resized_files:
#         command.extend(['-i', file])

#     # Add filter_complex to concatenate the inputs
#     filter_complex = f'concat=n={len(input_files)}:v=1:a=1'
#     command.extend(['-filter_complex', filter_complex])

#     # Set output codec options
#     command.extend(['-c:v', 'libx264', '-preset', 'ultrafast',
#                    '-c:a', 'aac', '-b:a', '192k'])

#     # Set output file
#     command.append(output_file)

#     # Execute the FFmpeg command
#     subprocess.run(command)

#     # Clean up resized files
#     for file in resized_files:
#         os.remove(file)
def concatenate_videos(input_files, output_file):
    # Generate the FFmpeg command to concatenate and re-encode the videos
    command = ['ffmpeg']

    # Add inputs
    for file in input_files:
        command.extend(['-i', file])

    # Add filter_complex to concatenate the inputs
    filter_complex = f'concat=n={len(input_files)}:v=1:a=1'
    command.extend(['-filter_complex', filter_complex])

    # Set output codec options
    command.extend(['-c:v', 'libx264', '-preset', 'ultrafast',
                   '-c:a', 'aac', '-b:a', '192k'])

    # Set output file
    command.append(output_file)

    # Execute the FFmpeg command
    subprocess.run(command)


################################## Test #####################################
input_file1 = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
input_file2 = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test1.mp4"

input_files = [input_file1, input_file2]
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_concatinate.mp4"

concatenate_videos(input_files, output_file)

################################################################################
