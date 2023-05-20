# Generated by Django 4.1.7 on 2023-05-19 23:00

from django.db import migrations, models
import video.validators


class Migration(migrations.Migration):

    dependencies = [
        ('video', '0002_alter_video_media_file'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='video',
            name='caption',
        ),
        migrations.AddField(
            model_name='video',
            name='height',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='video',
            name='new_insert',
            field=models.FileField(blank=True, null=True, upload_to='inserts/'),
        ),
        migrations.AddField(
            model_name='video',
            name='title',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name='video',
            name='versions',
            field=models.ManyToManyField(blank=True, to='video.video'),
        ),
        migrations.AddField(
            model_name='video',
            name='width',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='video',
            name='media_file',
            field=models.FileField(upload_to='video/<function upload_to at 0x0000023F6018C540>', validators=[video.validators.file_size]),
        ),
    ]
