import json
import spacy

from django.conf import settings
import os
import socket

BASE_DIR = settings.BASE_DIR


def getParamsNER(text):
    nlp = spacy.load(os.path.join(BASE_DIR, 'video/NER/model'))
    # 'D:/Uni/Graduation-Project/Project/GP2023/Backend/project/video/NER/model')

    # text='Cut this video from 0 to 5 seconds'
    # print(BASE_DIR)
    doc = nlp(text.lower())
    # for entity in doc.ents:
    #     print(entity.text, entity.label_)
    return doc.ents


def getParamsNER_NEW(text):

    # Create a TCP/IP socket
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Connect the socket to the server's IP address and port
    server_address = ('localhost', 12345)
    client_socket.connect(server_address)

    # Send data to the server
    data = text
    client_socket.send(data.encode())

    # Receive a response from the server
    response = client_socket.recv(1024)

    # # Process the response
    # print(response.decode())
    # Decode the received JSON string to obtain a list of tuples
    response_serializable = json.loads(response)
    response = [(item[0], item[1]) for item in response_serializable]
    # # Close the connection
    # Send the JSON-encoded response back to the client
    # client_socket.send(response_json.encode())
    print("hamada", response)
    # client_socket.close()
    return response
