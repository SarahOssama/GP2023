import spacy


def getParamsNER(text):
    nlp = spacy.load('D:/Uni/Graduation-Project/Project/GP2023/Backend/project/video/NER/model')

    # text='Cut this video from 0 to 5 seconds'
    doc = nlp(text.lower())
    # for entity in doc.ents:
    #     print(entity.text, entity.label_)
    return doc.ents