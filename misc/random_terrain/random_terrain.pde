float[][] terrain;
float flying = 0;

void setup(){  
  size(1200,800, P3D);
  cols = width/scale;
  rows = height+100/scale;
  terrain = new float[cols][rows];
}

int rows, cols;
int scale = 20;
float cDelta_r = random(0, 1000);
float cDelta_g = random(0, 1000);
float cDelta_b = random(0, 1000);
float height_delta = random(0, 150);

void draw(){
  flying -= 0.134;
  
  float yoff = flying;
  for (int y = 0; y < rows; y++){
    float xoff = 0;
    for (int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -height_delta, height_delta);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  height_delta += random(-20, 20);

  background(0);
  stroke(0);
  cDelta_r += 0.01;
  cDelta_g += 0.01;
  cDelta_b += 0.01;  
  
  float r = map(noise(cDelta_r), 0, 1, 0, 255);
  float g = map(noise(cDelta_g), 0, 1, 0, 255);
  float b = map(noise(cDelta_b), 0, 1, 0, 255);
  
  fill(r, g, b);
  
  translate(width/2, height/2);
  rotateX(PI/3);
  
  translate(-width/2,-height/2);
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++){
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape(TRIANGLE_STRIP);
  }
}
