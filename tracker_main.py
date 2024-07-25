import cv2
import numpy as np
import serial 
import time

#configurations paramters
num_frames_to_average = 10
dete_area = 20
pixel_precentage = 40
max_count = 1
length_threshould = 100

#connection to Arduino
#arduino = serial.Serial(port='COM6', baudrate=115200, timeout=.1) 


# Initialize video capture
cap = cv2.VideoCapture(0)

# Check if the video capture is opened
if not cap.isOpened():
    print("Error: Could not open video capture")
    exit()


#########################################################################################
########################              laser code             ############################
#########################################################################################

def get_average_frame(num_frames_to_average):
    # Initialize an array to accumulate the frames
    accumulated_image = None

    for i in range(num_frames_to_average):
        ret, frame = cap.read()
        if not ret:
            print("Error: Could not read frame")
            break

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

    return average_image

def get_diff_in_frames(frame1, frame2, thersh_lvl = 30):
    gary_1 = cv2.cvtColor(frame1, cv2.COLOR_BGR2GRAY)
    gary_2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)

    diff = cv2.absdiff(gary_1, gary_2)
    ret, thresh = cv2.threshold(diff, thersh_lvl, 255, cv2.THRESH_BINARY)

    return ret, thresh

def get_color_mask(frame, upper_range, lower_range):
    # Convert the frame to HSV color space
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # Create a mask with the red color range
    mask = cv2.inRange(hsv, lower_range, upper_range)

    return mask

def get_the_red_mask(ave_laser):
    lower_range = np.array([161, 0, 222])
    upper_range = np.array([179, 100, 255])
    red_mask = get_color_mask(ave_laser, upper_range, lower_range)

    lower_range = np.array([0, 0, 222])
    upper_range = np.array([18, 100, 255])
    red_mask_2 = get_color_mask(ave_laser, upper_range, lower_range)

    red_mask =  cv2.bitwise_or(red_mask, red_mask_2)
    kernel = np.ones((5, 5), np.uint8) 
    return cv2.dilate(red_mask, kernel, iterations=1)


def get_the_white_mask(ave_laser):

    lower_range = np.array([0, 0, 222])
    upper_range = np.array([255, 255, 255])
    return get_color_mask(ave_laser, upper_range, lower_range)


