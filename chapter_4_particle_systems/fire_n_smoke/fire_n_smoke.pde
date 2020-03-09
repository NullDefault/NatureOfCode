import java.util.Iterator;
import java.util.Random;

class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifeSpan;
  
  float mass = 1;
  
  Particle(PVector loc){
    location= loc.get();
    acceleration = new PVector(0, 0);
    Random rand = new Random();
    
    float vx = (float) rand.nextGaussian()*0.3;
    float vy = (float) rand.nextGaussian()*0.3 - 1.0;
    velocity = new PVector(vx, vy);
    
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
    imageMode(CENTER);
    tint(255, lifeSpan);
    image(img, location.x, location.y);
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
    particles.add(new Particle(origin));
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

PImage img;
ParticleSystem ps;

void setup(){
  size(800, 600, P2D);
  img = loadImage("fire_texture.png");
  img.resize(80, 80);
  ps = new ParticleSystem(new PVector(width/2, height/2));
}

void draw(){
  blendMode(ADD);
  background(0);
  float dx = map(mouseX, 0, width, -0.1, 0.1);
  PVector wind = new PVector(dx, 0);
  ps.applyForce(wind);
  ps.run();
  for(int i = 0; i < 1; i++){
    ps.addParticle();
  }
}
