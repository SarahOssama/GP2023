import subprocess


def add_text_to_video(input_file, output_file, text, start_time, end_time, color="white", font_size="medium"):
    size_map = {
        'small': 50,
        'medium': 75,
        'large': 100
    }
    font_size = size_map.get(font_size, None)
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

################################################################################


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
################################################################################


def brighten_video(input_file, output_file, brightness=0.2):
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
################################################################################


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
################################################################################


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

################################################################################


def darken_video(input_file, output_file, darkness=0.2):
    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                # Input video file
        '-vf', f'eq=brightness={-darkness}',  # Apply darkness filter to video
        '-c:a', 'copy',                  # Copy audio stream
        '-y',                            # Overwrite output file if it exists
        output_file                      # Output file
    ])
################################################################################


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
################################################################################


def get_video_duration(input_file):
    result = subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of',
                            'default=noprint_wrappers=1:nokey=1', input_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    output = result.stdout.strip()
    duration = float(output)
    return duration
################################################################################


def fade_out_video(input_file, fade_duration, output_file):
    duration = get_video_duration(input_file)
    fade_start = duration - fade_duration

    # Use subprocess to execute the FFmpeg command
    subprocess.call([
        'ffmpeg',
        '-i', input_file,                               # Input video file
        # Apply fade out effect
        '-vf', f'fade=t=out:st={fade_start}:d={fade_duration}',
        # # Apply audio fade out effect
        # '-af', f'afade=t=out:st={fade_start}:d={fade_duration}',
        # Re-encode video using libx264 codec
        '-c:v', 'libx264',
        '-c:a', 'copy',                                 # Copy audio stream
        '-y',                                           # Overwrite output file if it exists
        output_file                                     # Output file
    ])
################################################################################


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

################################################################################


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

################################################################################


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


################################################################################


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
################################################################################
