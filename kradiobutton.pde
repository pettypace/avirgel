class kradiobutton{

String buttonlabel = " ";
  int state   = 0;
  int kx      = 0;
  int ky      = 0;
  int kwidth  = 0;
  int kheight = 0;
  color offColor   = 0;
  color onColor    = 0;
  color lblColor     = 0;
 


  kradiobutton(int xloc,int yloc,int h, int w, color offClr, color onClr, color lblClr){
        lblColor = lblClr;
        offColor = offClr;
        onColor = onClr;
    
        kx      = xloc;
        ky      = yloc; 
        kheight = h;
        kwidth  = w;

  }
  
void addlabel(String intext){
    buttonlabel = intext;

}


void setY(int y){
  ky = y;
}  


int getleft(){
    return(kx);
}

int getright(){
    return(kx+kwidth);
}

int gettop(){
    return(ky);
}

int getbottom(){
    return(ky+kheight);
}

int getstate(){
   return state;
} 
  
void on(){
    state = 1;
    fill(onColor); 
    rect(kx,ky,kwidth,kheight,kheight/4);
    
    fill(lblColor); 
    textAlign(CENTER,CENTER);
    text(buttonlabel,kx+kwidth/2,ky+kheight/2);
  }
  
void off(){
    state = 0;
    fill(offColor); 
    rect(kx,ky,kwidth,kheight,kheight/4);
    
    fill(lblColor); 
    textSize(30);
    textAlign(CENTER,CENTER);
    text(buttonlabel,kx+kwidth/2,ky+kheight/2);
  } 

 
  
  }
  
  
  
  
