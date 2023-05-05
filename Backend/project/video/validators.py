from django.core.exceptions import ValidationError


def file_size(value):
    filesize = value.size
    if filesize > 8e+8:
        raise ValidationError("The maximum file size that can be uploaded is 100MB")
    else:
        return value