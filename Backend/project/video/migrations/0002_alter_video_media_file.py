# Generated by Django 4.1.7 on 2023-05-19 11:37

from django.db import migrations, models
import video.models
import video.validators


class Migration(migrations.Migration):

    dependencies = [
        ('video', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='video',
            name='media_file',
            field=models.FileField(upload_to=video.models.upload_to, validators=[video.validators.file_size]),
        ),
    ]