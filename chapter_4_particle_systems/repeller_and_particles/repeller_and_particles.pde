import java.util.Iterator;

class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifeSpan;
  
  float mass = 1;
  
  Particle(PVector loc){
    location= loc.get();
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-2,0));
    
    lifeSpan = 255;
  }
  
  void run(){
    update();
    display();
  }
  
  void applyForce(PVector force){
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifeSpan -= 2.0;
  }
  
  boolean isDead(){
    if (lifeSpan < 0.0){
      return true;
    } else {
      return false;
    }
  }
  
  void display(){
    stroke(0, lifeSpan);
    fill(175, lifeSpan);
    ellipse(location.x, location.y, 8 * mass, 8 * mass);
  }  
}

class ParticleSystem{
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector o){
    particles = new ArrayList<Particle>();
    origin = o.get();
  }
  
  void addParticle(){
    particles.add(new Particle(origin));
  }
  
  void applyForce(PVector f){
    for(Particle p: particles){
      p.applyForce(f);
    }
  }
  
  void applyRepeller(Repeller r){
    for(Particle p: particles){
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }
  
  void run(){
    Iterator<Particle> i = particles.iterator();
    while(i.hasNext()){
      Particle p = i.next();
      p.run();
      if(p.isDead()){
        i.remove();
      }
    }
  }
}

class Repeller{
  PVector location;
  float r = 100;
  float strength = 1000;
  
  Repeller(PVector loc){
    location = loc.get();
  }
  
  PVector repel(Particle p){
    PVector dir = PVector.sub(location, p.location);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d, 5, 500);
    float force = -1 * strength / (d * d);
    dir.mult(force);
    return dir;
  }
  
  void display(){
    stroke(255);
    fill(255);
    ellipse(location.x, location.y, r, r);
  }
}

ParticleSystem ps;
Repeller repeller;

void setup(){
  size(800, 600);
  ps = new ParticleSystem(new PVector(width/2, 100));
  repeller = new Repeller(new PVector(width/2-20,height/2));
}

void draw(){
  background(100);
  ps.addParticle();
  
  PVector gravity = new PVector(0, 0.1);
  ps.applyForce(gravity);
  ps.applyRepeller(repeller);
  
  ps.run();
  repeller.display();
}
