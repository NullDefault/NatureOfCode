class Vehicle{
  
  // steering force = desired velocity - current velocity
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;
  float maxforce;
  
  Vehicle(float x, float y){
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 3.0;
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
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void followFlow(FlowField flow){
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void followPath(Path p){
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(25); // 25 is arbitrary - represents pixels
    PVector predictLoc = PVector.add(location, predict);
    
    float high = 10000000;
    PVector target = null;
    
    for(int i = 0; i < p.points.size()-1; i++){
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      PVector normalPoint = getNormalPoint(predictLoc, a, b);
      if(normalPoint.x < a.x || normalPoint.x > b.x){
        normalPoint = b.get();
      }
      float dist = PVector.dist(predictLoc, normalPoint);
      if(dist < high){
        high = dist;
        target = normalPoint.get();
      }
    }
    
    
    float distance = PVector.dist(target, predictLoc);
    if(distance > p.radius){
      seek(target);
    }
  }
  
  void arrive(PVector target){
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    if(d < 100){
      float m = map(d,0,100,0,maxspeed);
      desired.mult(m);
    }else{
      desired.mult(maxspeed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void display(){
    float theta = velocity.heading() + PI/2;
    fill(175);
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
