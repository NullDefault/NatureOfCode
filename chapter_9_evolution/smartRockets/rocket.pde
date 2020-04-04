class Rocket{
  DNA dna;
  float fitness;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Rocket(){
    dna = new DNA();
  }
  
  void applyForce(PVector f){
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void fitness(PVector target){
    float d = PVector.dist(location, target);
    fitness = pow(1/d, 2);
  }
  
  Rocket crossover(Rocket partner){
    Rocket child = new Rocket();
    
    for(int i = 0; i < dna.genes.length; i++){
      int flip = parseInt(random(2));
      if(flip == 0){
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
      }
    }
  }
  
  int geneCounter = 0;
  
  void run(){
    applyForce(dna.genes[geneCounter]);
    geneCounter++;
    update();
  }
}
