package org.rewebster.fvirgel;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class virgel2 extends PApplet {


String T = "VIRGEL";


float titleY     = 0.050f;
float bltDataY   = 0.053f;
float penBarY    = 0.180f;
float wtiBarY    = 0.280f;
float bgBarY     = 0.380f;
float inRectTop  = 0.500f;
float buttonsY   = 0.520f;
float diaBarY    = 0.610f;
float wgtBarY    = 0.710f;
float velBarY    = 0.810f;





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
                         0,0,100,500,0,100,0,0,0xffD12424,0); 
  
  kbar wtiBar = new kbar("Defense Wound Mass:",
                         " (g)",
                         "(per MacPherson WTI model)",
                         0,0,100,500,0,150,0,0,0xffD12424,0); 
 
  kbar bgBar = new kbar("Big Game Wound Mass:",
                         " (g)",
                         "(for entire penetration path)",
                         0,0,100,500,0,150,0,0,0xffD12424,0); 
                         
                         

  kbar vBar = new kbar("Velocity:"," (ft/s)","",0,0,100,500,400,1600,800,0,0xffD12424,1); 
  kbar dBar = new kbar("Diameter:","/100 (in)","",0,0,100,500,20,120,45,0,0xffD12424,1);   
  kbar wBar = new kbar("Weight:"," (gr)","",0,0,100,500,0,500,220,0,0xffD12424,1); 

  

 //                                                (nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
  kradiobuttons  radiobuttons =   new kradiobuttons(6, 60,60, 60,    600,   0, 0,    0xffD12424,255);

