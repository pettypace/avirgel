
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




Bullet curBlt = new Bullet("",0, 35, 148, 650);
Bullet memBlt = new Bullet("",3, 45, 230, 820);
Bullet hldBlt = new Bullet("",5, 41, 105, 940);



//                  kbar(title,units,info,x,y,h,w lo,hi,strt,bgC,fgC,mode)  
kbar penBar = new kbar("Penetration:", 
  " (in)", 
  "(bare 10% ordnance gelatin)", 
  0, 0, 100, 500, 0, 100, 0, 0, #D12424, 0); 

kbar wtiBar = new kbar("Defense Wound Mass:", 
  " (g)", 
  "(per MacPherson WTI model)", 
  0, 0, 100, 500, 0, 150, 0, 0, #D12424, 0); 

kbar bgBar = new kbar("Big Game Wound Mass:", 
  " (g)", 
  "(for entire penetration path)", 
  0, 0, 100, 500, 0, 150, 0, 0, #D12424, 0); 



kbar vBar = new kbar("Velocity:", " (ft/s)", "", 0, 0, 100, 500, 400, 1600, curBlt.getVelocity(), 0, #D12424, 1); 
kbar dBar = new kbar("Diameter:", "/100 (in)", "", 0, 0, 100, 500, 20, 120, curBlt.getDiameter(), 0, #D12424, 1);   
kbar wBar = new kbar("Weight:", " (gr)", "", 0, 0, 100, 500, 0, 500, curBlt.getWeight(), 0, #D12424, 1); 



//                                                (nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
kradiobuttons  radiobuttons =   new kradiobuttons(6, 60, 60, 60, 600, 0, 0, #D12424, 255);

void setup() {
  orientation(PORTRAIT);
  size(displayWidth, displayHeight);  
  
  penBar.setLeftMargin(int(displayWidth*0.10));
  penBar.setWidth(int(displayWidth*0.8));
  penBar.setY(int(displayHeight*penBarY));
  penBar.setHeight(int(displayHeight*0.08));

  wtiBar.setLeftMargin(int(displayWidth*0.10));
  wtiBar.setWidth(int(displayWidth*0.8));
  wtiBar.setY(int(displayHeight*wtiBarY));
  wtiBar.setHeight(int(displayHeight*0.08));

  bgBar.setLeftMargin(int(displayWidth*0.10));
  bgBar.setWidth(int(displayWidth*0.8));
  bgBar.setY(int(displayHeight*bgBarY));
  bgBar.setHeight(int(displayHeight*0.08));

  dBar.setLeftMargin(int(displayWidth*0.1));
  dBar.setWidth(int(displayWidth*0.8));  
  dBar.setY(int(displayHeight*diaBarY));
  dBar.setHeight(int(displayHeight*0.08));  

  wBar.setLeftMargin(int(displayWidth*0.10)); 
  wBar.setWidth(int(displayWidth*0.80));   
  wBar.setY(int(displayHeight*wgtBarY));  
  wBar.setHeight(int(displayHeight*0.08));  

  vBar.setLeftMargin(int(displayWidth*0.10));
  vBar.setWidth(int(displayWidth*0.8));  
  vBar.setY(int(displayHeight*velBarY));  
  vBar.setHeight(int(displayHeight*0.08)); 

  radiobuttons.setlabel(0, "WC");
  radiobuttons.setlabel(1, "TC");
  radiobuttons.setlabel(2, "SWC");
  radiobuttons.setlabel(3, "RN");
  radiobuttons.setlabel(4, "RB");
  radiobuttons.setlabel(5, "MSH"); 
  radiobuttons.setMargins(int(displayWidth*0.1), int(displayWidth*0.9));
  radiobuttons.setY(int(buttonsY*displayHeight));

  if (displayHeight > displayWidth) radiobuttons.setSize(int(displayHeight*0.06)); 
  else 
  radiobuttons.setSize(int(displayHeight*0.08));
  
}


void draw() { 

  background(255);  
  showTitle(int(displayHeight*titleY));
  showBulletData(int(displayHeight * bltDataY));  
  drawInputRect();
  drawOutputRect();
  showHelpButton();

  dBar.update();
  vBar.update();
  wBar.update();



  penBar.setcarot(curBlt.getPen());  
  penBar.update();

  wtiBar.setcarot(curBlt.getWtiMass());  
  wtiBar.update(); 

  bgBar.setcarot(curBlt.getBgMass());  
  bgBar.update(); 

  radiobuttons.update();

  getNoseParams();

  curBlt.diameter = dBar.getval();
  curBlt.weight = wBar.getval();
  curBlt.velocity = vBar.getval();

//  checkMemory();

  checkForHelp();
}


void checkMemory() {
  if (mouseX < displayWidth*0.14 && mouseY > displayHeight*0.90) {  
    noLoop();
    curBlt.diameter = dBar.getval();
    curBlt.weight = wBar.getval();
    curBlt.velocity = vBar.getval(); 
    
    vBar.setcarot(memBlt.velocity);
    vBar.update();
    dBar.setcarot(memBlt.diameter);
    dBar.update();
    wBar.setcarot(memBlt.weight);
    wBar.update();

    hldBlt = curBlt;  
    curBlt = memBlt;
    memBlt = hldBlt;
  }
}  

void mouseReleased() {
  loop();
}     



void checkForHelp() {
  int fontSize = int(displayWidth/25);
  if (mouseX > displayWidth*0.86 && mouseY > displayHeight*0.90) {    
    int Y=int(displayHeight*0.01); 
    fill(255);
    rect(1, 1, displayWidth, displayHeight);
    fill(0);
    textAlign(CENTER);
    textSize(fontSize);
    text("ABOUT VIRGEL", displayWidth/2, Y+=fontSize);
    text("ABOUT VIRGEL", displayWidth/2+2, Y+1);    
    //    text("(Tap to Return)", displayWidth/2,Y+=fontSize); 

    text("", displayWidth*0.06, Y+=fontSize); 

    textAlign(LEFT);  

    text("VIRGEL Isn't Really GELatin. It has limitations:", displayWidth*0.06, Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+1, Y+1); 
    text("For example, VIRGEL can't predict bullet expansion ", displayWidth*0.06, Y+=fontSize);
    text("or deal with ''tumbling'' bullets. But VIRGEL is", displayWidth*0.06, Y+=fontSize);  
    text("cheaper than real gelatin and fits the pocket.", displayWidth*0.06, Y+=fontSize); 


    text("", displayWidth*0.06, Y+=fontSize); 

    text("VIRGEL estimates penetration using a simplified", displayWidth*0.06, Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+1, Y+1);     
    text("''THOR'' equation - a relic of cold-war ballistics", displayWidth*0.06, Y+=fontSize);  
    text("research - (see ''Quantitative Ammunition Selection''", displayWidth*0.06, Y+=fontSize);
    text("ch 9, by Charles Schwartz) fitted to data from", displayWidth*0.06, Y+=fontSize);     
    text("Duncan MacPherson's penetration modeling (see", displayWidth*0.06, Y+=fontSize);         
    text("MacPherson's ''Bullet Penetration'', ch. 10).", displayWidth*0.06, Y+=fontSize);  


    text("", displayWidth*0.06, Y+=fontSize);   

    text("VIRGEL calculates self-defense wound mass using", displayWidth*0.06, Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("MacPherson's Wound Trauma Incapacitation model,", displayWidth*0.06, Y+=fontSize);     
    text("ignoring the last 3'' of penetration as too slow", displayWidth*0.06, Y+=fontSize);  
    text("and penetration beyond 15'' as too late.", displayWidth*0.06, Y+=fontSize); 

    text("", displayWidth*0.06, Y+=fontSize);   

    text("VIRGEL calculates big-game wound mass using the", displayWidth*0.06, Y+=fontSize); 
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("full depth of bullet penetration.", displayWidth*0.06, Y+=fontSize);   

    text("", displayWidth*0.06, Y+=fontSize);  

    text("VIRGEL calculates kinetic energy as a possible", displayWidth*0.06, Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("indicator of barrier penetration and reports the", displayWidth*0.06, Y+=fontSize); 
    text("power factor as an indicator of recoil.", displayWidth*0.06, Y+=fontSize);  

    text("", displayWidth*0.06, Y+=fontSize); 

    text("VIRGEL is intended as a heuristic tool and makes", displayWidth*0.06, Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("no wild claims for accuracy beyond (maybe) two", displayWidth*0.06, Y+=fontSize);     
    text("significant figures. So, don't fret over not nailing", displayWidth*0.06, Y+=fontSize);     
    text("velocity to the last ft/s or weight to the last grain.", displayWidth*0.06, Y+=fontSize);    

    text("", displayWidth*0.06, Y+=fontSize); 

    text("VIRGEL was written in the free and open source", displayWidth*0.06, Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("''Processing 3'' and ''Processing for Android''", displayWidth*0.06, Y+=fontSize);     
    text("languages and is licensed under MIT's open", displayWidth*0.06, Y+=fontSize);    
    text("source initiative ''Approved License.''", displayWidth*0.06, Y+=fontSize);  

    text("", displayWidth*0.06, Y+=fontSize); 

    text("VIRGEL was coded by Ross Kowalski and Robert", displayWidth*0.06, Y+=fontSize);
    text("VIRGEL", displayWidth*0.06+1, Y+1);
    text("Webster in their copious free time. (C) 2021.", displayWidth*0.06, Y+=fontSize);     
    text("", displayWidth*0.06, Y+=fontSize);
  }
}  







void drawInputRect() {
  fill(256);
  //  stroke(0);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*inRectTop, displayWidth*0.9, displayHeight*0.41, 25);
  strokeWeight(4);
}  

void drawOutputRect() {
  fill(256);
  strokeWeight(8); 
  rect(displayWidth*0.05, displayHeight*0.07, displayWidth*0.9, displayHeight*0.41, 25);
  strokeWeight(4);
}    



void getNoseParams()
{
  switch (radiobuttons.getselection()) {
  case 0 : curBlt.setNose(0); break;
  case 1 : curBlt.setNose(1); break;
  case 2 : curBlt.setNose(2); break;
  case 3 : curBlt.setNose(3); break;
  case 4 : curBlt.setNose(4); break;
  case 5 : curBlt.setNose(5); break;
  }
}  




void showTitle(int Y) {
  int fontSize;
  fontSize = int(displayWidth/15);
  if (displayHeight<displayWidth) fontSize = int(displayWidth/30);
  fill(0);
  textAlign(CENTER);  
  textSize(fontSize);
  text(T, displayWidth/2, Y);
  text(T, displayWidth/2+1, Y+1);
  text(T, displayWidth/2+2, Y+2);
}  

void showHelpButton() {
  int fontSize;
  fontSize = int(displayWidth/15); 
  strokeWeight(4);
  fill(255, 0, 0);
  rect(displayWidth*0.85, displayHeight*0.94, displayWidth*0.08, displayHeight*0.05, 25);
  fill(255);  
  text("?", displayWidth*0.887, displayHeight*0.975);
  text("?", displayWidth*0.887+1, displayHeight*0.975+1);  
  fill(0);
}

void  showBulletData(int Y) {
  int V = curBlt.velocity;
  int W = curBlt.weight;
  int D = curBlt.diameter;
  String N = curBlt.getShape();

  
  int fontSize;  
  fontSize = int(displayWidth/20);
  if (displayHeight<displayWidth) fontSize = int(displayWidth/50);
  textSize(fontSize);  
  String data = "";  
  int powerFactor = W * V /1000;
  data = N + ",  " + W + " gr,  "  + D + "/100 in,  " + V + " ft/s";
  text(data, displayWidth/2, Y+2*fontSize);   
  data = "Energy: " + String.valueOf(curBlt.getEnergy())+" ft-lb"
    + "   Power Factor: " + String.valueOf(powerFactor);
  text(data, displayWidth/2, Y+3*fontSize);
}  







//  WC: 0.6887;  0.6850;  1.00
//  TC: 0.7382;  0.7350;  0.66
//  SWC: 0.7299;  0.7250;   0.66
//  RN: 0.7281;  0.7200;  0.66    
//  RB:  0.7485;  0.7450;  0.50
//  MSHRM:  0.7411;  0.7400;  0.82       
//  ACM:  0.72;  0.8      
