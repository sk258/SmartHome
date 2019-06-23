#include <dht.h>

boolean redbulb = false, bluebulb = false, fan = false;
String msg;
int item;boolean fval;
boolean rsw=true,bsw=true,fsw=true;
int shut=false;;


dht DHT;

#define DHT11_PIN 4

static int count=0;
int i,enterp=7;
int exitp=8;
int ldr = 0;
int temp=0.0;

int state;



void setup() {
Serial.begin(9600);
  pinMode(enterp,INPUT);  
pinMode(exitp,INPUT);  
  pinMode(5,OUTPUT);
  pinMode(A0,INPUT);
  pinMode(6,OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(2,INPUT);

  attachInterrupt(0,pin_ISR,CHANGE);
  
}

void loop() {
  
  checkSerial();
 
 Serial.print(DHT.temperature);Serial.print(":");Serial.print(DHT.humidity);Serial.print(":");Serial.print(count);Serial.print(":");Serial.print(redbulb);Serial.print(":");Serial.print(bluebulb);Serial.print(":");Serial.println(fan);
   
   
   
   digitalWrite(10,HIGH);
 
  int chk = DHT.read11(DHT11_PIN);

  
   ldr = analogRead(A0);
 

  if(DHT.temperature >25.0)
  {
      digitalWrite(5,LOW);
      fan = false;
  }
  else{
      digitalWrite(5,HIGH);
      fan = true;
  }



if(count>0 && ldr>600){
    digitalWrite(6,HIGH);
    bluebulb = false;
}
  else{
  digitalWrite(6,LOW);
  bluebulb = true;

}
  
  
  if(digitalRead(enterp)==HIGH)
    {count++;
    
 
  delay(2000);}
  else
    if(digitalRead(exitp)==HIGH&&count>0){
    count--;
    if(count==0)digitalWrite(6,HIGH);
    /*Serial.print("Count is   :    ");
   Serial.println(count);*/
   delay(2000);
}


  
}



void checkSerial(){


    char s =  Serial.read();
    
        if(s == 'H'){
         digitalWrite(5,HIGH);
        digitalWrite(6,LOW);
        digitalWrite(10,LOW);
        }
        
  

}







void pin_ISR(){

state = digitalRead(2);
for(i=0;i<10;i++)
{
      digitalWrite(10,state);
      delay(100);
      digitalWrite(10,!state);
      delay(100);
}

}