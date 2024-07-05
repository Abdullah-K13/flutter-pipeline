import cv2
import numpy as np
import serial 
import time

#configurations paramters
num_frames_to_average = 10

#connection to Arduino
arduino = serial.Serial(port='COM6', baudrate=115200, timeout=.1) 


# Initialize video capture
cap = cv2.VideoCapture(0)

# Check if the video capture is opened
if not cap.isOpened():
    print("Error: Could not open video capture")
    exit()

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


#########################################################################################
########################              laser code             #############################
#########################################################################################

def set_laser(status):
    arduino.write(bytes(status, 'utf-8')) 
    time.sleep(1)
    data = arduino.readline() 
    print(data)
    return data 

def Disable_laser():
    set_laser('1')

def enable_laser():
    set_laser('2')


#########################################################################################
########################              main code             #############################
#########################################################################################
#get the clear image without the laser point
Disable_laser()
ave_no_laser = get_average_frame(num_frames_to_average)

#get the clear image with the laser point
enable_laser()
ave_laser = get_average_frame(num_frames_to_average)

#get the red laser point using red color mask
red_mask = get_the_red_mask(ave_laser)

#Optional - Middle of laser is white color
white_mask = get_the_white_mask(ave_laser)

#get the chnage sin the ave_no_laser and ave_laser frames
ret, thresh = get_diff_in_frames(ave_no_laser, ave_laser)


#final mask
F_mask = cv2.bitwise_and(red_mask, white_mask)
F_mask = cv2.bitwise_and(F_mask, thresh)


contours, _ = cv2.findContours(F_mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

for contour in contours:
    # Get the bounding box coordinates of the contour
    x, y, w, h = cv2.boundingRect(contour)

   # Draw a rectangle around the detected laser point
    cv2.rectangle(ave_laser, (x, y), (x + w, y + h), (0, 255, 0), 2)

    # Get the center of the contour
    M = cv2.moments(contour)
    if M["m00"] != 0:
        cX = int(M["m10"] / M["m00"])
        cY = int(M["m01"] / M["m00"])
    else:
        cX, cY = 0, 0

    # Draw the center of the contour
    cv2.circle(ave_laser, (cX, cY), 5, (255, 0, 0), -1)

while True:

    #Showing the images
    cv2.imshow('without laser', ave_no_laser)
    cv2.imshow('with laser', ave_laser)
    cv2.imshow('thresh', thresh)

    cv2.imshow('red_mask', red_mask)
    cv2.imshow('white_mask', white_mask)

    


    cv2.imshow('F_mask', F_mask)

    # Exit if 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close all windows
cap.release()
cv2.destroyAllWindows()