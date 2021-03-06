class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover(float m, float x, float y){
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
  
  void checkEdges(){
    if(location.x > width){
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x *= -1;
      location.x = 0;
    }
    
    if(location.y > height){
      velocity.y *= -1;
      location.y = height;
    }
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass * 16, mass * 16);
  }
}

Mover[] movers = new Mover[100];
float repel_force = 1.0;

void repel(Mover m){
  if(m.location.x > width*.90){
    m.applyForce(new PVector(-repel_force, 0));
  }
  if(m.location.x < width-width*.90){
    m.applyForce(new PVector(repel_force, 0));
  }
  if(m.location.y > width*.90){
    m.applyForce(new PVector(0, -repel_force));
  }
  if(m.location.y < width-width*.90){
    m.applyForce(new PVector(0, repel_force));
  }
  
}

void setup(){
  size(1000, 500);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(0.1, 5), random(width), random(height));
  }
}
void draw(){
  background(255);
  PVector wind = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
  
  for (int i = 0; i < movers.length; i++){
    movers[i].applyForce(wind);
    repel(movers[i]);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
