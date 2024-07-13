#include <Wire.h>
#include <Servo.h>


#define LASER_PIN  2
#define TOP_SERVO 5
#define DOWN_SERVO 6

Servo myservo_top;  // create servo object to control a servo
Servo myservo_down; 

void controller(char c){
  switch (c){

    case 'A':
      digitalWrite(2,HIGH);
      break;

    case 'B':
      digitalWrite(2,LOW);
      break;

    case 'C':
      myservo_top.write(60);
      break;

    case 'D':
      myservo_top.write(120);
      break;

    case 'E':
      myservo_down.write(60);
      break;

    case 'F':
      myservo_down.write(120);
      break;
      
  }
}

void receiveEvent(int howMany){
  while(Wire.available()){
    char  c = Wire.read();
    Serial.println(c);
    controller(c);
  }
  
}

void setup() {
 Serial.begin(115200);
 Serial.println("Start..");
 pinMode(2,OUTPUT);
  myservo_top.attach(TOP_SERVO);  // attaches the servo on pin 9 to the servo object
  myservo_down.attach(DOWN_SERVO);
  myservo_top.write(90);                  // sets the servo position according to the scaled value
  myservo_down.write(90);
  delay(100);
  myservo_top.write(60);
  delay(100);
  myservo_down.write(60);

  Serial.println("Waiting..");
  
 Wire.begin(0x8);

 Wire.onReceive(receiveEvent);

 

}

void loop() {
  // put your main code here, to run repeatedly:

}
