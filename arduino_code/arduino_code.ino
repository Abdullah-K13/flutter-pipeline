#include <Servo.h>

Servo myservo;  // create servo object to control a servo
Servo myservo2; 

int min_val = 50;
int max_val =130;

void setup() {
  Serial.begin(115200);
  pinMode(2,OUTPUT);
  pinMode(3,INPUT);
  digitalWrite(2,LOW);
//  myservo.attach(9);  // attaches the servo on pin 9 to the servo object
//  myservo2.attach(10);
//  myservo.write(90);                  // sets the servo position according to the scaled value
//  myservo2.write(90);
 
}

String x;
void loop() {
  
  while (Serial.available()){
      bool x = digitalRead(2);
      
      digitalWrite(2,(x^true));
    
  }
//  int val = digitalRead(3);
//  digitalWrite(2, val);
 

}
