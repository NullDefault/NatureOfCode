class Pendulum{
  PVector location;       // bob location
  PVector origin;        // location of arm origin  """
  float armLength;      // length of arm        _/\(0_0) _
  float angle;         // pendulum arm angle        | |\/
  float angleVelocity;// angle velocity             [ ]
  float angleAcc;    // angle acceleration         /   \
  float damping;    // arbitrary damping amount    I   I
  
  Pendulum(PVector origin_, float r_){
    origin = origin_.get();
    location = new PVector();
    armLength = r_;
    angle = PI/4;
    
    angleVelocity = 0.0;
    angleAcc = 0.0;
    damping = 0.998;
  }
  
  void go(){
    update();
    display();
  }
  
  void update(){
    float gravity = 0.4;
    angleAcc = (-1 * gravity / armLength) * sin(angle);
    angleVelocity += angleAcc;
    angle += angleVelocity;
    angleVelocity *= damping;
  }
  void display(){
    location.set(armLength*sin(angle), armLength*cos(angle),0);
    location.add(origin);
    stroke(0);
    line(origin.x, origin.y, location.x, location.y);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
}

Pendulum[] p = new Pendulum[50];

void setup(){
  size(800, 600);
  for(int i=0; i < p.length; i++){
    p[i] = new Pendulum(new PVector(width/2, random(0, 10)), random(75, 550));
  }
}

void draw(){
  background(255);
  for(int i=0; i < p.length; i++){
    p[i].go();
  }
}
