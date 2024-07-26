import time
import math
import threading
import queue
from blu import createBluetoothSocket
from drill import Drill
import cv2

print("blu.py statred")

LOG_ENABLE = True


anglesList = []
coordinateCount = 3
drillReceived = False
      
        
        

blueQueue = queue.Queue()
bluethread = threading.Thread(target=createBluetoothSocket, args=(blueQueue,))
bluethread.start()


drillobject = Drill()

while True:
    if(drillReceived):
        print(len(anglesList),"->", coordinateCount)
        if coordinateCount == len(anglesList):
            if LOG_ENABLE:
                print("[Main Thread] start the drill ")
            drillReceived = False

            drillobject.run(anglesList)
            
        else:
            coordinateCount = 0
            anglesList = []
            coordinates = []
            drillReceived = False
            if LOG_ENABLE:
                print("[Main Thread] receive data are corrupted")
            numStr = ''
            preChar = ''
            newpoints = []
        
          
        
    else:
        if not blueQueue.empty():
            blueData = blueQueue.get()
            if LOG_ENABLE:
                print("[Main Thread] blueData : ", blueData)
            if type(blueData) == str:
                if LOG_ENABLE:
                    print("[Main Thread] string")
                anglesList = []
                coordinateCount = 0
            elif type(blueData) == int:
                if LOG_ENABLE:
                    print("[Main Thread] int")
                coordinateCount = blueData
            elif type(blueData) == list:
                anglesList.append(blueData)
                if LOG_ENABLE:
                    print("[Main Thread] list. angle count : ", len(anglesList))
                if coordinateCount == len(anglesList):
                    drillReceived = True
    
print("[Main Thread] end of the program ")
bluethread.join()
