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


void setLeftMargin(int x){
  leftmargin = x;
}





int getselection(){
 return active;
}


  
  void update(){
      for (int d=0;d<buttonlist.length;d++) buttonlist[d].off();
  
      for (int v=0;v<buttonlist.length;v++){
        if(mouseX > buttonlist[v].getleft() && mouseX < buttonlist[v].getright() && mouseY > buttonlist[v].gettop() && mouseY < buttonlist[v].getbottom() && mousePressed == true){
           active = v;
        } 
       } 
       
       buttonlist[active].on();

  }



}