class kbar{
String ktitle = "";
String units = "";
String info = "";
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





  
     kbar(String title,String u, String i, int xloc,int yloc,int h, int w,int rl,int rh,
            int starting,color bgColor,color fgColor,int mode){
        ktitle =title;
        units   = u;
        info    = i;
        barmode  = mode;
        kheight = h;
        kwidth  = w;
        kx      = xloc;
        ky      = yloc;
        rangel  = rl;
        rangeh  = rh;
        kBgColor    = bgColor;
        kFgColor    = fgColor;
        carot   = (int)Math.round(map(starting,rangel,rangeh,0,kwidth));
  }
  
  void setTitle(String t){
    ktitle = t;
  }  
  
  
  void setcarot(int cval){
      carot = (int) Math.round(map(cval,rangel,rangeh,0,kwidth));
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
    text(ktitle,kx+kwidth*0.02,ky+kheight/5);  
    textAlign(RIGHT,CENTER);
    text((int)Math.round(map(carot,0,kwidth,rangel,rangeh))+units,kx+kwidth*0.95,ky+kheight/5);
    textAlign(CENTER);
    textSize(kheight/4);
    text(info,kx+kwidth/2,ky+kheight*0.8);
     
     
   }

int getval(){
   return (int)Math.round(map(carot,0,kwidth,rangel,rangeh));
}

}
