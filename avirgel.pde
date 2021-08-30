
// Android version as of 29 August 2021

String title = "VIRGEL Isn't Really GELLO";
import controlP5.*; // import controlP5 library
ControlP5 cp5; // controlP5 object

RadioButton r1;

float titleScaler = 0.05;
float dataScaler = 0.10;
float penBarScaler = 0.18;
float wtiBarScaler = 0.30;
float buttonInstScaler = 0.48;
float buttonScaler = 0.52;
float buttonLabelScaler = 0.58;
float sliderInstScaler = 0.65;
float slidersScaler = 0.70;

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

int buttonSpacing = 0;
int buttonSize = 0;
int buttonMargin = 0;

void setup() {
  orientation(PORTRAIT);
  size(displayWidth,displayHeight);
  

 cp5 = new ControlP5(this);
 PFont font = createFont("arial",30);
 

 
 
 
 
 cp5.setFont(font);
 leftMargin = int(displayWidth * 0.1);
 
 barHeight = int(displayHeight * 0.08);
 barSpacing = int(displayHeight * 0.125);
 barWidth = int(displayWidth * .8);
 
 buttonSpacing = int(displayWidth * 0.04);
 buttonSize = int(displayWidth * 0.08);
 buttonMargin = int((displayWidth - (6*buttonSize + 5*buttonSpacing))/2);
 
// sliderY = int(displayHeight*0.5); 
 sliderHeight = int(displayHeight * 0.02);
 sliderWidth = int(displayWidth * .80);
 sliderSpacing = int(displayHeight * 0.08);

 addButtons(int(displayHeight*buttonScaler));
 addSliders(int(displayHeight*slidersScaler)); 

}
 
 
void draw() { 
  
  background(#E5DADA);  
  showTitle(int(displayHeight*titleScaler));
 
  reCalculate();
  drawBarGraph(leftMargin,int(displayHeight*penBarScaler),pen,"Penetration in Bare 10% Gelatin (in)");  
  drawBarGraph(leftMargin,int(displayHeight*wtiBarScaler),wtiWoundMass,"MacPherson WTI Wound Mass (g)");  
//  drawBarGraph(leftMargin,barSpacing*3,pcWoundMass,"PC VOL (cc)"); 
  showBulletData(int(displayHeight * dataScaler));
  showSliderInstructions(int(displayHeight * sliderInstScaler));
  showButtonInstructions(int(displayHeight*buttonInstScaler));
  showButtonLabels(int(displayHeight * buttonLabelScaler));

//  showSlideSpace(int(displayHeight*0.60));

}


void showButtonLabels(int Y){
  String[] buttonLabels = {"WC","TC","SWC","RN","RB","MSH"};
  fill(0);
  textSize(25);
  textAlign(CENTER);
  for(int i = 0; i<buttonLabels.length; i++){
  int xPos = buttonMargin + buttonSize/2 + i*(buttonSize+buttonSpacing);
  text(buttonLabels[i],xPos,Y);
  }
    
}

void showSliderInstructions(int Y){
  String t = "TAP then SLIDE to change values below:";
  textAlign(CENTER);
  textSize(30);
  text(t, displayWidth/2,Y);
}  



void showButtonInstructions(int Y){
  String t = "Current bullet nose shape is: " + nose;
  textAlign(CENTER);
  textSize(30);
  text(t, displayWidth/2,Y);
  t = "Double tap a button below to change it.";
  text(t, displayWidth/2,Y+30);  
  
}
  



  void showSlideSpace(int Y){
    int X = leftMargin+50;
 //   int Y = int(displayHeight*0.95);
    int W = sliderWidth;
    int H = int(sliderHeight);
    
    fill(118);
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
  int fontSize = int(displayWidth/15);
  fill(0);
  textAlign(CENTER);
  
  textSize(fontSize);
  //  textSize(fontSize);
  text(title, displayWidth/2,Y);
}  

void showBulletData(int Y){

  String data = "";
  
  float D = Math.round(diameter*100)/100;
  D = diameter;
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
         .setPosition(buttonMargin,Y)
         .setSize(buttonSize,buttonSize)
 //       .setFont(font)
//         .setColorForeground(color(#F0B5B5))
         .setColorForeground(color(255))
         .setColorBackground(color(255))
 //        .setColorActive(color(#2AF535))
         .setColorActive(color(255))
         .setColorLabel(color(0))
         .setItemsPerRow(6)
         .setSpacingColumn(buttonSpacing)
         .addItem("wc",1)            
         .addItem("tc",2)
         .addItem("sw",3)
         .addItem("rn",4)
         .addItem("rb",5)  
         .addItem("msh",6)
         ;
//    int i = 0;     
//    String[] buttonLabels = {"WC","TC","SWC","RN","RB","MSH"};   
     for(Toggle t:r1.getItems()) {
  //     t.getCaptionLabel().setColorBackground(color(255,#E5DADA));
  //     t.getCaptionLabel().getStyle().moveMargin(0,-40,0,-3);
  //     t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
 //      t.getCaptionLabel().getStyle().backgroundWidth = 45;
  //     t.getCaptionLabel().getStyle().backgroundHeight = 13;
         t.setLabel("");     
       
     }
     r1.activate(0);
  
}






void addSliders(int Y)
{


Slider S1 =  cp5.addSlider("Diameter")
       .setPosition(leftMargin, Y)
       .setSize(sliderWidth,sliderHeight)
//       .setNumberOfTickMarks(101)
       .setRange(0.20, 1.20)
       .setValue(.35)
       .setLabel("Dia")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(#F5839E)) 
       .setColorForeground(color(#2AF535))
       .setColorBackground(color(255, 255, 255));
     Label label1 = S1.getCaptionLabel() 
 //      .setFont(font1);
         .toUpperCase(false)
         .setText("Bullet Diameter (in):") 
         .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
 //      .getStyle().setPaddingLeft(50); 
       

       cp5.getController("Diameter")
             .getValueLabel()
             .align(ControlP5.RIGHT, ControlP5.TOP_OUTSIDE)
             .setPaddingX(0)
             .setPaddingY(0)
         //  .setFont(font)
         ;


 
 
  Slider S2 = cp5.addSlider("Weight")
       .setPosition(leftMargin, Y+sliderHeight+sliderSpacing)
       .setSize(sliderWidth,sliderHeight)
       .setRange(10, 500)
       .setValue(148)
       .setLabel("Wgt")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(#F5839E)) 
       .setColorForeground(color(#2AF535))
       .setColorBackground(color(255, 255, 255));
 
        label1 = S2.getCaptionLabel()
  //      .setFont(font1);
         .toUpperCase(false)
         .setText("Bullet Weight (gr):") 
         .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
 //      .getStyle().setPaddingLeft(50); 
       cp5.getController("Weight")
             .getValueLabel()
             .align(ControlP5.RIGHT, ControlP5.TOP_OUTSIDE)
             .setPaddingX(0)
             .setPaddingY(0)
         //  .setFont(font)
         ;  
  
  
  
  
 Slider S3 = cp5.addSlider("Velocity")
       .setPosition(leftMargin, Y+2*(sliderHeight+sliderSpacing))
       .setSize(sliderWidth,sliderHeight)
       .setRange(400, 1600)
       .setValue(650)
       .setLabel("Vel")
       .setColorCaptionLabel(color(0))
       .setColorValue(color(0))  
       .setColorActive(color(#F5839E)) 
       .setColorForeground(color(#2AF535))
       .setColorBackground(color(255, 255, 255)); 
        label1 = S3.getCaptionLabel()
  //      .setFont(font1);
         .toUpperCase(false)
         .setText("Bullet Velocity (ft/s):") 
         .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
 //      .getStyle().setPaddingLeft(50); 
       cp5.getController("Velocity")
             .getValueLabel()
             .align(ControlP5.RIGHT, ControlP5.TOP_OUTSIDE)
             .setPaddingX(0)
             .setPaddingY(0)
         //  .setFont(font)
         ;  
}
 
 
 void Diameter(float val)
 {
//   val = Math.round(val * 100);
 //  val = val/100;
    diameter = val;
 }
 
 void Weight(int val)
 {
    weight = val;
 }
 
 void Velocity(int val)
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
 
