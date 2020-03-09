class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  // color coloring;
  // shape shape;
  // PImage sprite;
  
  Particle(PVector loc){
    location= loc.get();
    acceleration = new PVector();
    velocity = new PVector();
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 8, 8);
  }  
}
