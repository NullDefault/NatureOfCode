class Oscillator{
  PVector angle;
  PVector velocity;
  PVector amplitude;
  color s_color;
  
  Oscillator(){
    s_color = color(random(255), random(255), random(255));
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(width/2), random(height/2));
  }
  
  void oscillate(){
    angle.add(velocity);
  }
  
  void display(){
    float x = sin(angle.x)*amplitude.x;
    float y = sin(angle.y)*amplitude.y;
    
    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    fill(s_color);
    line(0, 0, x, y);
    ellipse(x, y, 16, 16);
    popMatrix();
  }
}

Oscillator[] os = new Oscillator[100];

void setup(){
  size(1000, 600);
  for(int i=0; i<os.length;i++){
    os[i] = new Oscillator();
  }
}

void draw(){
  background(255);
  for(int i=0; i<os.length;i++){
    os[i].oscillate();
    os[i].display();
  }
  
}
