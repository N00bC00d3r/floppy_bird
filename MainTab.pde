//Main tab for the program
int no_of_birds=1000;

int counter=0;
int cycles=1;
int gen_count=0;


Button myButton=new Button(700,100);
//Button load=new Button(700,50);

//Bird goat=new Bird();
ArrayList<Bird> birds;
ArrayList<Pipe> pipes;
//--------------------------------------------------------------------------------------
void setup(){
  size(800,600);
  birds=new ArrayList<Bird>();
  for(int i=0;i<no_of_birds;i++){
    Bird b;
    b=new Bird();
    birds.add(b);
  }
  pipes=new ArrayList<Pipe>();
  //Pipe p=new Pipe();
  //pipes.add(p);
}
//---------------------------------------------------------------------------------------
void draw(){
  
  for(int n=0;n<cycles;n++){
     
    //Main game logic
      if(counter%300==0)
      {
        Pipe p=new Pipe();
        pipes.add(p);
        
      }
      counter++;
      for(int i=pipes.size()-1;i>=0;i--){
        Pipe p=pipes.get(i);
        p.update();
       // p.show();
        for(int j=birds.size()-1;j>=0;j--){
          if(p.hit(birds.get(j))){
            birds.get(j).dead=true;
          }
        }
        if(p.offScreen())
        {
          pipes.remove(i);
        }
      }
        for(int j=birds.size()-1;j>=0;j--){
           Bird b=birds.get(j);
           if(!b.dead)
           {
               b.think(pipes);
               b.update();
               //b.show();
           }
        }
        if(ifAllDead()) Restart();
        
  }      
      
    //all the drawing stuff
     background(0);
    for(Bird b :birds){
      if(!b.dead)
      {
          b.show();
      }
    }
    for(Pipe p:pipes){
      p.show();
    }
    myButton.show(0,255,0);
    //load.show(0,0,255);
}
//------------------------------------------------------------
boolean ifAllDead(){
  for(int i=0;i<birds.size();i++){
    if(!birds.get(i).dead) return false;
  }
  return true;
}
//---------------------------------------------------------------------------------------------------
void Restart(){
    //for(Bird b: birds){
    //  if(b.score>goat.score){
    //    goat=b;
    //  }
    //}
    birds=nextGeneration(birds);
    pipes.clear();
    counter=0; 
    gen_count++;
  
}
//------------------------------------------------------------------------------------------------------
//void keyPressed(){
//  if(key==' '){
//      birds.get(0).up();
//  }
//}
//-------------------------------------------------------------------------------------------------------
void calculateFitness(ArrayList<Bird> birds){
    double sum=0.0;
    for(int i=0;i<birds.size();i++){
      sum+=birds.get(i).score;
    }
    for(int i=0;i<birds.size();i++){
      Bird b=birds.get(i);
      b.fitness=(b.score)/sum;
    }
 }
//---------------------------------------------------------------------------------------------------------
int ParentSelection(ArrayList<Bird> birds)
  {
      double r=Math.random();
      double runningsum=0.0;
      for(int i=0;i<birds.size();i++){
          Bird b=birds.get(i);
          runningsum+=b.fitness;
          if(runningsum>=r) return i;
      }
      return birds.size()-1;
  }
//-------------------------------------------------------------------------------------------------------------
ArrayList<Bird> nextGeneration(ArrayList<Bird> birds){
    ArrayList<Bird> newBirds=new ArrayList<Bird>();
    calculateFitness(birds);
    //for(int i=0;i<birds.size();i++){
    //  println("fitness of "+i+": "+birds.get(i).fitness);
    //}
    for(int i=0;i<birds.size();i++){
      Bird parent=birds.get(ParentSelection(birds));
      Neural_Network  brains=parent.getBrain();
     // brains.printNN();
      Bird child=new Bird(brains);
      //child.brain.printNN();
      child.mutate();
      newBirds.add(child);
    }
    return newBirds;
}
//-----------------------------------------------------------------------------------------------------
void mousePressed(){
  if(myButton.hover()){
    if(cycles==1) cycles=100;
    else cycles=1;
  }
  //else if(load.hover()){
  //  birds.clear();
  //  Bird greatest=new Bird(goat.getBrain());
  //  birds.add(greatest);
  //  println(greatest.dead);
  //  pipes.clear();
  //  counter=0; 
    
  //}
  println("gen:"+gen_count);
  //println("goat_score:"+goat.score);
 
}
//---------------------------------------------------------------------------------------------------------
