class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float time;
  
  Mover(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    topspeed = 10;
    time = random(1000);
  }
  
  // Constant Acceleration
  //void update(){
  //  velocity.add(acceleration);
  //  velocity.limit(topspeed);
  //  location.add(velocity);
  //}
  
  // Random Acceleration
  //void update(){
  //  acceleration = PVector.random2D();
  //  acceleration.mult(random(2));
  //  velocity.add(acceleration);
  //  velocity.limit(topspeed);
  //  location.add(velocity);
  //}
  
  // Perlin Noise Random Acceleration
  void update(){
    float n = noise(time);
    acceleration = PVector.random2D();
    acceleration.mult(n);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    time += 0.01;
  }
  
  void checkEdges(){
    if(location.x > width){
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if(location.y > height){
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
}

Mover mover;
void setup(){
  size(640, 360);
  mover = new Mover();
}
void draw(){
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display();
}
