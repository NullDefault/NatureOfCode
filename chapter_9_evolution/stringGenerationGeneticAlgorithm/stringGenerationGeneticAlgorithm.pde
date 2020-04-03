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
String target = "aaaa";

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

PFont f;
int generation = 0;
float avg_fit;
boolean running;

void setup(){
  size(1000, 800);
  running = true;
  f = createFont("Arial", 24, true);
  
  for(int i = 0; i < population.length; i++){
    population[i] = new DNA();
  }
}

void draw(){
  for (int i = 0; i < population.length; i++){
    population[i].fitness();
  }
  
  background(255);
  fill(0);
  textFont(f, 38);
  text("Best Phrase:", 100, 100);
  
  textFont(f, 70);
  text(getMostFit(), 200, 200);
  
  textFont(f, 28);
  text("total generations: "+generation, 200, 500);
  text("average fitness: "+avg_fit, 200, 550);
  text("population size: "+population.length, 200, 600);  
  if(running == true){
      runGeneration();
  }
}
