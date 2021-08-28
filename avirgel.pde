
/* virgel for android 8/25/2021 edition */


String title = "VIRGEL Isn't Really GELLO";
import controlP5.*; // import controlP5 library
ControlP5 cp5; // controlP5 object

RadioButton r1;

String nose = "WC";
float diameter = 0.35;
int weight = 148;
int velocity = 650;
float alpha = 0.685;
float phi = 1.0;
double energy = Math.pow(velocity,2)*weight/450240;


double pen = 0;
double wtiPen = 0;
double wtiWoundMass = 0;
double pcWoundMass = 0;

int leftMargin = 0;
int barHeight      = 0;
int barSpacing     = 0;
int barWidth       = 0;

int sliderHeight = 0;
int sliderWidth = 0;
int sliderSpacing = 0;
int sliderY = 0;


void setup() {
  orientation(PORTRAIT);
 size(displayWidth,displayHeight);


 cp5 = new ControlP5(this);
 PFont font = createFont("arial",30);
 
 cp5.setFont(font);
 leftMargin = int(displayWidth * 0.1);
 
 barHeight = displayHeight /  12;
 barSpacing = displayHeight / 8;
 barWidth = int(displayWidth * .8);
 
// sliderY = int(displayHeight*0.5); 
 sliderHeight = displayHeight/15;
 sliderWidth = int(displayWidth*.75);
 sliderSpacing = displayHeight / 20;

 addButtons(int(displayHeight*0.45));
 addSliders(int(displayHeight*0.55));
 

 

 
 

}
 
 
void draw() { 
  
  background(#E5DADA);  
  showTitle(int(displayHeight*0.05));
 
  reCalculate();
  drawBarGraph(leftMargin,barSpacing*1,pen,"Penetration in Bare 10% Gelatin (in)");  
  drawBarGraph(leftMargin,barSpacing*2,wtiWoundMass,"MacPherson WTI Wound Mass (g)");  
//  drawBarGraph(leftMargin,barSpacing*3,pcWoundMass,"PC VOL (cc)"); 
  showEnergyAndPower(int(displayHeight * 0.1));
  showInstructions();
  showSlideSpace();

}


void showInstructions(){
  
  String text1 = "Double tap button below to select nose shape.";
  String text2 = "TAP in DIA, WGT, or VEL graph. Then...";
  String text3 = "...SLIDE in gray box below to adjust.";
  textAlign(CENTER);
  textSize(30);
  text(text1, displayWidth/2,displayHeight*0.425);
  text(text2, displayWidth/2,displayHeight*0.55+sliderHeight+sliderSpacing/2+5);
  text(text3, displayWidth/2,displayHeight*0.55+sliderHeight*2+sliderSpacing+40);
}
  



  void showSlideSpace(){
    int X = leftMargin+50;
    int Y = int(displayHeight*0.9);
    int W = sliderWidth;
    int H = int(sliderHeight*1.5);
    
    fill(128);
    rect(X,Y,W,H);
  }  
  
  
  
  void reCalculate(){
    pen = weight*Math.pow(velocity,alpha)/7000/diameter/diameter/3.14*4;
    wtiPen = pen - 3;
    if(wtiPen > 15) wtiPen = 15;
  
    pcWoundMass = pen*3.14*diameter*diameter/4*phi*17;
    pcWoundMass = Math.round(pcWoundMass+0.5);
    wtiWoundMass = wtiPen*3.14*diameter*diameter/4*17*phi; 
    energy = Math.pow(velocity,2)*weight/450240;

  }

void showTitle(int Y){
//  int fontSize = displaywidth/25;
  fill(0);
  textAlign(CENTER);
  
  textSize(50);
  //  textSize(fontSize);
  text(title, displayWidth/2,Y);
}  

void showEnergyAndPower(int Y){
  int powerFactor = weight * velocity /1000;
  fill(0);
  textAlign(CENTER);
  textSize(36);
  
  String data = "Nose=" + nose 
       + "     KE=" + String.valueOf(Math.round(energy))+" ft-lb"
       + "     PF=" + String.valueOf(powerFactor);

  text(data,displayWidth/2,Y);
}  



void drawBarGraph(int x, int y, double value, String label){  
  textAlign(LEFT);
  textSize(30);
  stroke(#E5DADA);
  fill(255);
  rect(x,y,barWidth,barHeight);
  fill(#F5839E);
  rect(x,y,5*(float)value,barHeight);
  fill(0);
  text(String.valueOf(Math.round(value)),x+20,y+barHeight/2+5);
  textAlign(CENTER);
  textSize(35);
  text(label,displayWidth/2,y+barHeight+30);
  
}  
  


void addButtons(int Y)
{
 
  
     r1 = cp5.addRadioButton("noseButton")
         .setPosition(leftMargin/2,Y)
         .setSize(50,50)
 //       .setFont(font)
         .setColorForeground(color(128))
         .setColorBackground(color(255))
         .setColorActive(color(#F5839E))
         .setColorLabel(color(0))
         .setItemsPerRow(6)
         .setSpacingColumn(60)
         .addItem("wc",1)            
         .addItem("tc",2)
         .addItem("sw",3)
         .addItem("rn",4)
         .addItem("rb",5)  
         .addItem("msh",6)
         ;
     
     for(Toggle t:r1.getItems()) {
       t.getCaptionLabel().setColorBackground(color(255,#E5DADA));
       t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
       t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
       t.getCaptionLabel().getStyle().backgroundWidth = 45;
       t.getCaptionLabel().getStyle().backgroundHeight = 13;
     }
     r1.activate(0);
  
}






void addSliders(int Y)
{


Slider S1 =  cp5.addSlider("diameterSlider")
       .setPosition(leftMargin+50, Y)
       .setSize(sliderWidth,sliderHeight)
       .setRange(0.2, 1.0)
       .setValue(.35)
       .setLabel("Dia")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(128)) 
       .setColorForeground(color(#F5839E))
       .setColorBackground(color(255, 255, 255));
       Label label1 = S1.getCaptionLabel(); 
 //      label1.setFont(font1);
       label1.toUpperCase(false);
       label1.setText("DIA"); // to update upperCase state
       label1.align(ControlP5.LEFT_OUTSIDE, CENTER);
       label1.getStyle().setPaddingLeft(-10); 

 
 
  Slider S2 = cp5.addSlider("weightSlider")
       .setPosition(leftMargin+50, Y+sliderHeight+sliderSpacing)
       .setSize(sliderWidth,sliderHeight)
       .setRange(10, 500)
       .setValue(148)
       .setLabel("Wgt")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(128)) 
       .setColorForeground(color(#F5839E))
       .setColorBackground(color(255, 255, 255));
 
         Label label2 = S2.getCaptionLabel(); 
 //      label1.setFont(font1);
       label2.toUpperCase(false);
       label2.setText("WGT"); // to update upperCase state
       label2.align(ControlP5.LEFT_OUTSIDE, CENTER);
       label2.getStyle().setPaddingLeft(-10); 
  
  
 Slider S3 = cp5.addSlider("velocitySlider")
       .setPosition(leftMargin+50, Y+2*(sliderHeight+sliderSpacing))
       .setSize(sliderWidth,sliderHeight)
       .setRange(400, 1600)
       .setValue(650)
       .setLabel("Vel")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(128)) 
       .setColorForeground(color(#F5839E))
       .setColorBackground(color(255, 255, 255)); 
    Label label3 = S3.getCaptionLabel(); 
 //      label1.setFont(font1);
       label3.toUpperCase(false);
       label3.setText("VEL"); // to update upperCase state
       label3.align(ControlP5.LEFT_OUTSIDE, CENTER);
       label3.getStyle().setPaddingLeft(-10); 
}
 
 
 void diameterSlider(float val)
 {
   val = Math.round(val * 100);
   val = val/100;
    diameter = val;
 }
 
 void weightSlider(int val)
 {
    weight = val;
 }
 
 void velocitySlider(int val)
 {
   
    velocity = val;
 }   
 
/*
void keyPressed() {
  switch(key) {
    case('0'): r1.deactivateAll(); break;
    case('1'): r1.activate(0); break;
    case('2'): r1.activate(1); break;
    case('3'): r1.activate(2); break;
    case('4'): r1.activate(3); break;
    case('5'): r1.activate(4); break;
    case('6'): r1.activate(5); break;    
  }
  
}
 
 */
 

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r1)) {
    if(int(theEvent.getGroup().getValue())== 1){nose="WC";alpha=0.685;phi=1.0;}
    if(int(theEvent.getGroup().getValue()) == 2){nose="TC";alpha=0.735;phi=0.66;}
    if(int(theEvent.getGroup().getValue()) == 3){nose="SWC";alpha=0.725;phi=0.66;}
    if(int(theEvent.getGroup().getValue()) == 4){nose="RN";alpha=0.720;phi=0.66;}   
    if(int(theEvent.getGroup().getValue()) == 5){nose="RB";alpha=0.745;phi=0.5;}
    if(int(theEvent.getGroup().getValue()) == 6){nose="MSHRM";alpha=0.740;phi=0.82;}
  }  
} 

 

//  WC: 0.6887;  0.6850;  1.00
//  TC: 0.7382;  0.7350;  0.66
//  SWC: 0.7299;  0.7250;   0.66
//  RN: 0.7281;  0.7200;  0.66    
//  RB:  0.7485;  0.7450;  0.50
//  MSHRM:  0.7411;  0.7400;  0.82       
//  ACM:  0.72;  0.8      
 
