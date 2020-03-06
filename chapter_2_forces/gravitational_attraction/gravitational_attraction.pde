class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  color self_color;
  
  Mover(float m, float x, float y){
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    self_color = color(random(255), random(255), random(255));
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  PVector attract(Mover m){
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance,5,25);
    
    force.normalize();
    float strength = (0.4 * mass * m.mass) / (distance * distance); // G is 0.4
    force.mult(strength);
    return force;
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
    float angle = velocity.heading();
    
    stroke(0);
    fill(self_color);
    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, mass*16, mass*16);
    popMatrix();
  }
}

class Attractor{
  float mass;
  PVector location;
  float G;
  
  Attractor(float x, float y, float m){
    location = new PVector(x, y);
    mass = m;
    G = 0.4;
  }
  
  PVector attract(Mover m){
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance,5,25);
    
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}

Mover[] movers = new Mover[500];
Attractor[] attractors = new Attractor[5];

void setup(){
  size(1000, 800);
  for (int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(0.1, 2), random(200, 800), random(100, 700));
  }
  for (int j = 0; j < attractors.length; j++){
    attractors[j] = new Attractor(random(200, 800), random(100, 700), random(10, 40));
  }
}

void draw(){
  background(255);
    
  for (int j = 0; j < attractors.length; j++){
    attractors[j].display();
  }
    
  for(int i = 0; i < movers.length; i++){
    for (int j = 0; j < attractors.length; j++){
          PVector force = attractors[j].attract(movers[i]);
          movers[i].applyForce(force);
    }
    for(int k = 0; k < movers.length; k++){
      if( i == k ){
        continue;
      }
      PVector force = movers[k].attract(movers[i]);
      movers[i].applyForce(force);
    }
    
    movers[i].update();
    movers[i].display();
  }
}
