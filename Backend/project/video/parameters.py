
import re

"""
Audima input statement samples
Audima clip video start 01:12 end 02:30
Audima put text "I am graduated !!" in video start 01:13 duration 01:50 size default color black position top left
Audima rotate video left start 01:15 duration 01.20
Audima blur video start 01:16 duration 01:21
Audima fade in video start 01 17 duration 01:22

"""

# Audima parameters
clipparams = ['start', 'end']
textparams = ['start', 'duration', 'text',  'color', 'position']
posparams = ['top-left', 'top-right', 'bottom-left',
             'bottom-right', 'top', 'bottom', 'left', 'right', 'center']
colorparams = ['red', 'green', 'blue', 'yellow', 'black',
               'white', 'orange', 'purple', 'pink', 'brown', 'grey']
sizeparams = ['small', 'medium', 'large', 'default']
transparams = ['start', 'duration']
fadeparams = ['in', 'out']
angleparams = ['left', 'right', 'mirror']

# Audima time regex
regex = re.compile(
    r'(?=((?: |^)[:. ]?[0-5]\d(?:[:. ]?[0-5]\d)))'
)

# Audima text regex
pattern = r'"([^"]*)"'

# Audima clipping the video parameters: start time, end time


def clipvideo(statement:str,times:any)-> tuple[str,any,any]:

    for clipparam in clipparams:
        if re.search(clipparam, statement):
            pass
        else:
            statement = input('Audima given incomplete statement try again')
    if (len(times) == 2):
        starttime = times[0]
        endtime = times[1]
        # print("clipping video..")
        # print("start time ", starttime)
        # print("end time ", endtime)
        return "trim", starttime, endtime
    else:
        statement = input(
            'Audima given incopmplete statement missing or wrong time try again')
# Audima putting text in video clip parameters: text, start time, duration time, font size, font color, font position


def puttext(statement:str,times:any)-> tuple[str,any,any,any,any,any]:

    position = ''
    color = ''
    size = ''
    text = ''
    for textparam in textparams:
        if re.search(textparam, statement):
            pass
        else:
            statement = input('Audima given wrong statement try again')
    if (len(times) == 2):
        starttime = times[0]
        duration = times[1]
        # print("putting text in video..")
        # print("start time", starttime)
        # print("duration ", duration)
    else:
        statement = input(
            'Audima given incopmplete statement missing or wrong time try again')

    for posparam in posparams:
        if re.search(posparam, statement):
            position = posparam
            break
    if position == '':
        statement = input(
            'Audima given incomplete statement missing or wrong position try again')
    else:
        pass
        # print("text position ", position)

    m = re.findall(pattern, statement)
    text = m[0]
    if text == '':
        statement = input(
            'Audima given incomplete statement missing or wrong text try again')
    else:
        pass
        # print("text  ", text)

    for colorparam in colorparams:
        if re.search(colorparam, statement):
            color = colorparam
            # print("text color ", color)
            break
    if color == '':
        statement = input(
            'Audima given incomplete statement missing or wrong color try again')
    for sizeparam in sizeparams:
        if re.search(sizeparam, statement):
            size = sizeparam
            break
    if (size == 'default' or size == ''):
        size = 50
        # print("text size ", size)
    return "text", text, position, color, size, starttime, duration


# Audima making transitions in video clip parameters: type, start time, duration time
def rotate(statement,times):
    angle = ''
    for transparam in transparams:
        if re.search(transparam, statement):
            pass
        else:
            statement = input('Audima given wrong statement try again')

    if (len(times) == 2):
        starttime = times[0]
        duration = times[1]
        print("rotating video..")
        print("start time", starttime)
        print("duration ", duration)
    else:
        statement = input(
            'Audima given incopmplete statement missing or wrong time try again')

    for angleparam in angleparams:
        if re.search(angleparam, statement):
            angle = angleparam
            break
    if angle == '':
        statement = input(
            'Audima given incomplete statement missing or wrong angle try again')
    else:
        print("rotation angle ", angle)


def blur(statement,times):
    for transparam in transparams:
        if re.search(transparam, statement):
            pass
        else:
            statement = input('Audima given wrong statement try again')
    if (len(times) == 2):
        starttime = times[0]
        duration = times[1]
        print("blurring video..")
        print("start time", starttime)
        print("duration ", duration)
    else:
        statement = input(
            'Audima given incopmplete statement missing or wrong time try again')


def fade(statement:str,times:any)-> tuple[str,any,any]:
    fade = ''
    for transparam in transparams:
        if re.search(transparam, statement):
            pass
        else:
            statement = input('Audima given wrong statement try again')

    if (len(times) == 2):
        starttime = times[0]
        duration = times[1]
        # print("fading video..")
        # print("start time", starttime)
        # print("duration ", duration)
    else:
        statement = input(
            'Audima given incopmplete statement missing or wrong time try again')

    for fadeparam in fadeparams:
        if re.search(fadeparam, statement):
            fade = fadeparam
            break
    if fade == '':
        statement = input(
            'Audima given incomplete statement missing or wrong fade value try again')
    else:
        pass
        # print("fading ", fade)
    return "fade",starttime, duration


# Audima starting...

# Entry Point
def getParams(statement:str):
    times = sum([regex.findall(statement)], [])
    if re.search('clip', statement):
        return clipvideo(statement,times)
    elif re.search('text', statement):
        return puttext(statement,times)
    elif re.search('rotate', statement):
        rotate(statement,times)
    elif re.search('blur', statement):
        blur(statement,times)
    elif re.search('fade', statement):
        return fade(statement,times)
