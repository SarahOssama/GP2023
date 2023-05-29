import subprocess

"""
parameters:
    input_file
    
    start_time
    
    end_time
    
    output_file
"""


def extract_subclip(input_file, start_time, end_time, output_file):
    command = [
        'ffmpeg',
        '-i', input_file,
        '-ss', str(start_time),
        '-to', str(end_time),
        '-c', 'copy',
        '-map', '0',
        output_file
    ]
    subprocess.run(command)


##################################### Test #####################################
input_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Test.mp4"
start_time = 10  # Start at 10 seconds
end_time = 20  # End at 20 seconds
output_file = "D:/Uni/Graduation-Project/Models/Video_Handling/Attempt1/Out/output_trim.mp4"

extract_subclip(input_file, start_time, end_time, output_file)
################################################################################
