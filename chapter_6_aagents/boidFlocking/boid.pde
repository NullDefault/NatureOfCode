class Boid{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;
  float maxforce;
  color c;
  
  Boid(float x, float y){
    c = color(random(255), random(255), random(255));
    acceleration = new PVector(0,0);
    velocity = new PVector();
    location = new PVector(x,y);
    r = 3.0;
    maxspeed = 3;
    maxforce = 0.1;
  }
  
  void update(){
    if(location.x < 0){
      velocity.mult(-1);
    }
    else if(location.x > width){
      location.x = 0;
    }
    if(location.y < 0){
      location.y = height;
    }
    else if(location.y > height){
      location.y = 0;
    }
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  PVector seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }
  
  void flock(ArrayList<Boid> boids, float timeA, float timeB, float timeC, float timeD){
    PVector sep = separate(boids);
    PVector ali = align(boids);
    PVector coh = cohesion(boids);
    //PVector seek = seek(new PVector(mouseX, mouseY));
    
    sep.mult(map(noise(timeA), 0, 1, 1, 10));
    ali.mult(map(noise(timeB), 0, 1, 1, 3));
    coh.mult(map(noise(timeC), 0, 1, 1, 3));
    //seek.mult(map(noise(timeD), 0, 1, 1, 3));
    
    //applyForce(seek);
    applyForce(sep);
    applyForce(ali);
    applyForce(coh); 
  }
  
  PVector separate(ArrayList<Boid> boids){
    float desiredseparation = r*4;
    PVector sum = new PVector();
    int count = 0;
    for(Boid other: boids){
      if(this.equals(other)){
        continue;
      }
      float d = PVector.dist(location, other.location);
      if(d < desiredseparation){
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if(count > 0){
      sum.div(count);
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    }else{
      return new PVector(0, 0);
    }
  }
  
  PVector align(ArrayList<Boid> boids){
    float neighbordist = 50;   
    PVector sum = new PVector(0, 0);
    int count = 0;
    for(Boid other: boids){
      if(this.equals(other)){
        continue;
      }
      float d = PVector.dist(location, other.location);
      if(d < neighbordist){
        sum.add(other.velocity);
        count++;
      }
      sum.add(other.velocity);
    }
    if(count > 0){
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    }
    else{
      return new PVector(0, 0);
    }                                                                                                                                                                                                                                                         
  }
  
  PVector cohesion(ArrayList<Boid> boids){
    float neighbordist = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    for(Boid other: boids){
      if(this.equals(other)){
        continue;
      }
      float d = PVector.dist(location, other.location);
      if(d < neighbordist){
        sum.add(other.location);
        count++;
      }
    }
    if(count>0){
      sum.div(count);
      return seek(sum);
    }else{
      return new PVector(0,0);
    }
  }
  
  void display(){
    float theta = velocity.heading() + PI/2;
    fill(c);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}
