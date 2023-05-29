
import socket
import json
from model.ner_model import NERModel
from model.config import Config
import tensorflow as tf


# Set the log level to suppress TensorFlow warnings
tf.logging.set_verbosity(tf.logging.ERROR)


def test_model(sentence):
    config = Config()

    # build model
    model = NERModel(config)
    tf.reset_default_graph()
    model.build()
    model.restore_session(config.dir_model)

    words_raw = sentence.strip().split(" ")

    preds = model.predict(words_raw)
    out = [(txt, label)for txt, label in zip(words_raw, preds)]

    return out


server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Create a TCP/IP socket

# Bind the socket to a specific IP address and port
server_address = ('localhost', 12345)
server_socket.bind(server_address)

# Listen for incoming connections
server_socket.listen(1)
while (True):

    print("connected")
    # Accept a connection
    client_socket, client_address = server_socket.accept()

    # Receive data from the client
    data = client_socket.recv(1024)

    # Process the received data
    print(data.decode())
    output = test_model(data.decode())
    print("Client", output)
    # Send a response back to the client
    response_serializable = [(item[0], item[1]) for item in output]

    # Convert the list to a string representation using JSON
    response_json = json.dumps(response_serializable)

    # Send the JSON-encoded response back to the client
    client_socket.send(response_json.encode())
    # Close the connection
    # client_socket.close()
    # server_socket.close()

    # output =  test_model("make this video blurring")
    # print(output)
