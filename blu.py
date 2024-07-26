import bluetooth
import uuid
import threading
import queue
import math

LOG_ENABLE = True
##########################################################################################################
##############################          Bluetooth Thread       ###########################################
##########################################################################################################
coordinates = []
anglesList = []
coordinateCount = 3

numStr = ''
preChar = ''
newpoints = []


def _sendData(blueQueue):
    global coordinateCount
    global anglesList
    global coordinates

    if LOG_ENABLE:
        print("[Bluetooth Thread] coordinate Count : " , coordinateCount ,"  number of angles : ", anglesList)
    if coordinateCount == len(anglesList):
        blueQueue.put('newDrill')
        blueQueue.put(coordinateCount)
        for angle in anglesList:
           blueQueue.put(angle) 


    else:
        coordinateCount = 0
        anglesList = []
        coordinates = []
        if LOG_ENABLE:
            print("[Bluetooth Thread] receive data are corrupted")

def _calAngles(xval, yval):
    global anglesList
    down = 0
    up = 0
    if xval >= 600:
        xval -= 600
        
        tanDown = xval/yval
        down = 180 - math.degrees(math.atan(tanDown))
        
        sval = math.sqrt(pow(xval,2)+pow(yval,2))
        up = math.degrees(math.atan(sval/100))
        
    else:
        tanDown = xval/yval
        down = math.degrees(math.atan(tanDown))
        
        sval = math.sqrt(pow(xval,2)+pow(yval,2))
        up = math.degrees(math.atan(sval/160))
    
    
    if LOG_ENABLE:
        print("[Bluetooth Thread] servo 1 angle : " , up , " servo 2 angle : ", down)
    anglesList.append([round(up),round(down)])
    

def _processData(data, blueQueue):
    if LOG_ENABLE:
        print("[Bluetooth Thread] ENTER _processData")
    global coordinateCount
    global coordinates
    global numStr
    global preChar
    global newpoints
    global anglesList
    
    for char in data:
        if LOG_ENABLE:
            print("[Bluetooth Thread] char : " , char)
        if char.isdigit():
            #add digit to make a complete number
            numStr += char
        else:
            
            if numStr:
                if preChar == 'x':
                    newpoints.append(int(numStr))
                elif preChar == 'y':
                    newpoints.append(int(numStr))
                    if LOG_ENABLE:
                        print("[Bluetooth Thread] : newpoints : ", newpoints[0], " ", newpoints[1]  )
                    coordinates.append(newpoints)
                    _calAngles(newpoints[0], newpoints[1])
                    newpoints = []
                elif preChar == 'a':
                    coordinates = []
                    anglesList = []
                    coordinateCount = 0
                    coordinateCount = int(numStr)
                    if LOG_ENABLE:
                        print("[Bluetooth Thread] num of point", coordinateCount)

                    
            if char == 'z':
                if LOG_ENABLE:
                    print("[Bluetooth Thread] Data Receive complteted")
                _sendData(blueQueue)
                numStr = ''
                preChar = ''
                newpoints = []

                    
            numStr = ''
            preChar = char
                
           
    #just number of coordinates received 
    if(numStr and preChar == 'a'):
        coordinateCount = int(numStr)
        if LOG_ENABLE:
            print("[Bluetooth Thread] num of point", coordinateCount)
    if LOG_ENABLE:
        print("[Bluetooth Thread] EXIT _processData")
  

def _receive_callback(client_socket, blueQueue):
    global drillReceived
    try:
        while True:
            data = client_socket.recv(1024)
            if LOG_ENABLE:
                print("[Bluetooth Thread] receive data : ", data.decode('utf-8'))
            _processData(str(data.decode('utf-8')), blueQueue)
            #blueQueue.put(data.decode('utf-8'))
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

    if LOG_ENABLE:
        print("[Bluetooth Thread] waiting for connection..2..")
    client_socket, address = server_sock.accept()

    if LOG_ENABLE:
        print(f'[Bluetooth Thread] accept {client_socket}')
        print("[Bluetooth Thread] address : ", address)
    
    _receive_callback(client_socket, blueQueue)
    
    client_socket.close()
    server_sock.close()




    
    