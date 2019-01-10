class Pipe{
  double xpos,top_fin,bottom_start;
  double wid;
  double gap=150;
  double separator;
  double speed=2;
  int r=255,g=255,b=255;
//--------------------------------------------------------------------------------------------------------
  void setRGB(int r,int g,int b){
    this.r=r;
    this.g=g;
    this.b=b;
  }
//-----------------------------------------------------------------------------------------------------------
  Pipe(){
    xpos=width;
    separator=random(0,height/2);
    top_fin=separator;
    bottom_start=top_fin+gap;
    wid=60;
  }
//--------------------------------------------------------------------------------------------------------------
  void update(){
    this.xpos-=speed;
  }
//-------------------------------------------------------------------------------------------------------------
  void show(){
    fill(r,g,b);
    rect((float)xpos,0,(float)wid,(float)top_fin);
    rect((float)xpos,(float)bottom_start,(float)wid,(float)(height-bottom_start));
  }
//--------------------------------------------------------------------------------------------------------------
  boolean offScreen(){
    if(this.xpos+this.wid<0)
    return true;
    else return false;
  }
//--------------------------------------------------------------------------------------------------------------
  boolean hit(Bird b){
    //if(((b.ypos>0 && b.ypos<=this.top_fin)||
    //(b.ypos>=this.bottom_start && b.ypos<=height))&&
    //(b.xpos>=this.xpos && b.xpos<=this.xpos+this.wid))
    //return true;
    //else return false;
    if(collisionDetection(xpos,0,wid,top_fin,b.xpos,b.ypos,b.size) || 
    collisionDetection(xpos,bottom_start,wid,height-bottom_start,b.xpos,b.ypos,b.size))
    {
        return true;
    }
    else return false;
  }
//-----------------------------------------------------------------------------------------------------------------
  boolean collisionDetection
  (double rectx,double recty,double rectw,double recth,double circlex,double circley,double radius)
  {
          double closestx=circlex,closesty=circley;
          if(circlex<=rectx) closestx=rectx;
          if(circlex>=rectx+rectw) closestx=rectx+rectw;
          if(circley<=recty) closestx=recty;
          if(circley>=recty+recth) closesty=recty+recth;
          double distance=dist((float)circlex,(float)circley,(float)closestx,(float)closesty);
          if(distance<=radius-10) return true;
          else return false;
          
  
  }
//------------------------------------------------------------------------------------------------------------------
  
}
