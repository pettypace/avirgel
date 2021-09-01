class kbar{

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
color kBgColor  =0;
color kFgColor =128;
String units = "";




  
     kbar(int xloc,int yloc,int h, int w,int rl,int rh,int starting,color bgColor,color fgColor,int mode,String u){
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
        
  
        carot   = int(map(starting,rangel,rangeh,0,kwidth));
  }
  
  
  void setcarot(int cval){
      carot = int(map(cval,rangel,rangeh,0,kwidth));;
  }
  
 void setLeftMargin(int x){
    kx = x;
  } 
  
void setBarWidth(int w){
  kwidth = w;
}  
  
void setY(int y){
  ky = y;
}  
  
  
  void update(){
    if(barmode == 1){
        if(mouseX > kx && mouseX < kx+kwidth && mouseY > ky && mouseY < ky+kheight && mousePressed==true){
           carot = mouseX-kx;
        }
    }
    
    
  
    
    
    fill(kBgColor); 
    rect(kx,ky,kwidth,kheight,kheight/4); 
    
    fill(kFgColor);
    rect(kx,ky,carot,kheight,kheight/4);
    
    textAlign(RIGHT,CENTER);
    fill(255);
    text(int(map(carot,0,kwidth,rangel,rangeh))+units,kx+kwidth*9/10,ky+kheight/2);
 //   text(units,kx+kheight/3,ky+kheight/2);   
   }

int getval(){
   return int(map(carot,0,kwidth,rangel,rangeh));
}

}
