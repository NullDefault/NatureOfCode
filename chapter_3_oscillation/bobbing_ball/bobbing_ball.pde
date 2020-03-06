class Bob {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Bob(float m, float x, float y){
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass * 16, mass * 16);
  }
}

class Spring{
  PVector anchor;
  float len;
  float k = 0.1;
  
  Spring(float x, float y, int l){
    anchor = new PVector(x, y);
    len = l;
  }
  
  void connect(Bob b){
    PVector force = PVector.sub(b.location, anchor);
    float d = force.mag();
    float stretch = d - len;
    force.normalize();
    force.mult(-1*k*stretch);
    b.applyForce(force);
  }
  
  void display(){
    fill(100);
    rectMode(CENTER);
    rect(anchor.x, anchor.y, 10, 10);
  }
  
  void displayLine(Bob b){
    stroke(0);
    line(b.location.x, b.location.y, anchor.x, anchor.y);
  }
}

Bob bob;
Spring spring;

void setup(){
  size(800, 600);
  bob = new Bob(10, width/2, height/2);
  spring = new Spring(width/2, 0, 200);
}

void draw(){
  background(255);
  PVector gravity = new PVector(0, 1);
  bob.applyForce(gravity);
  
  spring.connect(bob);
  spring.displayLine(bob);
  bob.update();
  bob.display();
  spring.display();
}
