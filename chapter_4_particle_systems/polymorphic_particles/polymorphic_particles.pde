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
    fill(0, lifeSpan);
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
    float r = random(1);
    if(r < 0.5){
      particles.add(new Particle(origin));
    }else{
      particles.add(new Confetti(origin));
    }
  }
  
  void applyForce(PVector f){
    for(Particle p: particles){
      p.applyForce(f);
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

class Confetti extends Particle{
  Confetti(PVector loc){
    super(loc);
  }
  
  void display(){
    float theta = map(location.x, 0, width, 0, TWO_PI*2);
    
    rectMode(CENTER);
    fill(0, lifeSpan);
    stroke(0, lifeSpan);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    rect(0, 0, 8, 8);
    popMatrix();
  }
}


ArrayList<ParticleSystem> wrld;

void setup(){
  size(800, 600);
  wrld = new ArrayList<ParticleSystem>();
}

void mousePressed(){
  wrld.add(new ParticleSystem(new PVector(mouseX, mouseY)));
}

void draw(){
  background(255);
  for(ParticleSystem ps: wrld){
    ps.addParticle();
    ps.run();
  }
}
