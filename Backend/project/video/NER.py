import spacy

from django.conf import settings
import os

BASE_DIR = settings.BASE_DIR


def getParamsNER(text):
    nlp = spacy.load(os.path.join(BASE_DIR, 'video/NER/model'))
    # 'D:/Uni/Graduation-Project/Project/GP2023/Backend/project/video/NER/model')

    # text='Cut this video from 0 to 5 seconds'
    # print(BASE_DIR)
    doc = nlp(text.lower())
    for entity in doc.ents:
        print(entity.text, entity.label_)
    return doc.ents
