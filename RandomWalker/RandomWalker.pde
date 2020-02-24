import java.util.Random;

class Walker{
  float x;
  float y;
  Walker(){
    x = width/2;
    y = width/2;
  }
  void display() {
    stroke(0);
    point(x, y);
  }
  void step() {
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);
    x = x + stepx;
    y = y + stepy;
  }
}
class GaussianWalker extends Walker{
  Random generator = new Random();
  void step(){
    float x_delta = (float) generator.nextGaussian();
    float y_delta = (float) generator.nextGaussian();
    x += x_delta;
    y += y_delta;
  }
}
class NoiseWalker extends Walker{
  float tx, ty;
  NoiseWalker(){
    tx = 0;
    ty = 10000;
  }
  void step(){
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
    tx += 0.01;
    ty += 0.01;
  }
  void draw(){
  }
}

Walker w;

void setup(){
  size(500, 500);
  w = new NoiseWalker();
  background(255);
}
void draw() {
  w.step();
  w.display();
}
