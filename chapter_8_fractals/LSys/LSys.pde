class LSystem {

  String sentence;
  Rule[] ruleset; 
  int generation; 

  LSystem(String axiom, Rule[] r) {
    sentence = axiom;
    ruleset = r;
    generation = 0;
  }

  // Generate the next generation
  void generate() {
    StringBuffer nextgen = new StringBuffer();
    for (int i = 0; i < sentence.length(); i++) {
      char curr = sentence.charAt(i);
      String replace = "" + curr;
      for (int j = 0; j < ruleset.length; j++) {
        char a = ruleset[j].getA();
        if (a == curr) {
          replace = ruleset[j].getB();
          break; 
        }
      }
      nextgen.append(replace);
    }
    sentence = nextgen.toString();
    generation++;
  }

  String getSentence() {
    return sentence; 
  }

  int getGeneration() {
    return generation; 
  }
}


LSystem lsys;
Turtle turtle;


void setup(){
  size(900, 900);
  
  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
  lsys = new LSystem("F", ruleset);
  turtle = new Turtle(lsys.getSentence(), 250, radians(25));
}

void draw(){
  background(255);
  fill(0);
  translate(width/2, height);
  rotate(-PI/2);
  turtle.render();
  noLoop();
}

void mousePressed(){
  pushMatrix();
  lsys.generate();
  turtle.setToDo(lsys.getSentence());
  turtle.changeLen(0.5);
  popMatrix();
  redraw();
}
