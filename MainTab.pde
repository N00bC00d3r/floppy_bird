//Main tab for the program
int no_of_birds=600;

int counter=0;
int cycles=1;
int gen_count=0;
double best_score=0;
boolean training_mode=true; 
boolean dontDraw=false;

Neural_Network goat_brain;
Button myButton=new Button(700,100);
Button load=new Button(700,50);
Button train=new Button(700,150);

//Bird goat;
ArrayList<Bird> birds;
ArrayList<Bird> savedBirds;
ArrayList<Pipe> pipes;
//--------------------------------------------------------------------------------------
void setup(){
  size(1000,600);
  birds=new ArrayList<Bird>();
  savedBirds=new ArrayList<Bird>();
  
  pipes=new ArrayList<Pipe>();
  init();
}
//---------------------------------------------------------------------------------------
void draw(){
  if(!dontDraw){
    
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
       for(Bird b: birds){
          if(b.score>best_score){
            goat_brain=b.brain;
            best_score=b.score;
          }
        }
        if(ifAllDead() && training_mode) Restart();
        if(!training_mode && ifAllDead())
        {
          dontDraw=true;
        }
        else dontDraw=false;
        
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
    load.show(0,0,255);
    train.show(255,0,0);
    textSize(16);
    fill(0,0,255);
    text("Load best",725,54);
    fill(0,255,0);
    text("Speed/Slow",725,104);
    fill(255,0,0);
    text("Train Hard",725,154);   
    String generation=str(gen_count);
    String record= str((int)best_score);
    textSize(32);
    fill(0,255,0);
    text("Generation: "+generation,10,30);
    text("best score: "+record,10,60);
  }
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

    birds=nextGeneration(birds);
    pipes.clear();
    counter=0; 
    gen_count++;
  
}
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

    for(int i=0;i<birds.size();i++){
      Bird parent=birds.get(ParentSelection(birds));
      Neural_Network  brains=parent.brain;
      Bird child=new Bird(brains);
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
  else if(load.hover()){
      for(Bird b: birds){
        savedBirds.add(b);
      }
      birds.clear();
      Neural_Network nn=goat_brain;
      Bird newB=new Bird(nn);
      birds.add(newB);
      pipes.clear();
      counter=0; 
      training_mode=false;
      dontDraw=false;
    
  }
  else if(train.hover()){
    if(!training_mode){
      
        birds.clear();
        for(Bird b:savedBirds){
          birds.add(b);
        }
        Restart();
        dontDraw=false;
        training_mode=true;
        //init();
    }
  }
 
}
//---------------------------------------------------------------------------------------------------------
void init(){
    for(int i=0;i<no_of_birds;i++){
    Bird b;
    b=new Bird();
    birds.add(b);
  }
}
