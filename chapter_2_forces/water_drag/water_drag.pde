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
  
  boolean isInside(Liquid l){
    if (location.x > l.x && location.x < l.x+l.w && location.y > l.y && location.y < l.y+l.h){
      return true;
    }else{
      return false;
    }
  }
  
  void drag(Liquid l){
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed;
    
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass * 16, mass * 16);
  }
}

class Liquid{
  float x,y,w,h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  void display(){
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }

}

Mover[] movers = new Mover[50];
Liquid liquid;

void setup(){
  size(360, 640);
  for (int i = 0; i < movers.length; i++){
    movers[i] = new Mover(random(0.1,5), random(width), 0);
  }
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
}

void draw(){
  background(255);
  
  liquid.display();
  
  for(int i = 0; i < movers.length; i++){
    if (movers[i].isInside(liquid)){
      movers[i].drag(liquid);
    }
    
    float m = 0.1*movers[i].mass;
    PVector gravity = new PVector(0, m);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
