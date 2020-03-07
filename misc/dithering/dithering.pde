PImage kitten;

int pix_index(int x, int y){
  return x + y * kitten.width;
}

int[] x_iterators(){
  int[] shipBack = new int[4];
  shipBack[0] =  1;
  shipBack[1] = -1;
  shipBack[2] =  0;
  shipBack[3] =  1;
  return shipBack;
}
int[] y_iterators(){
  int[] shipBack = new int[4];
  shipBack[0] =  0;
  shipBack[1] =  1;
  shipBack[2] =  1;
  shipBack[3] =  1;
  return shipBack;
}

void setup(){
  kitten = loadImage("kitten.png");
  size(1024, 512);
  image(kitten, 0, 0);
  kitten.filter(GRAY);
  kitten.loadPixels();
  for(int y = 0; y < kitten.height-1; y++){
    for(int x = 1; x < kitten.width-1; x++){
      color pix = kitten.pixels[pix_index(x, y)];
      
      int factor = 1;
      
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      
      int newR = round(factor * oldR/255) * (255/factor);
      int newG = round(factor * oldG/255) * (255/factor);
      int newB = round(factor * oldB/255) * (255/factor);
      kitten.pixels[pix_index(x,y)] = color(newR,newG,newB);
      
      float rOffset = oldR - newR;
      float gOffset = oldG - newG;
      float bOffset = oldB - newB;
      
      int[] xIters = x_iterators();
      int[] yIters = y_iterators();
      
      for(int i = 0; i < 4; i++){
        int index = pix_index(x + xIters[i], y + yIters[i]);
        color c = kitten.pixels[index];
        float r = red(c); float g = green(c); float b = blue(c);
        
        float currNum;
        if(i == 0){ 
          currNum = 7.0; 
        }else if(i == 1){ 
          currNum = 3.0;
        }
        else if(i == 2){ 
          currNum =  5.0;
        }else{
          currNum = 1;
        }
        
        r = r + rOffset * currNum/16.0;
        g = g + gOffset * currNum/16.0;
        b = b + bOffset * currNum/16.0;
        kitten.pixels[index] = color(r,g,b);
      }
    }
  }
  kitten.updatePixels();
  image(kitten, 512, 0);
}

void draw(){

}
