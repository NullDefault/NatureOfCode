class Vehicle{
  
  // steering force = desired velocity - current velocity
  
  color c;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;
  float maxforce;
  
  Vehicle(float x, float y){
    acceleration = new PVector(0,0);
    c = color(random(255), random(255), random(255));
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 25;
    maxspeed = 3;
    maxforce = 0.1;
  }
  
  void update(){
    if(location.x < 0){
      location.x = width;
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
  
  PVector separate(ArrayList<Vehicle> vehicles){
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    for(Vehicle other: vehicles){
      if(this.equals(other)){
        continue;
      }
      float d = PVector.dist(location, other.location);
      if((d < desiredseparation)){
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
  
  void applyBehaviors(ArrayList<Vehicle> vehicles){
    PVector separate = separate(vehicles);
    PVector seek = seek(new PVector(mouseX, mouseY));
    
    separate.mult(1.5);
    seek.mult(0.5);
    
    applyForce(separate);
    applyForce(seek);
  }
  
  void display(){
    stroke(0);
    fill(c);
    ellipse(location.x, location.y, r, r);
  }
}
