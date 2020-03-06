class Mover{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float angle;
  
  Mover(float x, float y, float a){
    mass = random(0.01, 1);
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-2,2), random(-2,2));
    angle = a;
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);    
    acceleration.mult(0);
  }
  
  void display(){
    //float angle = atan2(velocity.x,velocity.y); same as below
    float angle = velocity.heading();
    
    stroke(0);
    fill(175);
    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, mass*16, mass*16);
    popMatrix();
  }
}

Mover[] movers = new Mover[200];

void setup(){
  size(800, 600);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(width), random(height), random(-360, 360));
  }
}
void draw(){
  background(255);
  fill(175);
  stroke(0);
  for(int i = 0; i < movers.length; i++){
    movers[i].update();
    movers[i].display();
  }
  
}
