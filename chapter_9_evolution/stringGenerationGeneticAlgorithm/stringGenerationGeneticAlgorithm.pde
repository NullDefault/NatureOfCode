class DNA{
  char[] genes = new char[target.length()];
  float fitness;
  
    DNA(){
    for (int i = 0; i < genes.length; i++){
      genes[i] = (char) random(38, 128);
    }
  }
  
  void fitness(){
    int score = 0;
    for(int i =0; i < genes.length; i++){
      if (genes[i] == target.charAt(i)){
        score++;
      }
    }
    fitness = float(score)/target.length();
  }
  
  DNA crossover(DNA partner){
    DNA child = new DNA();
    
    for(int i = 0; i < genes.length; i++){
      int flip = parseInt(random(2));
      if(flip == 0){
        child.genes[i] = genes[i];
      }else{
        child.genes[i] = partner.genes[i];
      }
    }
    return child;
  }
  
  void mutate(){
    float mutationRate = 0.01;
    for(int i = 0; i < genes.length; i++){
      if(random(1) < mutationRate){
        genes[i] = (char) random(32, 128);
      }
    }
  }
  
  String getPhrase(){
    return new String(genes);
  }
  
}

DNA[] population = new DNA[150];
String target = "good night";

void runGeneration(){
  generation++;
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  for(int i = 0; i < population.length; i++){
    int n = int(population[i].fitness * 100);
    for (int j = 0; j < n; j++){
      matingPool.add(population[i]);
    }
  }

  for(int x = 0; x < population.length; x++){
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    
    DNA parentA = matingPool.get(a);
    DNA parentB = matingPool.get(b);
    
    DNA child = parentA.crossover(parentB);
    child.mutate();
    
    population[x] = child;
  }
}

String getMostFit(){
  float maxFitness = 0;
  float totalFit = 0;
  DNA best = population[0];
  for(int i = 0; i < population.length; i++){
    totalFit = totalFit + population[i].fitness;
    if(population[i].fitness > maxFitness){
      maxFitness = population[i].fitness;
      best = population[i];
    }
  }
  if(maxFitness == 1){
    running = false;
  }
  avg_fit = totalFit / population.length;
  return best.getPhrase();
}

void addHistory(String n){
  String temp2 = n;
  for(int i = 0; i < guessHistory.length - 1; i++){
    String temp = guessHistory[i];
    guessHistory[i] = temp2;
    temp2 = temp;
  }
}

PFont f;
int generation = 0;
float avg_fit;
boolean running;
String[] guessHistory = new String[255];
boolean finalize = true;

void setup(){
  size(1600, 800);
  running = true;
  f = createFont("Courier", 24, true);
  
  for(int i = 0; i < population.length; i++){
    population[i] = new DNA();
  }
}

void draw(){
  for (int i = 0; i < population.length; i++){
    population[i].fitness();
  }
  background(255);
  fill(3, 170, 20);
  textFont(f, 38);
  text("Best Phrase:", 50, 50);
  String bestFit = getMostFit();
  if(running == false){
    fill(0, 190, 0);
  }else{
    fill(0);
  }
  line(0, 160, width, 160);
  textFont(f, 70);
  text(bestFit, 50, 130);
  
  textFont(f, 28);
  text("total generations: "+generation, 50, 625);
  text("average fitness: "+avg_fit, 50, 675);
  text("population size: "+population.length, 50, 725);  
  
  textFont(f, 40);
  int x = 50;
  int y = 400;
  for(int k = 0; k < guessHistory.length; k++){
    if(guessHistory[k] != null){
      fill(255-k);
      text(guessHistory[k], x, y);
    }
  }
  textFont(f, 20);
  x = 600;
  y = 200;
  for(int v = 0; v < guessHistory.length; v++){
    if(guessHistory[v] != null){
      fill(170, 0, 0);
      text(guessHistory[v], x, y);
      
      int ci = 0;
      int tempx = x;
      fill(0, 170, 0);
      for(char c: guessHistory[v].toCharArray()){
        if(c == target.charAt(ci)){
          text(c, tempx, y);
        }
        tempx += textWidth(c);
        ci++;
      }
      
      fill(0);
      y += 20;
      if(y>height){
        y = 200;
        x += textWidth(guessHistory[v]) + 10;
      }
      if(x > width){
        break;
      }
    }
  }
  
  if(running == true){
      addHistory(bestFit);
      runGeneration();
  }
}
