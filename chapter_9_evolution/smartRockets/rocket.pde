class Rocket{
  DNA dna;
  boolean stopped;
  float recordDist;
  boolean hitTarget;
  float fitness;
  int finishTime;
  float r;
  color c;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Rocket(){
    dna = new DNA(lifetime);
    stopped = false;
    recordDist = 10000;
    finishTime = 0;
    hitTarget = false;
    c = color(random(255), random(255), random(255));
    r = 3.0;
    location = new PVector(width/2, height - r);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }
  
  void applyForce(PVector f){
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void fitness(){  
    fitness = (1/(finishTime*recordDist));
    fitness = pow(fitness, 2);
    if (!hitTarget && stopped)fitness *= 0.1;
    if(hitTarget) fitness *= 2;
  }
  
  Rocket crossover(Rocket partner){
    Rocket child = new Rocket();
    int midPoint = (int) random(0, dna.genes.length);
    
    for(int i = 0; i < dna.genes.length; i++){
      if(i < midPoint){
        child.dna.genes[i] = dna.genes[i];
      }else{
        child.dna.genes[i] = partner.dna.genes[i];
      }
    }
    return child;
  }
  
  void mutate(){
    float mutationRate = 0.01;
    for(int i = 0; i < dna.genes.length; i++){
      if(random(1) < mutationRate){
        dna.genes[i] = PVector.random2D();
        dna.genes[i].mult(random(0, maxforce));
      }
    }
  }
  
  void checkTarget(){
    float dToTarg = PVector.dist(location, target);
    
    if(dToTarg < 16){
      stopped = true;
      hitTarget = true;
    }
    else{
      finishTime++;
      for(Obstacle obs : obstacles){
        if(obs.contains(location)){
          stopped = true;
        }
      }
    }
    
    if(dToTarg < recordDist) recordDist = dToTarg;
    
  }
  
  int geneCounter = 0;
  
  void run(){
    checkTarget();
    if(!stopped){
      applyForce(dna.genes[geneCounter]);
      geneCounter = (geneCounter + 1) % dna.genes.length;
      update();
    }
  }
  void display(){
    float theta = velocity.heading() + PI/2;
    fill(c);
    stroke(0, 0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}
