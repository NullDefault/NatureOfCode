int lifetime;
int lifecounter;
float maxforce = 0.1;
PVector target;
Population population;
Obstacle[] obstacles;

void drawTarget(){
  fill(255, 0, 0);
  ellipse(target.x, target.y, 24, 24);
  fill(255);
  ellipse(target.x, target.y, 16, 16);
  fill(255, 0, 0);
  ellipse(target.x, target.y, 8, 8);
}

void displayObstacles(){
  for(Obstacle obs: obstacles){
    obs.display();
  }
}

void setup(){
  size(1400, 800);
  obstacles = new Obstacle[20];
  for( int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  target = new PVector(random(width), random(0, 100));
  background(255);
  lifetime = 550;
  lifecounter = 0;
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);
}

void draw(){
  population.display();
  displayObstacles();
  fill(0);
  drawTarget();
  if(lifecounter < lifetime){
    population.live();
    lifecounter++;
  }else{
    background(255);
    lifecounter = 0;
    population.fitness(target);
    population.selection();
    population.reproduction();
  }
}
