// why the fuck do my files need to be alphabetically ordered in order to be seen by other classes
// fucking dumb as shit, literally what
class Population{
  float mutationRate;
  float maxFit;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  
  Population(float mr, int pop){
    mutationRate = mr;
    population = new Rocket[pop];
    for( int i = 0; i < population.length; i ++){
      population[i] = new Rocket();
    }
  }
  
  void fitness(PVector target){
    maxFit = 0;
    for(Rocket r: population){
      r.fitness();
      if (r.fitness > maxFit){
        maxFit = r.fitness;
      }
    }
  }
  
  void selection(){
    matingPool = new ArrayList<Rocket>();
    float maxFitness = maxFit;
    for(int i = 0; i < population.length; i++) {
      double fitnessNormal = map(population[i].fitness, 0, maxFitness, 0, 1);
      int n = (int) (fitnessNormal * 100);
      for(int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void reproduction(){
    for(int x = 0; x < population.length; x++){
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
    
      Rocket parentA = matingPool.get(a);
      Rocket parentB = matingPool.get(b);
    
      Rocket child = parentA.crossover(parentB);
      child.mutate();
    
      population[x] = child;
    }
  }
  void display(){
    for(Rocket r: population){
      r.display();
    }
  }
  void live(){
    for( int i = 0; i < population.length; i++){
      population[i].run();
    }
  }
}
