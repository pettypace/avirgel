

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
  kbar penBar = new kbar("PENETRATION",0,0,100,500,0,100,0,0,#D12424,0," (in)"); 
  kbar wtiBar = new kbar("WTI WOUND MASS",0,0,100,500,0,150,0,0,#D12424,0," (g)"); 

  kbar vBar = new kbar("VELOCITY",0,0,100,500,400,1600,650,0,#D12424,1," (ft/s)"); 
  kbar dBar = new kbar("DIAMETER",0,0,100,500,20,120,35,0,#D12424,1,"/100 (in)");   
  kbar wBar = new kbar("WEIGHT",0,0,100,500,0,500,148,0,#D12424,1," (gr)"); 

  

 //                                                (nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
  kradiobuttons  radiobuttons =   new kradiobuttons(6, 60,60, 60,    600,   0, 0,    #D12424,255);

void setup() {
//  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  println(displayWidth,displayHeight);
  
  penBar.setLeftMargin(int(displayWidth*0.10));
  penBar.setBarWidth(int(displayWidth*0.8));
  penBar.setY(int(displayHeight*0.18));
  penBar.setHeight(int(displayHeight*0.08));
  penBar.setcarot(penInt);  
  
  
  wtiBar.setLeftMargin(int(displayWidth*0.10));
  wtiBar.setBarWidth(int(displayWidth*0.8));
  wtiBar.setY(int(displayHeight*0.30));
  wtiBar.setHeight(int(displayHeight*0.08));
  wtiBar.setcarot(wtiInt);  

  dBar.setLeftMargin(int(displayWidth*0.1));
  dBar.setBarWidth(int(displayWidth*0.8));  
  dBar.setY(int(displayHeight*0.60));
  dBar.setHeight(int(displayHeight*0.08));  


  wBar.setLeftMargin(int(displayWidth*0.10)); 
  wBar.setBarWidth(int(displayWidth*0.80));   
  wBar.setY(int(displayHeight*0.75));  
  wBar.setHeight(int(displayHeight*0.08));  

  vBar.setLeftMargin(int(displayWidth*0.10));
  vBar.setBarWidth(int(displayWidth*0.8));  
  vBar.setY(int(displayHeight*0.90));  
  vBar.setHeight(int(displayHeight*0.08)); 




  radiobuttons.setlabel(0,"WC");
  radiobuttons.setlabel(1,"TC");
  radiobuttons.setlabel(2,"SWC");
  radiobuttons.setlabel(3,"RN");
  radiobuttons.setlabel(4,"RB");
  radiobuttons.setlabel(5,"MSH "); 
  radiobuttons.setMargins(int(displayWidth*0.1),int(displayWidth*0.9));
  radiobuttons.setY(int(displayHeight*0.48));

  if(displayHeight > displayWidth) radiobuttons.setSize(int(displayHeight*0.06)); else 
     radiobuttons.setSize(int(displayHeight*0.08));   
    
 

}
 
 
void draw() { 
  
  background(#E5DADA);  
  showTitle(int(displayHeight*0.05));
//  showBulletData(int(displayHeight * 0.10));
//  showAllGraphTitles();
    
    

  reCalculate();  

  dBar.update();
  vBar.update();
  wBar.update();
  
  penBar.setcarot(penInt);  
  penBar.update();
  
  wtiBar.setcarot(wtiInt);  
  wtiBar.update(); 
  
  
  
  
  radiobuttons.update();

  
  checkButtonValue();
  
  velocity = vBar.getval();
  weight = wBar.getval();
  diameter = dBar.getval();
  

  
}

void showAllGraphTitles(){

    textSize(30);
    textAlign(CENTER);
    text("Penetration in Bare 10% Gelatin (inches)",displayWidth/2,displayHeight*0.28);
    text("MacPherson WTI Wound Mass (grams)",displayWidth/2,displayHeight*0.40);
    text("Tap to change NOSE SHAPE",displayWidth/2,displayHeight*0.48);
    text("Slide to change DIAMETER", displayWidth/2,displayHeight*0.62);
    text("Slide to change WEIGHT", displayWidth/2,displayHeight*0.77);
    text("Slide to change VELOCITY)", displayWidth/2,displayHeight*0.92);
}    
   



void checkButtonValue()
{
    if(radiobuttons.getselection() == 0){nose="WC";alpha=0.685;phi=1.0;}
    if(radiobuttons.getselection() == 1){nose="TC";alpha=0.735;phi=0.66;}
    if(radiobuttons.getselection() == 2){nose="SWC";alpha=0.725;phi=0.66;}
    if(radiobuttons.getselection() == 3){nose="RN";alpha=0.720;phi=0.66;}   
    if(radiobuttons.getselection() == 4){nose="RB";alpha=0.745;phi=0.5;}
    if(radiobuttons.getselection() == 5){nose="MSH";alpha=0.740;phi=0.82;}      
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
 
