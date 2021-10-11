
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


Bullet curBlt;
Bullet memBlt;
Bullet hldBlt;

kbar penBar;
kbar bgBar;
kbar wtiBar;
kbar vBar;
kbar dBar;
kbar wBar;

kradiobuttons radiobuttons;







void setup() {
  
  orientation(PORTRAIT);
  size(displayWidth, displayHeight);  
  
  curBlt = new Bullet("38 Target WC",0,35,148,650);
  memBlt = new Bullet("45 GI Hardball",3,45,230,820);
  hldBlt = new Bullet("32 ACP XTP",5,41,100,940);  
  
  
  vBar = new kbar("Velocity:", " (ft/s)", "", 
                  int(displayWidth*0.10),
                  int(displayHeight*velBarY),
                  int(displayHeight*0.08),
                  int(displayWidth*0.8), 400, 1600, curBlt.getVelocity(), 0, #D12424, 1); 
 
  dBar = new kbar("Diameter:", "/100 (in)", "",
                  int(displayWidth*0.10),
                  int(displayHeight*diaBarY),
                  int(displayHeight*0.08),  
                  int(displayWidth*0.8), 20, 120,curBlt.getDiameter(), 0, #D12424, 1); 
  
  wBar = new kbar("Weight:", " (gr)", "",
                  int(displayWidth*0.10), 
                  int(displayHeight*wgtBarY), 
                  int(displayHeight*0.08), 
                  int(displayWidth*0.80), 0, 500, curBlt.getWeight(), 0, #D12424, 1);   
 
  penBar = new kbar("Penetration:"," (in)","(bare 10% ordnance gelatin)",
                     int(displayWidth*0.10),
                     int(displayHeight*penBarY),
                     int(displayHeight*0.08),
                     int(displayWidth*0.8),0,100,curBlt.getPen(),0,#D12424, 0);                      
                                  
  wtiBar = new kbar("Defense Wound Mass:"," (g)","(per MacPherson WTI model)", 
                     int(displayWidth*0.10), 
                     int(displayHeight*wtiBarY), 
                     int(displayHeight*0.08),
                     int(displayWidth*0.8), 0, 150, curBlt.getWtiMass(), 0, #D12424, 0); 
 
  
  bgBar = new kbar("Big Game Wound Mass:"," (g)","(for entire penetration path)", 
                    int(displayWidth*0.10), 
                    int(displayHeight*bgBarY), 
                    int(displayHeight*0.08), 
                    int(displayWidth*0.8), 0, 150, curBlt.getBgMass(), 0, #D12424, 0);   

  
  //                                                (act,nb,bh,bw,leftmar,rightmar,yloc,onClr,offClr,lblClr) 
  radiobuttons =   new kradiobuttons(curBlt.getNose(),6, 60, 60, 60, 600, 0, 0, #D12424, 255);


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
 
  drawInputRect();
  drawOutputRect();
  showBottomButtons();
  showBulletData(int(displayHeight * bltDataY)); 
  dBar.update();
  vBar.update();
  wBar.update();

//  memBlt = curBlt;
  updateBullet(curBlt);


  penBar.setcarot(curBlt.getPen());  
  penBar.update();

  wtiBar.setcarot(curBlt.getWtiMass());  
  wtiBar.update(); 

  bgBar.setcarot(curBlt.getBgMass());  
  bgBar.update(); 


  radiobuttons.update();


  checkMemory();

  checkForHelp();
  
}

void updateBullet(Bullet aBullet){
  aBullet.setNose(radiobuttons.getselection());
  aBullet.setDiameter(dBar.getval());
  aBullet.setWeight(wBar.getval());
  aBullet.setVelocity(vBar.getval());
}  



void checkMemory() {
  if (mouseX < displayWidth*0.14 && mouseY > displayHeight*0.90&& mousePressed == true) {  
    noLoop();
//    curBlt.diameter = dBar.getval();
//    curBlt.weight = wBar.getval();
//    curBlt.velocity = vBar.getval(); 
    
    vBar.setcarot(memBlt.getVelocity());
    vBar.update();
    dBar.setcarot(memBlt.getDiameter());
    dBar.update();
    wBar.setcarot(memBlt.getWeight());
    wBar.update();
    radiobuttons.setSelection(memBlt.getNose());
    radiobuttons.update();

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

void showBottomButtons() {
  int fontSize;
  fontSize = int(displayWidth/15); 
  strokeWeight(4);
  fill(255, 0, 0);
  rect(displayWidth*0.85, displayHeight*0.94, displayWidth*0.08, displayHeight*0.05, 25);
  fill(255);  
  text("?", displayWidth*0.887, displayHeight*0.978);
  text("?", displayWidth*0.887+1, displayHeight*0.978+1);  
  fill(255, 0, 0);
  rect(displayWidth*0.06, displayHeight*0.94, displayWidth*0.08, displayHeight*0.05, 25);
  fill(255);  
  text("M", displayWidth*0.100, displayHeight*0.978);
  text("M", displayWidth*0.025+1, displayHeight*0.978+1);  
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
