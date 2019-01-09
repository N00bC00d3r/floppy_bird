class Button{
  float centerX,centerY;
  float radius;
  Button(int x,int y){
    centerX=x;
    centerY=y;
    radius=32;
  }
  void show(int r,int g,int b){
    fill(r,g,b);
    ellipse(centerX,centerY,32,32);
  }
  boolean hover(){
    if(dist(centerX,centerY,mouseX,mouseY)<=radius){
      return true;
    }
    else {
      return false;
    }
  }
}
