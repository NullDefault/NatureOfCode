import fisica.*;

class BoundaryRect {
  float x,y;
  float w,h;
  FBody b;
  
  BoundaryRect(float _x, float _y, float _w, float _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    b = new FBox(w, h);
    b.setPosition(x,y);
    b.setStatic(true);
    
    world.add(b);
  }
  
  void display(){
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}

class BoundaryCurve{
  ArrayList<PVector> surface;
  
  BoundaryCurve(){
    surface = new ArrayList<PVector>();
    surface.add(new PVector(0, height/2+50));
    surface.add(new PVector(width/2, height/2+50));
    surface.add(new PVector(width, height/2));
    surface.add(new PVector(width-1, height)); 
    surface.add(new PVector(0, height));

    
    FPoly body = new FPoly();
    for(PVector v: surface){
      body.vertex(v.x, v.y);     
    }
    body.setStatic(true);
    body.setGrabbable(false);
    world.add(body);
  }
  
  void display(){
    strokeWeight(1);
    stroke(0);
    fill(255);
    beginShape();
    for(PVector v: surface){
      vertex(v.x, v.y);
    }
    endShape();
  }
}

FWorld world;
BoundaryCurve b;
FCircle box;

void setup(){
  size(800, 600);
  smooth();
  
  Fisica.init(this);
  
  world = new FWorld();
  b = new BoundaryCurve();
}

void draw(){
  background(255);
  
  if(mousePressed){
    box = new FCircle(16);
    box.setPosition(mouseX, mouseY);
    box.setDensity(1);
    box.setFill(175, 125, 25);
    box.setNoStroke();
    world.add(box);
  }
  
  world.step();
  world.draw(this);
}
