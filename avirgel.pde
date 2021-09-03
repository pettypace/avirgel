


// Android version as of 01 September 2021

String T = "VIRGEL Isn't Really GELLO";

String nose;
float diameter;
int weight;
int velocity;
float alpha;
float phi;
double energy;
double pen = 0;
double wtiPen = 0;
int penInt = 0;
int wtiInt = 0;
double wtiWoundMass = 0;



 
//                  kbar(title,        x,y,h,  w  ,lo,hi ,strt,bgC,fgC,mode)  
  kbar penBar = new kbar("PENETRATION"," (in)",0,0,100,500,0,100,0,0,#D12424,0); 
  kbar wtiBar = new kbar("WTI WOUND MASS"," (g)",0,0,100,500,0,150,0,0,#D12424,0); 

  kbar vBar = new kbar("VELOCITY"," (ft/s)",0,0,100,500,400,1600,800,0,#D12424,1); 
  kbar dBar = new kbar("DIAMETER","/100 (in)",0,0,100,500,20,120,45,0,#D12424,1);   
  kbar wBar = new kbar("WEIGHT"," (gr)",0,0,100,500,0,500,220,0,#D12424,1); 

  

 //                                                (nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
  kradiobuttons  radiobuttons =   new kradiobuttons(6, 60,60, 60,    600,   0, 0,    #D12424,255);

void setup() {
  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  println(displayWidth,displayHeight);
  
  penBar.setLeftMargin(int(displayWidth*0.10));
  penBar.setWidth(int(displayWidth*0.8));
  penBar.setY(int(displayHeight*0.18));
  penBar.setHeight(int(displayHeight*0.08));
 // penBar.setcarot(penInt);  
  
  
  wtiBar.setLeftMargin(int(displayWidth*0.10));
  wtiBar.setWidth(int(displayWidth*0.8));
  wtiBar.setY(int(displayHeight*0.32));
  wtiBar.setHeight(int(displayHeight*0.08));
//  wtiBar.setcarot(wtiInt);  

  dBar.setLeftMargin(int(displayWidth*0.1));
  dBar.setWidth(int(displayWidth*0.8));  
  dBar.setY(int(displayHeight*0.66));
  dBar.setHeight(int(displayHeight*0.08));  


  wBar.setLeftMargin(int(displayWidth*0.10)); 
  wBar.setWidth(int(displayWidth*0.80));   
  wBar.setY(int(displayHeight*0.76));  
  wBar.setHeight(int(displayHeight*0.08));  

  vBar.setLeftMargin(int(displayWidth*0.10));
  vBar.setWidth(int(displayWidth*0.8));  
  vBar.setY(int(displayHeight*0.86));  
  vBar.setHeight(int(displayHeight*0.08)); 




  radiobuttons.setlabel(0,"WC");
  radiobuttons.setlabel(1,"TC");
  radiobuttons.setlabel(2,"SWC");
  radiobuttons.setlabel(3,"RN");
  radiobuttons.setlabel(4,"RB");
  radiobuttons.setlabel(5,"MSH "); 
  radiobuttons.setMargins(int(displayWidth*0.1),int(displayWidth*0.9));
  radiobuttons.setY(int(displayHeight*0.57));

  if(displayHeight > displayWidth) radiobuttons.setSize(int(displayHeight*0.06)); else 
     radiobuttons.setSize(int(displayHeight*0.08));   
    
 

}
 
 
void draw() { 
  
  background(#E5DADA);  
  showTitle(int(displayHeight*0.05));
  showBulletData(int(displayHeight * 0.053));
  showPenNotes(int(displayHeight * 0.25));
  showWtiNotes(int(displayHeight * 0.387)); 
  showInputNotes(int(displayHeight * 0.48));   
  drawInputRect();
  drawOutputRect();
  

  reCalculate();  

  dBar.update();
  vBar.update();
  wBar.update();
  
  penBar.setcarot(penInt);  
  penBar.update();
  
  wtiBar.setcarot(wtiInt);  
  wtiBar.update(); 
  
  
  
  
  radiobuttons.update();

  
  getNoseParams();
  
  velocity = vBar.getval();
  weight = wBar.getval();
  diameter = dBar.getval();
  

  
}

void drawInputRect(){
  fill(256);
//  stroke(0);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*0.5, displayWidth*0.9,displayHeight*0.45, 25);
  strokeWeight(4);   
  
}  

void drawOutputRect(){
  fill(256);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*0.07, displayWidth*0.9,displayHeight*0.38, 25);
  strokeWeight(4);   
  
}    


void showInputNotes(int Y){
  int fontSize;  
  fontSize = int(displayWidth/20); 
  if(displayHeight<displayWidth) fontSize = int(displayWidth/50);
  textSize(fontSize);  
  String data = "Change Bullet Parameters Below:";  
  text(data,displayWidth/2,Y+2*fontSize);    
}  
  

void showWtiNotes(int Y){
  int fontSize;  
  fontSize = int(displayWidth/30); 
  if(displayHeight<displayWidth) fontSize = int(displayWidth/50);
  textSize(fontSize);  
  String data = "(Calculated for not more than 15 inches of penetration)";  
  text(data,displayWidth/2,Y+2*fontSize);    
}  
  

void  showPenNotes(int Y){
  int fontSize;  
  fontSize = int(displayWidth/30);
  if(displayHeight<displayWidth) fontSize = int(displayWidth/50);
  textSize(fontSize);  
  String data = "(FBI recommends minimum 12 inches of penetration)";  
  text(data,displayWidth/2,Y+2*fontSize);   
} 
  

void getNoseParams()
{
  switch (radiobuttons.getselection()){
    case 0 : nose="WC";alpha=0.685;phi=1.0;break;
    case 1 : nose="TC";alpha=0.735;phi=0.66;break;
    case 2 : nose="SWC";alpha=0.725;phi=0.66;break;
    case 3 : nose="RN";alpha=0.720;phi=0.66;break;
    case 4 : nose="RB";alpha=0.745;phi=0.5;break;
    case 5 : nose="MSH";alpha=0.740;phi=0.82;break;
  }    
}  

  
  void reCalculate(){
    pen = weight*Math.pow(velocity,alpha)/.7/diameter/diameter/3.14*4;
    wtiPen = pen - 3;
    if(wtiPen > 15) wtiPen = 15;
    wtiWoundMass = wtiPen*3.14*diameter*diameter/4*17*phi/10000; 
    if(wtiWoundMass < 0) wtiWoundMass = 0;
    energy = Math.pow(velocity,2)*weight/450240;
    penInt = int(Math.round((pen+0.5)));
    wtiInt = int(Math.round((wtiWoundMass+0.5)));

  }

void showTitle(int Y){
  int fontSize;
  fontSize = int(displayWidth/15);
  if(displayHeight<displayWidth) fontSize = int(displayWidth/30);
  fill(0);
  textAlign(CENTER);  
  textSize(fontSize);
  text(T, displayWidth/2,Y);

}  




void  showBulletData(int Y){
  int fontSize;  
  fontSize = int(displayWidth/20);
  if(displayHeight<displayWidth) fontSize = int(displayWidth/50);
  textSize(fontSize);  
  String data = "";  
  float D = diameter/100;
  String dia = String.format("%.02f", D);
  int powerFactor = weight * velocity /1000;
  data = weight + " gr " + nose + ",  Dia: " + dia + " in,  Vel:  " + velocity + " ft/s";
  text(data,displayWidth/2,Y+2*fontSize);   
  data = "Energy: " + String.valueOf(Math.round(energy))+" ft-lb"
       + "   Power Factor: " + String.valueOf(powerFactor);
  text(data,displayWidth/2,Y+3*fontSize); 
}  


//  WC: 0.6887;  0.6850;  1.00
//  TC: 0.7382;  0.7350;  0.66
//  SWC: 0.7299;  0.7250;   0.66
//  RN: 0.7281;  0.7200;  0.66    
//  RB:  0.7485;  0.7450;  0.50
//  MSHRM:  0.7411;  0.7400;  0.82       
//  ACM:  0.72;  0.8      
 
