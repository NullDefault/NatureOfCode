Perceptron p;
Trainer[] trainingData = new Trainer[2000];
int count = 0;
int guess;
float accuracy;
int correctCount;

float xmin = -1000;
float ymin = -1000;
float xmax =  1000;
float ymax =  1000;


float f(float x){ // Formula for a line
  return 0.4*x+1;
}

public void settings(){
  size(1200, 800);
}

void setup(){
  frameRate(4);
  p = new Perceptron(3, 0.01);
  background(255);
  for(int i = 0; i < trainingData.length; i++){
    float x = random(-width/2, width/2);
    float y = random(-height/2, height/2 - 300);
    int answer = 1;
    if (y < f(x)) answer = -1;
    trainingData[i] = new Trainer(x, y, answer);
  }
}

void drawPerceptron(){
  
  fill(0, 145, 100);
  rect(-width/2 - 1, height/2 + 110, width, -height/2); 
  
  line(-300, height/2 - 75, 0, height/2 - 150);
  line(-300, height/2 - 225, 0, height/2 - 150);
  line(0, height/2 - 150, 300, height/2 - 150);
  
  
  fill(map(trainingData[count].inputs[0], 0, width/2, 0, 255));
  ellipse(-300, height/2 - 225, 75, 75);
  fill(map(trainingData[count].inputs[1], 0, height/2 - 300, 255, 0));
  ellipse(-300, height/2 - 75, 75, 75);
  
  
  fill(175);
  ellipse(0, height/2 - 150, 150, 150);
  
  if(guess > 0){
    fill(255);
  }else{
    fill(0);
  }
  ellipse(300, height/2 - 150, 90, 90);
  
  fill(0);
  text("x: "+str(trainingData[count].inputs[0]), -450, height/2 - 225);
  text("x weight: "+str(p.weights[0]), -50, height/2 - 235);
  fill(255);
  text("y: "+str(trainingData[count].inputs[1]), -450, height/2 - 75);
  text("y weight: "+str(p.weights[1]), -50, height/2 - 50);
  

}

void draw(){  
  translate(width/2, height/2);
  
  strokeWeight(1);
  stroke(240, 0, 0);
  float x1 = xmin;
  float y1 = f(x1);
  float x2 = xmax;
  float y2 = f(x2);
  line(x1,y1,x2,y2);

  if(count - 1 != -1){
    stroke(255);
    strokeWeight(11);
    ellipse(trainingData[count-1].inputs[0], trainingData[count-1].inputs[1], 8, 8);
    stroke(0);
    strokeWeight(1);
    ellipse(trainingData[count-1].inputs[0], trainingData[count-1].inputs[1], 8, 8);
  }

  if(count == 2000){
    background(255);
    count = 0;
  }
  
  p.train(trainingData[count].inputs, trainingData[count].answer);
  count = (count + 1) % trainingData.length;
  
  stroke(0);
  guess = p.feedForward(trainingData[count].inputs);
  drawPerceptron();
  if(guess > 0){
    fill(255);
  }
  else{
    fill(0);
  }
  strokeWeight(10);
  stroke(200, 0, 0);
  ellipse(trainingData[count].inputs[0], trainingData[count].inputs[1], 8, 8);
  
  count++;
}
