import time
import math
import threading
import queue
from blu import createBluetoothSocket
#from tracker_main import improcess
from drillRunner import drillRun

print("blu.py statred")



coordinates = []
anglesList = []
coordinateCount = 0
drillReceived = False

def calAngles(xval, yval):
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
    
    
    
    print("[Main Thread] servo 1 angle : " , up , " servo 2 angle : ", down)
    anglesList.append([round(up),round(down)])
    

def _processData(data):
    global drillReceived
    numStr = ''
    preChar = ''
    newpoints = []
    
    for char in data:
        if char.isdigit():
            #add digit to make a complete number
            numStr += char
        else:
            
            if numStr:
                if preChar == 'x':
                    newpoints.append(int(numStr))
                elif preChar == 'y':
                    newpoints.append(int(numStr))
                    print("[Main Thread] : newpoints : ", newpoints[0], " ", newpoints[1]  )
                    coordinates.append(newpoints)
                    calAngles(newpoints[0], newpoints[1])
                    newpoints = []
                else :
                    coordinateCount = int(numStr)
                    
            if char == 'Z':
                drillReceived = True
                print("[Main Thread] Data Receive complteted : ", drillReceived)
                    
            numStr = ''
            preChar = char
                
                
    #just number of coordinates received 
    if(len(newpoints) < 2 and preChar == ''):
        coordinateCount = int(numStr)
        print("[Main Thread] num of point", coordinateCount)
        
        
        

blueQueue = queue.Queue()
bluethread = threading.Thread(target=createBluetoothSocket, args=(blueQueue,))
bluethread.start()


while True:
    if(drillReceived):
        print("[Main Thread] start the drill ")
        drill = drillRun()
        drill.run(anglesList)
        #runDrill(anglesList)
        
    else:
        if not blueQueue.empty():
            blueData = blueQueue.get()
            print("[Main Thread] blueData : ", blueData)
            _processData(str(blueData))
    
        
bluethread.join()
