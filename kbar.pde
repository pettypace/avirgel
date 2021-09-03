class kbar{
String ktitle = "";
String units = "";
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





  
     kbar(String title,String u, int xloc,int yloc,int h, int w,int rl,int rh,
            int starting,color bgColor,color fgColor,int mode){
        ktitle =title;
        units   = u;
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
  
  void setTitle(String t){
    ktitle = t;
  }  
  
  
  void setcarot(int cval){
      carot = int(map(cval,rangel,rangeh,0,kwidth));;
  }
  
 void setLeftMargin(int x){
    kx = x;
  } 
  
void setWidth(int w){
  kwidth = w;
}  


void setHeight(int h){
   kheight = h;
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
    
    int radius = 100;
    if(barmode==1) radius = 4;   
    
    fill(kBgColor); 
    rect(kx,ky,kwidth,kheight,kheight/radius); 
    
    fill(kFgColor);
    rect(kx,ky,carot,kheight,kheight/radius);
    fill(255); 
    textSize(kheight/3);
    textAlign(LEFT,CENTER);    
    text(ktitle,kx+kwidth*0.02,ky+kheight/2);
    
    textAlign(RIGHT,CENTER);

    text(int(map(carot,0,kwidth,rangel,rangeh))+units,kx+kwidth*9/10,ky+kheight/2);
 //   text(units,kx+kheight/3,ky+kheight/2);   
   }

int getval(){
   return int(map(carot,0,kwidth,rangel,rangeh));
}

}
