Perceptron p;
Trainer[] trainingData = new Trainer[2000];
int count = 0;

float f(float x){ // Formula for a line
  return 2*x+1;
}

public void settings(){
  size(1000, 500);
}

void setup(){
  
  p = new Perceptron(3);
  
  for(int i = 0; i < trainingData.length; i++){
    float x = random(-width/2, width/2);
    float y = random(-height/2, height/2);
    int answer = 1;
    if (y < f(x)) answer = -1;
    trainingData[i] = new Trainer(x, y, answer);
  }
}

void draw(){
  background(255);
  translate(width/2, height/2);
  
  p.train(trainingData[count].inputs, trainingData[count].answer);
  count = (count + 1) % trainingData.length;
  
  for(int i = 0; i < count; i++){
    stroke(0);
    int guess = p.feedForward(trainingData[i].inputs);
    if(guess > 0) noFill();
    else          fill(0);
    ellipse(trainingData[i].inputs[0], trainingData[i].inputs[1], 8, 8);
  }
}
