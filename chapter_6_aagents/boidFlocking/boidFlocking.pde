import java.util.*;

Flock flock;

void setup(){
  size(1000, 600);
  flock = new Flock();
  for(int i = 0; i < 100; i++){
    Boid b = new Boid(random(width), random(height));
    flock.addBoid(b);
  }
}

void draw(){
  background(255);
  flock.run();
}
