import cv2
import numpy as np
import serial 
import time
from smbus import SMBus

class Drill():
    
    _addr = 0x8
    _bus = SMBus(1) #indicate /dev/i2c-1
    
    #configurations paramters
    _num_frames_to_average = 5
    _dete_area = 20
    _pixel_precentage = 40
    _max_count = 1
    _length_threshould = 20
    
    
    
    def __init__(self):
        print("drill run")
        self._cap = cv2.VideoCapture(0)
        
        if not self._cap.isOpened():
            print("[Drill] Error: Could not open video capture")
            self._camready = False
        else:
            self._camready = True
        
    
    #########################################################################################
    ########################            Internal funtions       #############################
    #########################################################################################
    def _point_laser_to(self,angles):
        self._bus.write_byte(self._addr, angles[0])
        self._bus.write_byte(self._addr, angles[1])
        
    def _disable_laser(self):
        self._bus.write_byte(self._addr, 220)
    
    def _enable_laser(self):
        self._bus.write_byte(self._addr, 230)
        
    #########################################################################################
    ########################            Internal funtions       #############################
    ########################             Image processing       #############################
    #########################################################################################
    def _get_average_frame(self, num_frames_to_average, dete_s = []):
        # Initialize an array to accumulate the frames
        accumulated_image = None
        ret = False

        for i in range(num_frames_to_average):
            ret, frame = self._cap.read()
            if not ret:
                print("Error: Could not read frame")
                break
            
            #if 4 == len(dete_s):
            #    frame = frame[dete_s[1]:dete_s[3],dete_s[0]:dete_s[2]]
            
            # Convert frame to float32 for precise accumulation
            frame = frame.astype(np.float32)

            if accumulated_image is None:
                # Initialize the accumulated_image with the first frame
                accumulated_image = frame
            else:
                # Accumulate the frame
                accumulated_image += frame

            # Calculate the average image
        if accumulated_image is not None:
            average_image = accumulated_image / num_frames_to_average
            average_image = average_image.astype(np.uint8)
            ret = True
        else:
            print("[Drill] ERROR getting average failed")
            average_image = 0

        return ret, average_image
    
    def _get_color_mask(self, frame, upper_range, lower_range):
        # Convert the frame to HSV color space
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

        # Create a mask with the red color range
        mask = cv2.inRange(hsv, lower_range, upper_range)

        return mask
    
    def _get_the_red_mask(self, ave_laser):
        lower_range = np.array([161, 0, 222])
        upper_range = np.array([179, 100, 255])
        red_mask = self._get_color_mask(ave_laser, upper_range, lower_range)

        lower_range = np.array([0, 0, 222])
        upper_range = np.array([18, 100, 255])
        red_mask_2 = self._get_color_mask(ave_laser, upper_range, lower_range)

        red_mask =  cv2.bitwise_or(red_mask, red_mask_2)
        kernel = np.ones((5, 5), np.uint8) 
        return cv2.dilate(red_mask, kernel, iterations=1)
    
    def _get_the_white_mask(self, ave_laser):

        lower_range = np.array([0, 0, 222])
        upper_range = np.array([255, 255, 255])
        return self._get_color_mask(ave_laser, upper_range, lower_range)
    
    def _get_diff_in_frames(self, frame1, frame2, thersh_lvl = 30):
        gary_1 = cv2.cvtColor(frame1, cv2.COLOR_BGR2GRAY)
        gary_2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)

        diff = cv2.absdiff(gary_1, gary_2)
        ret, thresh = cv2.threshold(diff, thersh_lvl, 255, cv2.THRESH_BINARY)
        if not ret:
            print("[Drill] ERROR _get_diff_in_frames failed")
        return thresh
    
    def _get_the_lase_contour(self, mask_1, mask_2 = [], one_mask = False):
        
        if not one_mask:
            #final mask
            F_mask = cv2.bitwise_and(mask_1, mask_2)
        else:
            F_mask = mask_1

        contours, _ = cv2.findContours(F_mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
        laser_contour = 0
        contour_area = 0
        for contour in contours:
            if cv2.contourArea(contour) > contour_area:
                contour_area = cv2.contourArea(contour) 
                laser_contour = contour
        return contour_area,  laser_contour
    
    def _monitor_laser_point(self, frame, initial_image, dete_s, total_pixels):
        second_image = cv2.cvtColor(frame[dete_s[1]:dete_s[3],dete_s[0]:dete_s[2]], cv2.COLOR_BGR2GRAY )
        
        diff = cv2.absdiff(initial_image, second_image)
        ret, thresh = cv2.threshold(diff, 50, 255, cv2.THRESH_BINARY)

        #cv2.imshow("theshed", thresh)

        if not ret:
            print("ERROR : threshold function failed")
        
        changed_pixels = cv2.countNonZero(thresh)
        return (changed_pixels / total_pixels) * 100
    
    
    
    def _draw(self, ave_laser, laser_contour):
        # Get the bounding box coordinates of the contour
        x, y, w, h = cv2.boundingRect(laser_contour)

        # Draw a rectangle around the detected laser point
        cv2.rectangle(ave_laser, (x, y), (x + w, y + h), (0, 255, 0), 2)

        dete_a = x - self._dete_area
        dete_b = y - self._dete_area
        dete_c = x + w + self._dete_area
        dete_d = y + h + self._dete_area
        cv2.rectangle(ave_laser, (dete_a, dete_b), (dete_c, dete_d), (0, 255, 0), 2)

        # Get the center of the contour
        M = cv2.moments(laser_contour)
        if M["m00"] != 0:
            cX = int(M["m10"] / M["m00"])
            cY = int(M["m01"] / M["m00"])
        else:
            cX, cY = 0, 0

        # Draw the center of the contour
        cv2.circle(ave_laser, (cX, cY), 5, (255, 0, 0), -1)

        return ave_laser
    #########################################################################################
    ########################   image processing main functions  #############################
    #########################################################################################
    
    
        
    

    #########################################################################################
    ########################                 API                #############################
    #########################################################################################

    def run(self, anglesList):
        print("[Drill] runDrill start")
        while True:
            for angle in anglesList:
                print("[Drill] angles : ", angle[0], " ", angle[1])
                
                #turn the servors
                self._point_laser_to(angle)
                
                contour_area, laser_contour = 0, 0
                dete_a, dete_b, dete_c, dete_d = 0,0,0,0
                dete_center = 0
                print("[Drill] Start point initial calibration")
                try_count = 0
                while contour_area == 0:
                    if try_count > 5:
                        print("[Drill] start point calibration falied")
                        break
                    try_count +=1
                    #get the clear image without the laser point
                    self._disable_laser()
                    ret, ave_no_laser = self._get_average_frame(self._num_frames_to_average)
                    if not ret:
                        return
                    


                    #get the clear image with the laser point
                    self._enable_laser()
                    ret, ave_laser = self._get_average_frame(self._num_frames_to_average)
                    if not ret:
                        return
                    
                    #cv2.imshow('without laser', ave_no_laser)
                    
                    #cv2.imshow('with laser', ave_laser)

                    #get the red laser point using red color mask
                    red_mask = self._get_the_red_mask(ave_laser)

                    #Optional - Middle of laser is white color
                    white_mask = self._get_the_white_mask(ave_laser)

                    color_mask = cv2.bitwise_and(red_mask, white_mask)

                    #get the changes in the ave_no_laser and ave_laser frames
                    thresh = self._get_diff_in_frames(ave_no_laser, ave_laser)

                    contour_area, laser_contour = self._get_the_lase_contour(color_mask, thresh)
                
                #draw on image
                #ave_laser_draw = self._draw(ave_laser, laser_contour)
                #cv2.imwrite((str(angle[0])+"_"+str(angle[1])+".jpeg"),ave_laser_draw)
                #cv2.imshow('with laser', ave_laser_draw)
                if 0 == contour_area:
                    print("[Drill] ERROR point initial calibration failed")
                    continue
		
                print("[Drill] point initial calibration is finished")
                
                
                # Get the bounding box coordinates of the contour
                x, y, w, h = cv2.boundingRect(laser_contour)
                dete_a = x - self._dete_area
                dete_b = y - self._dete_area
                dete_c = x + w + self._dete_area
                dete_d = y + h + self._dete_area
                dete_s = [dete_a, dete_b, dete_c, dete_d]
                
                # Get the center of the contour
                M = cv2.moments(laser_contour)
                if M["m00"] != 0:
                    cX = int(M["m10"] / M["m00"])
                    cY = int(M["m01"] / M["m00"])
                else:
                    cX, cY = 0, 0
                    print("ERROR: can not find the center of laser point")
                
                initial_image =  cv2.cvtColor(ave_laser[dete_b:dete_d,dete_a:dete_c], cv2.COLOR_BGR2GRAY )
                total_pixels = initial_image.size
                print("[Drill] start point monitoring")
                
                count = 0
                test_bool = True
                while True:

                    ret, frame = self._cap.read()
                    if not ret:
                        return
                    #cv2.imshow('frame', frame)
                    
                    
                    percentage_change = self._monitor_laser_point(frame,initial_image, dete_s, total_pixels)
                    line_string = str(percentage_change) + " "
                    if percentage_change > self._pixel_precentage:
                        #print("[Drill] Detect")
                        #break;
                                    
                        # print("[Drill] change detect, count is : " , count)
                        # #get the red laser point using red color mask
                        red_mask = self._get_the_red_mask(frame)
                        # #Optional - Middle of laser is white color
                        # white_mask = self._get_the_white_mask(frame)
                        contour_area, laser_contour = self._get_the_lase_contour(red_mask, one_mask = True)

                        # #cv2.imwrite(("image_"+str(index)+".jpeg"),frame)
                        # #index += 1

                        M = cv2.moments(laser_contour)
                        if M["m00"] != 0:
                            LX = int(M["m10"] / M["m00"])
                            LY = int(M["m01"] / M["m00"])
                            distanse = pow((LX-cX),2) + pow((LY-cY),2)
                            #line_string += str(distanse) + " "
                            #print("Distance change : " +  str(distanse))
                            print("[Drill] Distance is ", distanse)
                            
                            if self._length_threshould > distanse:
                                count+=1
                                if count > self._max_count :
                                    #Disable_laser()
                                    print("[Drill] Detect")
                                    break;
                                        
                            else:
                                count = 0
                            

                        else:
                            print("ERROR: can not find the center of laser point")
                            distanse = 1000
                
                
                    #if cv2.waitKey(1)&0xFF == ord('q'):
                    #    break
            

        
        

            
        print("[Drill] return run")
        self._cap.release()
        cv2.destroyAllWindows()
            
            
            

