int lifetime;
int lifecounter;
Population population;

void setup(){
  size(1000, 800);
  lifetime = 500;
  lifecounter = 0;
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);
  
}
