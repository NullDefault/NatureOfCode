World world;

float blueVal = 1;
PImage foodSprite;
PImage grazerSprite;


void setup(){
  size(1200, 800);
  foodSprite = loadImage("foodSprite.png");
  grazerSprite = loadImage("grazerSprite.png");
  world = new World(20);
}

void draw(){
  
  background(10, 10, map(noise(blueVal), 0, 1, 0, 255));
  world.run();
  blueVal += 0.001;
}
