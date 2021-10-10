
public class Bullet {
  String id = "";
  int nose = 0; 
  int weight = 0;
  int velocity = 0;
  int diameter = 0;

  Bullet(String i, int n, int d, int w, int v) {
    id = i;
    nose = n;
    diameter = d;
    weight = w;
    velocity = v;
  }
 
void setId(String i){
  id = i;
}


void setNose(int n){
  nose = n;
}  



void setDiameter(int d){
  diameter = d;
}



void setWeight(int w){
  weight = w;
}

void setVelocity(int v){
  velocity = v;
}

int getDiameter(){
  return diameter;
} 

int getWeight(){
  return weight;
}


int getVelocity(){
  return velocity;
}

int getNose(){
  return nose;
}

String getId(){
  return id;
}  


int getPen(){
  int pen = 0;
  double alpha = 0;
  switch (nose) {
    case 0 : alpha=0.685;  break;
    case 1 : alpha=0.735;  break;
    case 2 : alpha=0.725;  break;
    case 3 : alpha=0.720;  break;
    case 4 : alpha=0.745;  break;
    case 5 : alpha=0.740;  break;
  }  
  pen = (int) Math.round(weight*Math.pow(velocity, alpha)/.7/diameter/diameter/3.14*4);
  if (pen < 0) pen = 0;
  return pen;
}

int getBgMass(){
  double phi = 0;
  double alpha = 0;
  int m = 0;
  switch (nose) {
    case 0 : phi=1.0; alpha=0.685; break;
    case 1 : phi=0.66; alpha=0.735; break;
    case 2 : phi=0.66; alpha=0.725;break;
    case 3 : phi=0.66; alpha=0.720; break;
    case 4 : phi=0.50; alpha=0.745;break;
    case 5 : phi=0.82; alpha=0.740;break;
  }    
   m = (int) Math.round(Math.pow(velocity, alpha)*weight/7000*17*phi);  
  if(m < 0) m=0;
  return m;
}  



int getWtiMass(){
  double phi = 0;
  double alpha = 0;
  double pen = 0;
  int m = 0;
  switch (nose) {
    case 0 : phi=1.0; alpha=0.685; break;
    case 1 : phi=0.66; alpha=0.735; break;
    case 2 : phi=0.66; alpha=0.725;break;
    case 3 : phi=0.66; alpha=0.720; break;
    case 4 : phi=0.50; alpha=0.745;break;
    case 5 : phi=0.82; alpha=0.740;break;
  } 
  pen =   weight*Math.pow(velocity, alpha)/.7/diameter/diameter/3.14*4 - 3;  //discount last 3"
  if (pen > 15) pen = 15;     //discount anything over 15"
  m = (int) Math.round(pen*3.14*diameter*diameter*17*phi/4/10000); 
  if(m<0) m=0;
  return m;
}  
  
  
int getEnergy(){
  return (int) Math.round(velocity*velocity*weight/450240);
} 



String getShape(){
  String s = "";
  switch (nose) {
    case 0 : s = "WC"; break; 
    case 1 : s = "TC"; break; 
    case 2 : s = "SWC"; break; 
    case 3 : s ="RN"; break; 
    case 4 : s = "RB"; break; 
    case 5 : s = "MSH"; break; 
  }   
  return s;

}

}
