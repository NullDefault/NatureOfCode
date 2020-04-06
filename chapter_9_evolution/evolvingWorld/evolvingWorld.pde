World world;

float blueVal = 1;
PImage foodSprite;
PImage grazerSprite;
PImage hunterSprite;


boolean randomGender(){
    int roll = (int) random(0, 1);
    if( roll == 0 ){
      return true;
    }else{
      return false;
    }
}

void setup(){
  size(1200, 800);
  foodSprite = loadImage("foodSprite.png");
  grazerSprite = loadImage("grazerSprite.png");
  hunterSprite = loadImage("hunterSprite.png");
  world = new World(20, 10);
}

void draw(){
  
  background(10, 10, map(noise(blueVal), 0, 1, 0, 255));
  world.run();
  blueVal += 0.001;
}
