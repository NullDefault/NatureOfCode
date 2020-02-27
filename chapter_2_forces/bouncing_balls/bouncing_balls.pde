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

void setup(){
  size(1000, 500);
  for(int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(0.1, 5), random(width), 0);
  }
}
void draw(){
  background(255);
  
  PVector wind = new PVector(0.001, 0); 
  
  for (int i = 0; i < movers.length; i++){
    
    float c = 0.01;
    float normal = 1;
    float frictionMag = c*normal;
    PVector friction = movers[i].velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMag);
    
    PVector gravity = new PVector(0, 0.1 * movers[i].mass);
    
    movers[i].applyForce(friction);       
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
