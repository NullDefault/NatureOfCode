import fisica.*;

class complexShape{
  FPoly body;
  PVector[] shape = new PVector[4];

  
  complexShape(float xpos, float ypos){
    shape[0] = new PVector(random(-12, -24), random(9, 23));
    shape[1] = new PVector(random(7, 15), random(0, 13));
    shape[2] = new PVector(random(14, 32), random(-4, -15));
    shape[3] = new PVector(random(-14, 11), random(-6, 0));
    body = new FPoly();
    for(PVector v: shape){
      body.vertex(xpos + v.x, ypos + v.y);
    }
    body.setFill(random(255), random(255), random(255));
    world.add(body);
  }
}

FWorld world;
complexShape cS;

void setup(){
  size(800, 600);
  smooth();
  
  Fisica.init(this);
  world = new FWorld();
  world.setEdges();
}

void draw(){
  background(255);
  
  if(mousePressed){
    cS = new complexShape(mouseX, mouseY);
  }
  
  world.step();
  world.draw(this);
}
