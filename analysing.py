import threading
import queue
import time


def thread_one(blueQueue):
    print("Start bluethread")
    index = 0
    blueQueue.put("start")
    while 10>index:
        blueQueue.put([index,index+1])
        print("thread : " ,index)
        index += 1



blueQueue = queue.Queue()
bluethread = threading.Thread(target=thread_one, args=(blueQueue,))
print("Call bluethread")
bluethread.start()

while True:
    if not blueQueue.empty():
        blueData = blueQueue.get()
        print(blueData, " -> ", type(blueData) )
        if blueData == 9:
            break
bluethread.join()