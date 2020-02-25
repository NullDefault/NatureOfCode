import java.util.Random;

Random generator;  

void setup(){
  size(700, 360);
  generator = new Random();
}

void draw(){
  float num = (float) generator.nextGaussian();
  float sd = 100;
  float mean = 350;
  
  float x = sd * num + mean;

  noStroke();
  fill(255, 10);
  ellipse(x, 180, 30, 30);
  
}
