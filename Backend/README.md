# HEllO to Audima's Backend 👋🏽

This is the backend of the Audima project. It is a Django project that uses Django Rest Framework to create the API endpoints.

please cd projects and run the following commands

Here's a walk through of how to run the backend project.

## Prerequisites

-[ ]    Django

-[ ]    Python 3.6

## Commands to Run

pip install -r requirements.txt

### Migrate Models

python [manage.py](http://manage.py/) makemigrations

python [manage.py](http://manage.py/) migrate

### Create Super User

python [manage.py](http://manage.py/) createsuperuser

### Run Server

python manage.py runserver

## API Use

Use postman to test the API endpoints

to upload : <http://127.0.0.1:8000/video/upload/>

to get all videos : <http://127.0.0.1:8000/video/viewVideo/>

to edit video : <http://127.0.0.1:8000/video/edit/>

### to Import requests to postman

use this file Backend\project\GP Backend.postman_collection.json

## Note

upload a video first before editing it
