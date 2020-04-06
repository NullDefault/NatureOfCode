World world;


PImage foodSprite;


void setup(){
  size(1200, 800);
  foodSprite = loadImage("foodSprite.png");
  world = new World(20);
}

void draw(){
  background(255);
  world.run();
}
