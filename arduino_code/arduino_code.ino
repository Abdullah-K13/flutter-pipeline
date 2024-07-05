#include <Servo.h>

Servo myservo;  // create servo object to control a servo
Servo myservo2; 

int min_val = 50;
int max_val =130;

void setup() {
  Serial.begin(115200);
  Serial.println("Start");
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
    x = Serial.readString().toInt(); 
    if(x==1){
      digitalWrite(2,LOW);
      Serial.print("Done");
    }
    else{
      digitalWrite(2,HIGH);
      Serial.print("Done");
    }
  }
//  int val = digitalRead(3);
//  digitalWrite(2, val);
 

}
