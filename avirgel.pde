

// Android version as of 29 August 2021

String title = "VIRGEL Isn't Really GELLO";


int barMargin = 50;

String nose = "WC";
float diameter = 0.35;
int weight = 148;
int velocity = 650;
float alpha = 0.685;
float phi = 1.0;
double energy = Math.pow(velocity,2)*weight/450240;


double pen = 0;
double wtiPen = 0;
int penInt = 0;
int wtiInt = 0;

double wtiWoundMass = 0;
double pcWoundMass = 0;

int leftMargin = 0;


int barHeight      = 0;
int barSpacing     = 0;
int barWidth       = 0;
 
  
  kbar dBar = new kbar(0,0,100,500,20,120,35,0,#D12424,1); 
  kbar wBar = new kbar(0,0,100,500,0,500,148,0,#D12424,1); 
  kbar vBar = new kbar(0,0,100,500,400,1600,650,0,#D12424,1); 
  
//  kbar testBar = new kbar(
  
  kradiobuttons  radiobuttons = new kradiobuttons(6,60,50,50,750,650,0,#D12424,255);


void setup() {
  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  
  
  dBar.setLeftMargin(displayWidth/10);
  wBar.setLeftMargin(displayWidth/10); 
  vBar.setLeftMargin(displayWidth/10);

  dBar.setBarWidth(int(displayWidth*0.8));
  wBar.setBarWidth(int(displayWidth*0.8));  
  vBar.setBarWidth(int(displayWidth*0.8));  

  dBar.setY(int(displayHeight*0.7));
  wBar.setY(int(displayHeight*0.8)); 
  vBar.setY(int(displayHeight*0.9));  



  
  
  radiobuttons.setlabel(0,"WC");
  radiobuttons.setlabel(1,"TC");
  radiobuttons.setlabel(2,"SWC");
  radiobuttons.setlabel(3,"RN");
  radiobuttons.setlabel(4,"RB");
  radiobuttons.setlabel(5,"MSH "); 
  radiobuttons.setLeftMargin(int(displayWidth*0.1));


  PFont font = createFont("arial",30);


 
  barHeight      =  int(displayHeight * 0.08);
  barSpacing = int(displayHeight * 0.125);
  barWidth = int(displayWidth * .8);
}
 
 
void draw() { 
  
  background(#E5DADA);  
  showTitle(int(displayHeight*0.05));
 
  reCalculate();
  drawBarGraph(barMargin,int(displayHeight*0.18),pen,"Penetration in Bare 10% Gelatin (in)",0,#D12424);  
  drawBarGraph(barMargin,int(displayHeight*0.30),wtiWoundMass,"MacPherson WTI Wound Mass (g)",0,#D12424); 
  // drawBarGraph(leftMargin,barSpacing*3,pcWoundMass,"PC VOL (cc)"); 
  showBulletData(int(displayHeight * 0.10));

   

  dBar.update();
  vBar.update();
  wBar.update();
  
  radiobuttons.update();
  
  checkButtonValue();
  
  velocity = vBar.getval();
  weight = wBar.getval();
  diameter = dBar.getval();
  
  
  
}


void checkButtonValue()
{
    if(radiobuttons.getselection() == 0){nose="WC";alpha=0.685;phi=1.0;}
    if(radiobuttons.getselection() == 1){nose="TC";alpha=0.735;phi=0.66;}
    if(radiobuttons.getselection() == 2){nose="SWC";alpha=0.725;phi=0.66;}
    if(radiobuttons.getselection() == 3){nose="RN";alpha=0.720;phi=0.66;}   
    if(radiobuttons.getselection() == 4){nose="RB";alpha=0.745;phi=0.5;}
    if(radiobuttons.getselection() == 5){nose="MSHRM";alpha=0.740;phi=0.82;}
}  



  


  
  void reCalculate(){
    pen = weight*Math.pow(velocity,alpha)/.7/diameter/diameter/3.14*4;
    wtiPen = pen - 3;
    if(wtiPen > 15) wtiPen = 15;
  
    pcWoundMass = pen*3.14*diameter*diameter/4*phi*17;
    pcWoundMass = Math.round(pcWoundMass+0.5);
    wtiWoundMass = wtiPen*3.14*diameter*diameter/4*17*phi/10000; 
    if(wtiWoundMass < 0) wtiWoundMass = 0;
    energy = Math.pow(velocity,2)*weight/450240;
 


  }

void showTitle(int Y){
  int fontSize = int(displayWidth/15);
  fill(0);
  textAlign(CENTER);
  
  textSize(fontSize);
  //  textSize(fontSize);
  text(title, displayWidth/2,Y);
}  

void showBulletData(int Y){
  String data = "";  
  float D = diameter/100;
  String dia = String.format("%.02f", D);
  int powerFactor = weight * velocity /1000;
  fill(0);
  textAlign(CENTER);
  textSize(36); 
  data = weight + " gr " + nose + ",  Dia: " + dia + " in,  Vel:  " + velocity + " ft/s";
  text(data,displayWidth/2,Y);   
  data = "Energy: " + String.valueOf(Math.round(energy))+" ft-lb"
       + "   Power Factor: " + String.valueOf(powerFactor);
  text(data,displayWidth/2,Y+50); 
}  



void drawBarGraph(int x, int y, double value, String label, color bgColor, color barColor){  
  textAlign(LEFT);
  textSize(35);
  stroke(#E5DADA);
  fill(bgColor);
  rect(x,y,barWidth,barHeight);
  fill(barColor);
  rect(x,y,5*(float)value,barHeight);
  fill(255);
  text(String.valueOf(Math.round(value)),x+20,y+barHeight/2+5);
  textAlign(CENTER);
  textSize(35);
  fill(0);
  text(label,displayWidth/2,y+barHeight+30);
  
}  






//  WC: 0.6887;  0.6850;  1.00
//  TC: 0.7382;  0.7350;  0.66
//  SWC: 0.7299;  0.7250;   0.66
//  RN: 0.7281;  0.7200;  0.66    
//  RB:  0.7485;  0.7450;  0.50
//  MSHRM:  0.7411;  0.7400;  0.82       
//  ACM:  0.72;  0.8      
 
