import fisica.*;

FWorld world; // ZA WARUDO
FBox box;

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
    box = new FBox(16, 16);
    box.setPosition(mouseX, mouseY);
    box.setDensity(1);
    box.setFill(175, 125, 25);
    box.setNoStroke();
    world.add(box);
  }
  
  world.step();
  world.draw(this);
}
