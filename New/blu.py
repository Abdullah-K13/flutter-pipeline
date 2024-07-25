import bluetooth
import uuid
import threading
import queue


##########################################################################################################
##############################          Bluetooth Thread       ###########################################
##########################################################################################################
def _receive_callback(client_socket, blueQueue):
    global drillReceived
    try:
        while True:
            data = client_socket.recv(1024)
            print("[Bluetooth Thread] receive data : ", data.decode('utf-8'))
            blueQueue.put(data.decode('utf-8'))
            if not data:
                break
            
    except OSError:
        pass
        
        
def createBluetoothSocket(blueQueue):
    
    service_uuid = "00001101-0000-1000-8000-00805f9b34fb"
    server_sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
    server_sock.bind(("",bluetooth.PORT_ANY))
    server_sock.listen(1)

    bluetooth.advertise_service(server_sock, "SampleServer",service_id = service_uuid,service_classes=[service_uuid, bluetooth.SERIAL_PORT_CLASS],profiles=[bluetooth.SERIAL_PORT_PROFILE])
     
    print("[Bluetooth Thread] waiting for connection..2..")
    client_socket, address = server_sock.accept()

    print(f'[Bluetooth Thread] accept {client_socket}')
    print("[Bluetooth Thread] address : ", address)
    
    _receive_callback(client_socket, blueQueue)
    
    client_socket.close()
    server_sock.close()




    
    