def get_the_lase_contour(mask_1, mask_2):
    #final mask
    F_mask = cv2.bitwise_and(red_mask, white_mask)

    contours, _ = cv2.findContours(F_mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    laser_contour = 0
    contour_area = 0
    for contour in contours:
        if cv2.contourArea(contour) > contour_area:
            contour_area = cv2.contourArea(contour) 
            laser_contour = contour
    return contour_area,  laser_contour
    
def monitor_laser_point(frame):
    second_image = cv2.cvtColor(frame[dete_b:dete_d,dete_a:dete_c], cv2.COLOR_BGR2GRAY )
    
    diff = cv2.absdiff(initial_image, second_image)
    ret, thresh = cv2.threshold(diff, 50, 255, cv2.THRESH_BINARY)

    cv2.imshow("theshed", thresh)

    if not ret:
        print("ERROR : threshold function failed")
    
    changed_pixels = cv2.countNonZero(thresh)
    return (changed_pixels / total_pixels) * 100
#########################################################################################
########################              laser code             ############################
#########################################################################################

def set_laser(status):
    #arduino.write(bytes(status, 'utf-8')) 
    time.sleep(1)
    #data = arduino.readline() 
    #print(data)
    return 1 

def Disable_laser():
    set_laser('1')

def enable_laser():
    set_laser('2')

#########################################################################################
########################          drawing - for debbug          #########################
#########################################################################################
def draw(ave_laser, laser_contour):
    # Get the bounding box coordinates of the contour
    x, y, w, h = cv2.boundingRect(laser_contour)

    # Draw a rectangle around the detected laser point
    cv2.rectangle(ave_laser, (x, y), (x + w, y + h), (0, 255, 0), 2)

    dete_a = x - dete_area
    dete_b = y - dete_area
    dete_c = x + w + dete_area
    dete_d = y + h + dete_area
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
########################              main code             #############################
#########################################################################################
contour_area, laser_contour = 0, 0
dete_a, dete_b, dete_c, dete_d = 0,0,0,0
dete_center = 0

while contour_area == 0:
    #get the clear image without the laser point
    Disable_laser()
    ave_no_laser = get_average_frame(num_frames_to_average)
    


    #get the clear image with the laser point
    enable_laser()
    ave_laser = get_average_frame(num_frames_to_average)
    
    cv2.imshow('without laser', ave_no_laser)
    
    cv2.imshow('with laser', ave_laser)

    #get the red laser point using red color mask
    red_mask = get_the_red_mask(ave_laser)

    #Optional - Middle of laser is white color
    white_mask = get_the_white_mask(ave_laser)

    color_mask = cv2.bitwise_and(red_mask, white_mask)

    #get the chnage sin the ave_no_laser and ave_laser frames
    ret, thresh = get_diff_in_frames(ave_no_laser, ave_laser)

    contour_area, laser_contour = get_the_lase_contour(color_mask, thresh)



# cv2.imshow('thresh', thresh)
# cv2.imshow('red_mask', red_mask)
# cv2.imshow('white_mask', white_mask)
ave_laser_draw = draw(ave_laser, laser_contour)
cv2.imshow('without laser', ave_no_laser)
cv2.imshow('with laser', ave_laser_draw)


# Get the bounding box coordinates of the contour
x, y, w, h = cv2.boundingRect(laser_contour)
dete_a = x - dete_area
dete_b = y - dete_area
dete_c = x + w + dete_area
dete_d = y + h + dete_area

# Get the center of the contour
M = cv2.moments(laser_contour)
if M["m00"] != 0:
    cX = int(M["m10"] / M["m00"])
    cY = int(M["m01"] / M["m00"])
else:
    cX, cY = 0, 0
    print("ERROR: can not find the center of laser point")


file1 = open("myfile.txt",'a')
line_string = ""
index = 1

initial_image =  cv2.cvtColor(ave_laser[dete_b:dete_d,dete_a:dete_c], cv2.COLOR_BGR2GRAY )
total_pixels = initial_image.size

count = 0
test_bool = True
while True:
    line_string = ""

    #ret, frame = cap.read()
    frame = get_average_frame(3)
    cv2.imshow('frame', frame)
    
    
    percentage_change = monitor_laser_point(frame)
    line_string = str(percentage_change) + " "
    if percentage_change > pixel_precentage:
        #get the red laser point using red color mask
        red_mask = get_the_red_mask(frame)
        #Optional - Middle of laser is white color
        white_mask = get_the_white_mask(frame)
        contour_area, laser_contour = get_the_lase_contour(red_mask, white_mask)

        
        

        M = cv2.moments(laser_contour)
        if M["m00"] != 0:
            LX = int(M["m10"] / M["m00"])
            LY = int(M["m01"] / M["m00"])
            distanse = pow((LX-cX),2) + pow((LY-cY),2)
            line_string += str(distanse) + " " + str((LX-cX)) + " " + str((LY-cY))
            print("x and y distance : " +  str((LX-cX)) + " " + str((LY-cY)))
            cv2.imwrite(("image_"+str(index)+".jpeg"),frame)
            
            index += 1
            print("Distance change : " +  str(distanse))
            
            if length_threshould > distanse:
                count+=1
                if count > max_count :
                    Disable_laser()
                    test_bool = False
                    print("OFF")
                    line_string += "Detect"
                        
            else:
                count = 0
                
            file1.write(line_string+'\n')
            file1.flush()
            

        else:
            print("ERROR: can not find the center of laser point")
            distanse = 1000
    
    
        


    

    # Exit if 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close all windows
cap.release()
cv2.destroyAllWindows()
