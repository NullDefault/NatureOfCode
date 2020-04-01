ArrayList<KochLine> lines;

void settings(){
  size(800, 600);
}

void setup(){
  lines = new ArrayList<KochLine>();
  PVector start = new PVector(0, height-100);
  PVector end = new PVector(width, height-100);
  lines.add(new KochLine(start, end));
  for( int i = 0; i < 7; i++){
    generate();
  }
}

void draw(){
  background(255);
  for (KochLine l : lines){
    l.display();
  }
}
