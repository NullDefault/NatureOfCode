//FlowField flow;
Path p;
Vehicle[] vehicles;
PVector target = new PVector(random(width), random(height));

PVector getNormalPoint(PVector p, PVector a, PVector b){
  PVector ap = PVector.sub(p, a);
  PVector ab = PVector.sub(b, a);
  
  ab.normalize();
  ab.mult(ap.dot(ab));
  PVector normalPoint = PVector.add(a, ab);
  return normalPoint;
}

void setup(){
  size(800, 600);
  //flow = new FlowField();
  p = new Path();
  for(int k = 0; k < 10; k++){
    p.addPoint(k*random(80, 120), k*random(80, 120));
  }
  vehicles = new Vehicle[100];
  for(int i = 0; i < vehicles.length; i++){
    vehicles[i] = new Vehicle(random(width), random(height));
  }
}

void draw(){
  background(255);
  p.display();
  for(Vehicle v: vehicles){
    //v.seek(target);
    //v.arrive(target);
    //v.follow(flow);
    v.followPath(p);
    v.update();
    v.display();
  }
}
