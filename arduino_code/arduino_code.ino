#include <Wire.h>
#include <Servo.h>


#define LASER_PIN  2
#define TOP_SERVO 9
#define DOWN_SERVO 10

Servo myservo_top;  // create servo object to control a servo
Servo myservo_down; 

bool up = true;


void controller(int c){
  if(220 == c){
    //disable laser
    Serial.println("Laser disable");
    digitalWrite(LASER_PIN,LOW);
    
  }
  else if(230 == c){
    //enable laser
    Serial.println("Laser enable");
    digitalWrite(LASER_PIN,HIGH);
  }
  else if(up){
    Serial.print("TOP : ");
    Serial.println(c);
    myservo_top.write(c); 
    up=false;
  }
  else{
    Serial.print("DOWN : ");
    Serial.println(c);
    myservo_down.write(c);
    up = true;
  }
  
}



volatile int receivedValue = 0;
void receiveEvent(int numBytes){
  //Serial.println(numBytes);
  while(Wire.available()){
    int  c = Wire.read();
    controller(c);
  }
}

void setup() {
 Serial.begin(115200);
 Serial.println("Start..");
 pinMode(LASER_PIN,OUTPUT);
  myservo_top.attach(TOP_SERVO);  // attaches the servo on pin 9 to the servo object
  myservo_down.attach(DOWN_SERVO);


  Serial.println("Waiting..");
  
 Wire.begin(0x8);

 Wire.onReceive(receiveEvent);

 

}

void loop() {
  // put your main code here, to run repeatedly:

}
