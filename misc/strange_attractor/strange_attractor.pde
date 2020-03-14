import peasy.*;

float x = 1.0;
float y = 1.0;
float z = 1.0;

float a = random(5, 15);
float b = random(30, 40);
float c = random(4, 9)/random(1, 3);

ArrayList<PVector> points = new ArrayList<PVector>();
PeasyCam cam;


void setup(){
  size(1000, 800, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 500);
}

void draw(){
  background(0);
  float dt = 0.01;
  float dx = (a * (y - x)) * dt;
  float dy = (x * (b - z) - y) * dt;
  float dz = (x * y - c * z) * dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  points.add(new PVector(x, y, z));
  
  translate(0, 0, -80);
  scale(5);
  stroke(255);
  noFill();
  
  float hue = 0;
  beginShape();
  for(PVector v : points){
    stroke(hue, 255, 255);
    vertex(v.x, v.y, v.z);  
    hue += 0.1;
    if (hue > 255){
      hue = 0;
    }
  }
  endShape();
}
