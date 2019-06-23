import processing.serial.*;

Serial myPort1,myPort2;

String msg = null,Temp = null,Hum = null, NumP = null;
int [] rectX = {50,320,600,170};
int [] rectY = {350,350,350,500};
int rectL = 150;
int rectB = 50;
color rectColor,backColor=255,bulbrColor=255,bulbbColor=255;
boolean [] rectOver = {false,false,false,false};
int x1=683,y1=535,x2=735,y2=593;
int x12=743,y12=535,x22=689,y22=593;
float Temperature,Humidity;
int NumOfPerson;
boolean redbulb,bluebulb,fan;

boolean rsw=true,bsw=true,fsw=true;


void setup(){

    size(800,800);
    rectColor = color(0);
    myPort1 = new Serial(this, "COM5", 9600); //input port from arduino
    myPort2 = new Serial(this, "COM6", 9600); //output port from arduino



}

void serialEvent(Serial myPort1)
{
  msg = myPort1.readStringUntil('\n'); //receiving value from arduino
 
  if (msg!= null) 
  {
    try
    {
    //System.out.println(msg); 
    msg = trim(msg); 
    String sensorVals[] = (splitTokens(msg,":"));
   Temperature = Float.parseFloat(sensorVals[0]);
    Temp = sensorVals[0];
    Humidity = Float.parseFloat(sensorVals[1]);
    Hum = sensorVals[1];
    NumOfPerson = Integer.parseInt(sensorVals[2]);
    NumP = sensorVals[2];
    redbulb = Boolean.parseBoolean(sensorVals[3]);
    bluebulb = Boolean.parseBoolean(sensorVals[4]);
    fan = Boolean.parseBoolean(sensorVals[5]);
   
    
    
    
  }
    catch(Exception e){
    e.printStackTrace();
  }
}   
}

void draw(){
  
  
   background(color(190,160,250));
    stroke(0,0,255);
fill(200,200,0);
    rect(5,10,789,190);
   fill(0,32,155);
   textSize(15);
    text("Time: "+hour()+" : "+minute(),12,28);
   
   textSize(26);
   text("People Present :" +NumP,280,90,600,500);
   textSize(15);
   text("Temperature: "+Temp+"°C",630,33);
  text("      Humidity: "+Hum,630,183);
  fill(bulbrColor);
  ellipse(73,560,80,80);
  fill(220);
  ellipse(713,560,80,80);
  fill(bulbbColor);
  ellipse(73,300,80,80);
  fill(220);
  
  fill(0);
  line(x1,y1,x2,y2);
  line(x12,y12,x22,y22);
  fill(0);
  rect(50,600,50,50);
  rect(50,340,50,50);
  rect(690,600,50,50);

  update(mouseX,mouseY);
    fill(100,10,20);
    stroke(0);
/*    for(int i=0;i<3;i++)
    rect(rectX[i],rectY[i],rectL,rectB);
  */ 
  fill(200,100,100);
   rect(rectX[3]-3,rectY[3]-200,rectL*3,rectB*3.5);
fill(150,200,200);
textSize(40);
text("Shut Down", 280,400);






}

void update(int x,int y){

  if(fan==false){
  if(x1<700&&x2<800)
  {x1+=1;x2-=1;

  }

  if(x12<750&&x22<800){

    x12+=1;x22-=1;
  y12+=1;y22-=1;
delay(100);
}
  else{
  x12-=1;x22+=1;
  y12-=1;y22+=1;
delay(10);
 x1=683; y1=535;x2=735;y2=593;x12=743;y12=535;x22=689;y22=593;
  
  }

}
   
  

  for(int i=0;i<3;i++){
        if(overRect(rectX[i],rectY[i],rectL,rectB)){
            rectOver[i] = true;
        }
        else rectOver[i] = false;
    }


    if(overRect(rectX[3]-3,rectY[3]-200,rectL*3,rectB*3.5))
            rectOver[3] = true;
    else
            rectOver[3] = false;


if(bluebulb==false)
    bulbbColor=color(0,0,250);
    else
    bulbbColor=color(255);
 if(redbulb==false)
    bulbrColor=color(250,0,0);
    else
    bulbrColor=color(255);



}



void mousePressed(){
  

        if(rectOver[3])    
          myPort2.write('H');

}





boolean overRect(int x, int y, float  width, float height){

    if(mouseX >= x && mouseX <+ x+width && mouseY>= y && mouseY <= y+height)
    return true;
    else
    return false;
}