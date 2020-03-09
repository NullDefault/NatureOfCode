import java.util.*;

class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector loc, PVector acc, PVector vel){
    location= loc.get();
    acceleration = acc.get();
    velocity = vel.get();
    lifespan = 255;
  }
  
  void run(){
    update();
    display();
  }
  
  boolean isDead(){
    if (lifespan < 0.0){
      return true;
    } else {
      return false;
    }
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }
  
  void display(){
    stroke(0, lifespan);
    fill(175, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }  
}

int total = 1000;

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup(){
  size(800, 600);
  for(int i = 0; i < total; i++){
    addParticle();
  }
}

void addParticle(){
    PVector loc = new PVector(width/2, 0);
    PVector acc = new PVector(random(-0.05, 0.05), random(0.01, 0.05));
    PVector vel = new PVector(random(-2, 2), 2);
    
    particles.add(new Particle(loc, acc, vel));
}

void draw(){
  background(0);
  addParticle();
  
  Iterator<Particle> i = particles.iterator();
  while(i.hasNext()){
    Particle p = i.next();
    p.run();
    if(p.isDead()){
      i.remove();
    }
  }
}
