# Generated by Django 4.1.7 on 2023-05-23 19:40

from django.db import migrations, models
import video.models
import video.validators


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Video",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("title", models.CharField(blank=True, max_length=200, null=True)),
                (
                    "media_file",
                    models.FileField(
                        upload_to=video.models.upload_to,
                        validators=[video.validators.file_size],
                    ),
                ),
                ("height", models.IntegerField(blank=True, null=True)),
                ("width", models.IntegerField(blank=True, null=True)),
                (
                    "new_insert",
                    models.FileField(blank=True, null=True, upload_to="inserts/"),
                ),
                ("versions", models.CharField(blank=True, max_length=200, null=True)),
            ],
        ),
    ]
