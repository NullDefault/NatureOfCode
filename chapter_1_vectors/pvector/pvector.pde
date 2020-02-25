class PVector{
  float x;
  float y;
  
  PVector(float x_, float y_){
    x = x_;
    y = y_;
  }
  void add(PVector v){
    y = y + v.y;
    x = x + v.x;
  }
  void sub(PVector v){
    y = y - v.y;
    x = x - v.x;
  }
  void multiply(float n){
    y = y * n;
    x = x * n;
  }
  void divide(float n){
    y = y / n;
    x = x / n;
  }
  float magnitude(){
    return sqrt(x*x + y*y);
  }
  void normalize(){
    float m = magnitude();
    if(m != 0){
      divide(m);
    }
  }
}

PVector location;
PVector velocity;

void setup(){
  size(640, 360);
  location = new PVector(100,100);
  velocity = new PVector(2.5, 5);
}

void draw(){
  background(255);
  location.add(velocity);
  if ((location.x > width) || (location.x < 0)){
    velocity.x = velocity.x * -1;
  }
  if ((location.y > height) || (location.y < 0)){
    velocity.y = velocity.y * -1;
  }
  stroke(0);
  fill(175);
  ellipse(location.x, location.y, 16, 16);
}
