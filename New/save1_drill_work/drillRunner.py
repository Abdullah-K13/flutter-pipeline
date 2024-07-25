import time
from smbus import SMBus

class drillRun():
    
    addr = 0x8
    bus = SMBus(1) #indicate /dev/i2c-1
    
    #########################################################################################
    ########################            Internal funtions       #############################
    #########################################################################################
    def _pointLaserTo(self,angles):
        self.bus.write_byte(self.addr, angles[0])
        self.bus.write_byte(self.addr, angles[1])


    #########################################################################################
    ########################                 API                #############################
    #########################################################################################

    def run(self, anglesList):
        print("[Drill] runDrill start")
        for angle in anglesList:
            print("[Drill] angles : ", angle[0], " ", angle[1])
            #turn the servors
            self._pointLaserTo(angle)
            
            time.sleep(2)
            
            

