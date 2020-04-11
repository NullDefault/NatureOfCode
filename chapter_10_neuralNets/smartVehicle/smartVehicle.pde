class Perceptron{
  float[] weights;
  float c;
  
  
  Perceptron(int n, float lr){
    c = lr;
    weights = new float[n];
    for(int i = 0; i < weights.length; i++){
      weights[i] = random(-1, 1);
    }
  }
  
  void train(PVector[] forces, PVector error){
    for(int i = 0; i < weights.length; i++){
      weights[i] += c*error.x*forces[i].x;
      weights[i] += c*error.y*forces[i].y;
    }
  }
  
  PVector feedForward(PVector[] forces){
    PVector sum = new PVector();
    for(int i = 0; i < weights.length; i++){
      forces[i].mult(weights[i]);
      sum.add(forces[i]);
    }
    return sum;
  }
}

class Vehicle{
  Perceptron brain;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r;
  float maxforce;
  float maxspeed;
  
  Vehicle(int n, float x, float y){
    brain = new Perceptron(n, 0.001);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 2;
    maxspeed = 4;
    maxforce = 0.1;
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    //<>//
    acceleration.mult(0);
    
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  void steer(ArrayList<PVector> targets){
    PVector[] forces = new PVector[targets.size()];
    
    for(int i = 0; i < forces.length; i++){
      forces[i] = seek(targets.get(i));
    }
    PVector result = brain.feedForward(forces);
    
    applyForce(result);
    
    PVector error = PVector.sub(desiredTarget, location);
    brain.train(forces, error);
  }


  PVector seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }
  
  void display(){
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
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


ArrayList<PVector> targets;
int targetSize = 10;
Vehicle v;
PVector desiredTarget;

void makeTargs(){
  targets = new ArrayList<PVector>();
  for(int i = 0; i < targetSize; i++){
    targets.add(new PVector(random(width), random(height)));
  }
}

void setup(){
  size(1000, 600);
  desiredTarget = new PVector(width/2, height/2);
  makeTargs();
 
  v = new Vehicle(targets.size(), random(width), random(height));
}

void draw(){
  background(255);
  
  stroke(0);
  strokeWeight(4);
  fill(200, 40, 30);
  ellipse(desiredTarget.x, desiredTarget.y, 30, 30);
  
  for(PVector t: targets){
    noFill();
    stroke(0);
    strokeWeight(2);
    ellipse(t.x, t.y, 16, 16);
    line(t.x, t.y-16, t.x, t.y+16);
    line(t.x-16, t.y, t.x+16, t.y);
  }
  
  if(mousePressed){
    makeTargs();
  }
  
  v.steer(targets);
  v.update();
  v.display();
}
