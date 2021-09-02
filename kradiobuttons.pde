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
  
   kradiobuttons(int nb,int bh,int bw,int leftmar,int rightmar,int yloc,color onClr,color offClr,color lblClr){
       numbuttons   = nb;
       buttonheight = bh;
       buttonwidth  = bw;
       leftmargin   = leftmar;
       rightmargin  = rightmar;
       ylocation    = yloc;       
       xspacing     = int((rightmargin-leftmargin)/numbuttons);
       buttonlist = new kradiobutton[numbuttons];
        for (int q = 0; q < buttonlist.length; q++) {
            buttonlist[q] = new kradiobutton(leftmargin+(xspacing*q),ylocation,bh,bw,onClr,offClr,lblClr);
        }  
        
    }

void setlabel(int index,String intext){
    buttonlist[index].addlabel(intext);
}


void setMargins(int x,int y){
  leftmargin = x;
  rightmargin = y;
  xspacing = int((rightmargin-leftmargin)/numbuttons);
  for (int i=0;i<buttonlist.length;i++){
    buttonlist[i].kx = leftmargin+xspacing*i;
  }
}

void setSize(int s){
  for(int i=0;i<buttonlist.length;i++){
    buttonlist[i].kwidth = s;
    buttonlist[i].kheight = s;  
  }  
}  



void setY(int y){
  ylocation = y;
  for (int i = 0; i < buttonlist.length; i++) {
    buttonlist[i].setY(y);}
}  



int getselection(){
 return active;
}

void setSelection(int B){
  for (int d=0;d<buttonlist.length;d++) buttonlist[d].off();
  buttonlist[B].on();
  active = B;
  update();
  
}  




  
  void update(){
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
