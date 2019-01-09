public class Bird{
  double xpos,ypos;
  double velocity;
  double size;
  double gravity=0.6;
  double lift=-20;
  boolean dead=false;
  double score;
  double fitness;
  public Neural_Network brain;
//----------------------------------------------------------------------------------------------------------
  Bird(Neural_Network brain){
    this.xpos=64;
    this.ypos=height/2;
    this.velocity=0;
    this.size=32;
    this.brain=brain;
    this.score=0.0;
    this.fitness=0.0;
  }
//-------------------------------------------------------------------------------------------------------------
  Bird(){
    this.xpos=64;
    this.ypos=height/2;
    this.velocity=0;
    this.size=32;
    this.brain=new Neural_Network(5,10,2);
    this.score=0.0;
    this.fitness=0.0;
  }
//----------------------------------------------------------------------------------------------------------------
  void think(ArrayList<Pipe> pipes){
    double[] inputs=new double[5];
    int closest_pipe_index=0;
    double closest_dist=10000;
    for(int i=0;i<pipes.size();i++){
      double newDist=pipes.get(i).xpos+pipes.get(i).wid-this.xpos;
      if(newDist>0 && newDist<closest_dist){
        closest_pipe_index=i;
        closest_dist=newDist;
      }
    }
    Pipe closest_pipe=pipes.get(closest_pipe_index);
    //closest_pipe.setRGB(255,0,0);
    //inputs will be : 1.closest pipes x 2.closest pipes top y 3. bottom y 4.birds y 5.speed in that order
     //println(height+" "+width);
    inputs[0]=this.ypos/height;
    inputs[1]=closest_pipe.xpos/width;
    inputs[2]=closest_pipe.top_fin/height;
    inputs[3]=closest_pipe.bottom_start/height;
    inputs[4]=this.velocity/10;
    double[] outputs=brain.feedforward(inputs);
    if(outputs[0]>outputs[1])
    this.up();
    //else println("bhou");
  }
//-----------------------------------------------------------------------------------------------------
  void update(){
    score++;
    this.velocity+=gravity;
    this.velocity*=0.8;
    this.ypos+=this.velocity;
    if(this.ypos>height || this.ypos<0)
    {
        dead=true;
    }
  }
//----------------------------------------------------------------------------------------------------------
  void show(){
    fill(255);
    noStroke();
    ellipse((float)xpos,(float)ypos,(float)size,(float)size);
  }
//---------------------------------------------------------------------------------------------------------
  void up(){
    this.velocity+=lift;
  }
//------------------------------------------------------------------------------------------------------------
  void mutate(){
    this.brain.mutate(0.3);
  }
//------------------------------------------------------------------------------------------------------------
  public Neural_Network getBrain(){
    return this.brain;
  }
}