public void setup() {
  orientation(PORTRAIT);
  
  penBar.setLeftMargin(PApplet.parseInt(displayWidth*0.10f));
  penBar.setWidth(PApplet.parseInt(displayWidth*0.8f));
  penBar.setY(PApplet.parseInt(penBarY*displayHeight));
  penBar.setHeight(PApplet.parseInt(displayHeight*0.08f));
 // penBar.setcarot(penInt);  
  
  
  wtiBar.setLeftMargin(PApplet.parseInt(displayWidth*0.10f));
  wtiBar.setWidth(PApplet.parseInt(displayWidth*0.8f));
  wtiBar.setY(PApplet.parseInt(wtiBarY*displayHeight));
  wtiBar.setHeight(PApplet.parseInt(displayHeight*0.08f));
//  wtiBar.setcarot(wtiInt);  

  bgBar.setLeftMargin(PApplet.parseInt(displayWidth*0.10f));
  bgBar.setWidth(PApplet.parseInt(displayWidth*0.8f));
  bgBar.setY(PApplet.parseInt(bgBarY*displayHeight));
  bgBar.setHeight(PApplet.parseInt(displayHeight*0.08f));
//  wtiBar.setcarot(wtiInt);  




  dBar.setLeftMargin(PApplet.parseInt(displayWidth*0.1f));
  dBar.setWidth(PApplet.parseInt(displayWidth*0.8f));  
  dBar.setY(PApplet.parseInt(diaBarY*displayHeight));
  dBar.setHeight(PApplet.parseInt(displayHeight*0.08f));  


  wBar.setLeftMargin(PApplet.parseInt(displayWidth*0.10f)); 
  wBar.setWidth(PApplet.parseInt(displayWidth*0.80f));   
  wBar.setY(PApplet.parseInt(wgtBarY*displayHeight));  
  wBar.setHeight(PApplet.parseInt(displayHeight*0.08f));  

  vBar.setLeftMargin(PApplet.parseInt(displayWidth*0.10f));
  vBar.setWidth(PApplet.parseInt(displayWidth*0.8f));  
  vBar.setY(PApplet.parseInt(velBarY*displayHeight));  
  vBar.setHeight(PApplet.parseInt(displayHeight*0.08f)); 




  radiobuttons.setlabel(0,"WC");
  radiobuttons.setlabel(1,"TC");
  radiobuttons.setlabel(2,"SWC");
  radiobuttons.setlabel(3,"RN");
  radiobuttons.setlabel(4,"RB");
  radiobuttons.setlabel(5,"MSH"); 
  radiobuttons.setMargins(PApplet.parseInt(displayWidth*0.1f),PApplet.parseInt(displayWidth*0.9f));
  radiobuttons.setY(PApplet.parseInt(buttonsY*displayHeight));

  if(displayHeight > displayWidth) radiobuttons.setSize(PApplet.parseInt(displayHeight*0.06f)); else 
     radiobuttons.setSize(PApplet.parseInt(displayHeight*0.08f));   
    
 

}
 
 
public void draw() { 
  
  background(255);  
  showTitle(PApplet.parseInt(displayHeight*titleY));
  showBulletData(PApplet.parseInt(displayHeight * bltDataY)); 
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

public void checkForHelp(){
  int fontSize = PApplet.parseInt(displayWidth/25);
  if(mouseX > displayWidth*0.94f && mouseY > displayHeight*0.94f){    
    int Y=PApplet.parseInt(displayHeight*0.01f); 
    fill(255);
   rect(1,1,displayWidth,displayHeight);
    fill(0);
    textAlign(CENTER);
    textSize(fontSize);
    text("ABOUT VIRGEL",displayWidth/2,Y+=fontSize);
    text("ABOUT VIRGEL",displayWidth/2+2,Y+1);    
//    text("(Tap to Return)", displayWidth/2,Y+=fontSize); 
    
    text("", displayWidth*0.06f,Y+=fontSize); 
    
    textAlign(LEFT);  

    text("VIRGEL Isn't Really GELatin. It has limitations:", displayWidth*0.06f,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06f+1,Y+1); 
    text("For example, VIRGEL can't predict bullet expansion ", displayWidth*0.06f,Y+=fontSize);
    text("or deal with ''tumbling'' bullets. But VIRGEL is", displayWidth*0.06f,Y+=fontSize);  
    text("cheaper than real gelatin and fits the pocket.", displayWidth*0.06f,Y+=fontSize); 

        
    text("", displayWidth*0.06f,Y+=fontSize); 
    
    text("VIRGEL uses a simplified ''THOR equation'' (see", displayWidth*0.06f,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06f+1,Y+1);     
    text("Schwartz, Charles: ''Quantitative Ammunition ", displayWidth*0.06f,Y+=fontSize);  
    text("Selection'', 2012) fitted to MacPherson's ", displayWidth*0.06f,Y+=fontSize); 
    text("penetration modeling data (see MacPherson, ", displayWidth*0.06f,Y+=fontSize);         
    text("Duncan: ''Bullet Penetration'',1994)", displayWidth*0.06f,Y+=fontSize);  
    
    text("", displayWidth*0.06f,Y+=fontSize);   
    
    text("VIRGEL calculates self-defense wound mass using", displayWidth*0.06f,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("MacPherson's Wound Trauma Incapacitation model,", displayWidth*0.06f,Y+=fontSize);     
    text("ignoring the last 3'' of penetration as too slow", displayWidth*0.06f,Y+=fontSize);  
    text("and penetration beyond 15'' as too late.", displayWidth*0.06f,Y+=fontSize); 
    
    text("", displayWidth*0.06f,Y+=fontSize);   
    
    text("VIRGEL calculates big-game wound mass using the", displayWidth*0.06f,Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("full depth of bullet penetration.", displayWidth*0.06f,Y+=fontSize);   
    
    text("", displayWidth*0.06f,Y+=fontSize);  
    
    text("VIRGEL calculates kinetic energy as a possible", displayWidth*0.06f,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("indicator of barrier penetration and reports the", displayWidth*0.06f,Y+=fontSize); 
    text("power factor as an indicator of recoil.", displayWidth*0.06f,Y+=fontSize);  

    text("", displayWidth*0.06f,Y+=fontSize); 
 
    text("VIRGEL is intended as a heuristic tool and makes", displayWidth*0.06f,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("no wild claims for accuracy beyond (maybe) two", displayWidth*0.06f,Y+=fontSize);     
    text("significant figures. So, don't fret over not nailing", displayWidth*0.06f,Y+=fontSize);     
    text("velocity to the last ft/s or weight to the last grain.", displayWidth*0.06f,Y+=fontSize);    
 
    text("", displayWidth*0.06f,Y+=fontSize); 
    
    text("VIRGEL was written in the free and open source", displayWidth*0.06f,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("''Processing 3'' and ''Processing for Android''", displayWidth*0.06f,Y+=fontSize);     
    text("languages and is licensed under MIT's open", displayWidth*0.06f,Y+=fontSize);    
    text("source initiative ''Approved License.''", displayWidth*0.06f,Y+=fontSize);  
    
    text("", displayWidth*0.06f,Y+=fontSize); 

    text("VIRGEL was coded by Ross Kowalski and Robert", displayWidth*0.06f,Y+=fontSize);
    text("VIRGEL", displayWidth*0.06f+1,Y+1);
    text("Webster in their copious free time. (C) 2021.", displayWidth*0.06f,Y+=fontSize);     
    text("", displayWidth*0.06f,Y+=fontSize);   
    
  }  

}  
  
  
  




public void drawInputRect(){
  fill(256);
//  stroke(0);
  strokeWeight(8); 
  rect(displayWidth*0.05f, displayHeight*inRectTop, displayWidth*0.9f,displayHeight*0.41f, 25);
  strokeWeight(4);   
  
}  

public void drawOutputRect(){
  fill(256);
  strokeWeight(8); 
  rect(displayWidth*0.05f, displayHeight*0.07f, displayWidth*0.9f,displayHeight*0.41f, 25);
  strokeWeight(4);   
  
}    



public void getNoseParams()
{
  switch (radiobuttons.getselection()){
    case 0 : nose="WC";alpha=0.685f;phi=1.0f;break;
    case 1 : nose="TC";alpha=0.735f;phi=0.66f;break;
    case 2 : nose="SWC";alpha=0.725f;phi=0.66f;break;
    case 3 : nose="RN";alpha=0.720f;phi=0.66f;break;
    case 4 : nose="RB";alpha=0.745f;phi=0.5f;break;
    case 5 : nose="MSH";alpha=0.740f;phi=0.82f;break;
  }    
}  

  
  public void reCalculate(){
    pen = weight*Math.pow(velocity,alpha)/.7f/diameter/diameter/3.14f*4;
    wtiPen = pen - 3;
    if(wtiPen > 15) wtiPen = 15;
    wtiWoundMass = wtiPen*3.14f*diameter*diameter/4*17*phi/10000; 
    if(wtiWoundMass < 0) wtiWoundMass = 0;

    bgWoundMass = pen*3.14f*diameter*diameter/4*17*phi/10000; 
    if(bgWoundMass < 0) bgWoundMass = 0;    
    
    
    energy = Math.pow(velocity,2)*weight/450240;
    penInt = PApplet.parseInt(Math.round((pen+0.5f)));
    wtiInt = PApplet.parseInt(Math.round((wtiWoundMass+0.5f)));
    bgInt = PApplet.parseInt(Math.round((bgWoundMass+0.5f)));

  }

public void showTitle(int Y){
  int fontSize;
  fontSize = PApplet.parseInt(displayWidth/15);
  if(displayHeight<displayWidth) fontSize = PApplet.parseInt(displayWidth/30);
  fill(255,0,0);
  textAlign(CENTER);  
  textSize(fontSize);
  text(T, displayWidth/2,Y);
  fill(0);
  text(T, displayWidth/2+2,Y+2);  
  fill(255,0,0);
  rect(displayWidth*0.92f,displayHeight*0.95f,displayWidth*0.08f,displayHeight*0.05f,25);
  fill(255);
  text("?",displayWidth*0.96f,displayHeight*0.99f);
  fill(0);
}  




public void  showBulletData(int Y){
  int fontSize;  
  fontSize = PApplet.parseInt(displayWidth/20);
  if(displayHeight<displayWidth) fontSize = PApplet.parseInt(displayWidth/50);
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
 
class kbar{
String ktitle = "";
String units = "";
String info = "";
int barmode      = 0;
int setting     = 0;
int kheight     = 0;
int kwidth      = 0;
int kx          = 0;
int ky          = 0;
int kbgcolor    = 75;
int kslidecolor = 125;
int carot       = 0;
int rangeh      = 0;
int rangel      = 0;
int kBgColor  =0;
int kFgColor =128;





  
     kbar(String title,String u, String i, int xloc,int yloc,int h, int w,int rl,int rh,
            int starting,int bgColor,int fgColor,int mode){
        ktitle =title;
        units   = u;
        info    = i;
        barmode  = mode;
        kheight = h;
        kwidth  = w;
        kx      = xloc;
        ky      = yloc;
        rangel  = rl;
        rangeh  = rh;
        kBgColor    = bgColor;
        kFgColor    = fgColor;
        units   = u;
        
  
        carot   = PApplet.parseInt(map(starting,rangel,rangeh,0,kwidth));
  }
  
  public void setTitle(String t){
    ktitle = t;
  }  
  
  
  public void setcarot(int cval){
      carot = PApplet.parseInt(map(cval,rangel,rangeh,0,kwidth));;
  }
  
 public void setLeftMargin(int x){
    kx = x;
  } 
  
public void setWidth(int w){
  kwidth = w;
}  


public void setHeight(int h){
   kheight = h;
}  
  
  
  
  
public void setY(int y){
  ky = y;
}  
  
  
  public void update(){
    if(barmode == 1){
        if(mouseX > kx && mouseX < kx+kwidth && mouseY > ky && mouseY < ky+kheight && mousePressed==true){
           carot = mouseX-kx;
        }
    }
    
    int radius = 100;
    if(barmode==1) radius = 4;   
    
    fill(kBgColor); 
    rect(kx,ky,kwidth,kheight,kheight/radius); 
    
    fill(kFgColor);
    rect(kx,ky,carot,kheight,kheight/radius);
    fill(255); 
    textSize(kheight/3);
    textAlign(LEFT,CENTER);    
    text(ktitle,kx+kwidth*0.02f,ky+kheight/5);  
    textAlign(RIGHT,CENTER);
    text(PApplet.parseInt(map(carot,0,kwidth,rangel,rangeh))+units,kx+kwidth*9/10,ky+kheight/5);
    textAlign(CENTER);
    textSize(kheight/4);
    text(info,kx+kwidth/2,ky+kheight*0.8f);
     
     
   }

public int getval(){
   return PApplet.parseInt(map(carot,0,kwidth,rangel,rangeh));
}

}
class kradiobutton {

  String buttonlabel = "";
  int state   = 0;
  int kx      = 0;
  int ky      = 0;
  int kwidth  = 0;
  int kheight = 0;
  int offColor   = 0;
  int onColor    = 0;
  int lblColor     = 0;



  kradiobutton(int xloc, int yloc, int h, int w, int offClr, int onClr, int lblClr) {
    lblColor = lblClr;
    offColor = offClr;
    onColor = onClr;

    kx      = xloc;
    ky      = yloc; 
    kheight = h;
    kwidth  = w;
  }

  public void addlabel(String intext) {
    buttonlabel = intext;
  }


  public void setY(int y) {
    ky = y;
  }  


  public int getleft() {
    return(kx);
  }

  public int getright() {
    return(kx+kwidth);
  }

  public int gettop() {
    return(ky);
  }

  public int getbottom() {
    return(ky+kheight);
  }

  public int getstate() {
    return state;
  } 

  public void on() {
    textSize(kheight*0.4f);
    state = 1;
    fill(onColor); 
    rect(kx, ky, kwidth, kheight, kheight/4);

    fill(lblColor); 
    textAlign(CENTER, CENTER);
    text(buttonlabel, kx+kwidth/2, ky+kheight/2);
  }

  public void off() {
    textSize(kheight*0.4f);
    state = 0;
    fill(offColor); 
    rect(kx, ky, kwidth, kheight, kheight/4);

    fill(lblColor); 

    textAlign(CENTER, CENTER);
    text(buttonlabel, kx+kwidth/2, ky+kheight/2);
  }
}
class kradiobuttons{

  int numbuttons = 0;
  int leftmargin = 0;
  int rightmargin = 0;
  int ylocation = 0; 
  int buttonheight = 0;
  int buttonwidth  =0;
  int xspacing =0; 
  kradiobutton[] buttonlist; 
  int active = 0;
  
   kradiobuttons(int nb,int bh,int bw,int leftmar,int rightmar,int yloc,int onClr,int offClr,int lblClr){
       numbuttons   = nb;
       buttonheight = bh;
       buttonwidth  = bw;
       leftmargin   = leftmar;
       rightmargin  = rightmar;
       ylocation    = yloc;       
       xspacing     = PApplet.parseInt((rightmargin-leftmargin)/numbuttons);
       buttonlist = new kradiobutton[numbuttons];
        for (int q = 0; q < buttonlist.length; q++) {
            buttonlist[q] = new kradiobutton(leftmargin+(xspacing*q),ylocation,bh,bw,onClr,offClr,lblClr);
        }  
        
    }

public void setlabel(int index,String intext){
    buttonlist[index].addlabel(intext);
}


public void setMargins(int x,int y){
  leftmargin = x;
  rightmargin = y;
  xspacing = PApplet.parseInt((rightmargin-leftmargin)/numbuttons);
  for (int i=0;i<buttonlist.length;i++){
    buttonlist[i].kx = leftmargin+xspacing*i;
  }
}

public void setSize(int s){
  for(int i=0;i<buttonlist.length;i++){
    buttonlist[i].kwidth = s;
    buttonlist[i].kheight = s;  
  }  
}  



public void setY(int y){
  ylocation = y;
  for (int i = 0; i < buttonlist.length; i++) {
    buttonlist[i].setY(y);}
}  



public int getselection(){
 return active;
}

public void setSelection(int B){
  for (int d=0;d<buttonlist.length;d++) buttonlist[d].off();
  buttonlist[B].on();
  active = B;
  update();
  
}  




  
  public void update(){
      for (int d=0;d<buttonlist.length;d++) buttonlist[d].off();
  
      for (int v=0;v<buttonlist.length;v++){
        if(mouseX > buttonlist[v].getleft() && 
           mouseX < buttonlist[v].getright() && 
           mouseY > buttonlist[v].gettop() && 
           mouseY < buttonlist[v].getbottom() && 
           mousePressed == true){
           active = v;
        } 
       } 
       
       buttonlist[active].on();

  }



}
  public void settings() {  size(displayWidth,displayHeight); }
}
