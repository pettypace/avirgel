
String T = "VIRGEL";


float titleY     = 0.050;
float bltDataY   = 0.053;
float penBarY    = 0.180;
float wtiBarY    = 0.280;
float bgBarY     = 0.380;
float inRectTop  = 0.500;
float buttonsY   = 0.520;
float diaBarY    = 0.610;
float wgtBarY    = 0.710;
float velBarY    = 0.810;





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
int bgInt = 0;
double wtiWoundMass = 0;
double bgWoundMass = 0;
 
//                  kbar(title,        x,y,h,  w  ,lo,hi ,strt,bgC,fgC,mode)  
  kbar penBar = new kbar("Penetration:",
                         " (in)",
                         "(bare 10% ordnance gelatin)",
                         0,0,100,500,0,100,0,0,#D12424,0); 
  
  kbar wtiBar = new kbar("Defense Wound Mass:",
                         " (g)",
                         "(per MacPherson WTI model)",
                         0,0,100,500,0,150,0,0,#D12424,0); 
 
  kbar bgBar = new kbar("Big Game Wound Mass:",
                         " (g)",
                         "(for entire penetration path)",
                         0,0,100,500,0,150,0,0,#D12424,0); 
                         
                         

  kbar vBar = new kbar("Velocity:"," (ft/s)","",0,0,100,500,400,1600,800,0,#D12424,1); 
  kbar dBar = new kbar("Diameter:","/100 (in)","",0,0,100,500,20,120,45,0,#D12424,1);   
  kbar wBar = new kbar("Weight:"," (gr)","",0,0,100,500,0,500,220,0,#D12424,1); 

  

 //                                                (nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
  kradiobuttons  radiobuttons =   new kradiobuttons(6, 60,60, 60,    600,   0, 0,    #D12424,255);

void setup() {
  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  penBar.setLeftMargin(int(displayWidth*0.10));
  penBar.setWidth(int(displayWidth*0.8));
  penBar.setY(int(penBarY*displayHeight));
  penBar.setHeight(int(displayHeight*0.08));
 // penBar.setcarot(penInt);  
  
  
  wtiBar.setLeftMargin(int(displayWidth*0.10));
  wtiBar.setWidth(int(displayWidth*0.8));
  wtiBar.setY(int(wtiBarY*displayHeight));
  wtiBar.setHeight(int(displayHeight*0.08));
//  wtiBar.setcarot(wtiInt);  

  bgBar.setLeftMargin(int(displayWidth*0.10));
  bgBar.setWidth(int(displayWidth*0.8));
  bgBar.setY(int(bgBarY*displayHeight));
  bgBar.setHeight(int(displayHeight*0.08));
//  wtiBar.setcarot(wtiInt);  




  dBar.setLeftMargin(int(displayWidth*0.1));
  dBar.setWidth(int(displayWidth*0.8));  
  dBar.setY(int(diaBarY*displayHeight));
  dBar.setHeight(int(displayHeight*0.08));  


  wBar.setLeftMargin(int(displayWidth*0.10)); 
  wBar.setWidth(int(displayWidth*0.80));   
  wBar.setY(int(wgtBarY*displayHeight));  
  wBar.setHeight(int(displayHeight*0.08));  

  vBar.setLeftMargin(int(displayWidth*0.10));
  vBar.setWidth(int(displayWidth*0.8));  
  vBar.setY(int(velBarY*displayHeight));  
  vBar.setHeight(int(displayHeight*0.08)); 




  radiobuttons.setlabel(0,"WC");
  radiobuttons.setlabel(1,"TC");
  radiobuttons.setlabel(2,"SWC");
  radiobuttons.setlabel(3,"RN");
  radiobuttons.setlabel(4,"RB");
  radiobuttons.setlabel(5,"MSH"); 
  radiobuttons.setMargins(int(displayWidth*0.1),int(displayWidth*0.9));
  radiobuttons.setY(int(buttonsY*displayHeight));

  if(displayHeight > displayWidth) radiobuttons.setSize(int(displayHeight*0.06)); else 
     radiobuttons.setSize(int(displayHeight*0.08));   
    
 

}
 
 
void draw() { 
  
  background(255);  
  showTitle(int(displayHeight*titleY));
  showBulletData(int(displayHeight * bltDataY)); 
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
  
  bgBar.setcarot(bgInt);  
  bgBar.update(); 
  
  
  
  radiobuttons.update();

  
  getNoseParams();
  
  velocity = vBar.getval();
  weight = wBar.getval();
  diameter = dBar.getval();
  
  checkForHelp();
}

void checkForHelp(){
  int fontSize = int(displayWidth/25);
  if(mouseX > displayWidth*0.94 && mouseY > displayHeight*0.94){    
    int Y=int(displayHeight*0.01); 
    fill(255);
   rect(1,1,displayWidth,displayHeight);
    fill(0);
    textAlign(CENTER);
    textSize(fontSize);
    text("ABOUT VIRGEL",displayWidth/2,Y+=fontSize);
    text("ABOUT VIRGEL",displayWidth/2+2,Y+2);    
    text("(Tap to Return)", displayWidth/2,Y+=fontSize); 
    
    text("", displayWidth*0.06,Y+=fontSize); 
    
    textAlign(LEFT);  

    text("VIRGEL Isn't Really GELatin. It has limitations:", displayWidth*0.06,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+2,Y+2); 
    text("For example, VIRGEL can't predict bullet expansion ", displayWidth*0.06,Y+=fontSize);
    text("or deal with ''tumbling'' bullets. But VIRGEL is", displayWidth*0.06,Y+=fontSize);  
    text("cheaper than real gelatin and fits the pocket.", displayWidth*0.06,Y+=fontSize); 

        
    text("", displayWidth*0.06,Y+=fontSize); 
    
    text("VIRGEL uses a simplified ''THOR equation'' (see", displayWidth*0.06,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+2,Y+2);     
    text("Schwartz, Charles: ''Quantitative Ammunition ", displayWidth*0.06,Y+=fontSize);  
    text("Selection'', 2012) fitted to MacPherson's ", displayWidth*0.06,Y+=fontSize); 
    text("penetration modeling data (see MacPherson, ", displayWidth*0.06,Y+=fontSize);         
    text("Duncan: ''Bullet Penetration'',1994)", displayWidth*0.06,Y+=fontSize);  
    
    text("", displayWidth*0.06,Y+=fontSize);   
    
    text("VIRGEL calculates self-defense wound mass using", displayWidth*0.06,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("MacPherson's Wound Trauma Incapacitation model,", displayWidth*0.06,Y+=fontSize);     
    text("ignoring the last 3'' of penetration as too slow", displayWidth*0.06,Y+=fontSize);  
    text("and penetration beyond 15'' as too late.", displayWidth*0.06,Y+=fontSize); 
    
    text("", displayWidth*0.06,Y+=fontSize);   
    
    text("VIRGEL calculates big-game wound mass using the", displayWidth*0.06,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("full depth of bullet penetration.", displayWidth*0.06,Y+=fontSize);   
    
    text("", displayWidth*0.06,Y+=fontSize);  
    
    text("VIRGEL calculates kinetic energy as a possible", displayWidth*0.06,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("indicator of barrier penetration and reports the", displayWidth*0.06,Y+=fontSize); 
    text("power factor as an indicator of recoil.", displayWidth*0.06,Y+=fontSize);  

    text("", displayWidth*0.06,Y+=fontSize); 
 
    text("VIRGEL is intended as a heuristic tool and makes", displayWidth*0.06,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("no wild claims for accuracy beyond (maybe) two", displayWidth*0.06,Y+=fontSize);     
    text("significant figures. So, don't fret over not nailing", displayWidth*0.06,Y+=fontSize);     
    text("velocity to the last ft/s or weight to the last grain.", displayWidth*0.06,Y+=fontSize);    
 
    text("", displayWidth*0.06,Y+=fontSize); 
    
    text("VIRGEL was written in the free and open source", displayWidth*0.06,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("''Processing 3'' and ''Processing for Android''", displayWidth*0.06,Y+=fontSize);     
    text("languages and is licensed under MIT's open", displayWidth*0.06,Y+=fontSize);    
    text("source initiative ''Approved License''.", displayWidth*0.06,Y+=fontSize);  
    
    text("", displayWidth*0.06,Y+=fontSize); 

    text("VIRGEL was coded by Ross Kowalski and Robert", displayWidth*0.06,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+2,Y+2);
    text("Webster in their copious free time. (C) 2021.", displayWidth*0.06,Y+=fontSize);     
    text("", displayWidth*0.06,Y+=fontSize);   
    
  }  

}  
  
  
  




void drawInputRect(){
  fill(256);
//  stroke(0);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*inRectTop, displayWidth*0.9,displayHeight*0.41, 25);
  strokeWeight(4);   
  
}  

void drawOutputRect(){
  fill(256);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*0.07, displayWidth*0.9,displayHeight*0.41, 25);
  strokeWeight(4);   
  
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

    bgWoundMass = pen*3.14*diameter*diameter/4*17*phi/10000; 
    if(bgWoundMass < 0) bgWoundMass = 0;    
    
    
    energy = Math.pow(velocity,2)*weight/450240;
    penInt = int(Math.round((pen+0.5)));
    wtiInt = int(Math.round((wtiWoundMass+0.5)));
    bgInt = int(Math.round((bgWoundMass+0.5)));

  }

void showTitle(int Y){
  int fontSize;
  fontSize = int(displayWidth/15);
  if(displayHeight<displayWidth) fontSize = int(displayWidth/30);
  fill(0);
  textAlign(CENTER);  
  textSize(fontSize);
  text(T, displayWidth/2,Y);
  text("?",displayWidth*0.98,displayHeight*0.98);
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
 
