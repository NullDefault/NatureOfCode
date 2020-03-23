class Flock{
  ArrayList<Boid> boids;
  float[] time;
  
  Flock(){
    boids = new ArrayList<Boid>();
    time = new float[4];
    time[0] = random(1, 5);
    time[1] = random(1, 5);
    time[2] = random(1, 5);
    time[3] = random(1, 5);
  }
  
  void run(){
    for(Boid b : boids){
      b.flock(boids, time[0], time[1], time[2], time[3]);
      b.update();
      b.display();
    }
    time[0] += random(0.01, 0.05);
    time[1] += random(0.01, 0.05);
    time[2] += random(0.01, 0.05);
    time[3] += random(0.01, 0.05);
  }
  
  void addBoid(Boid b){
    boids.add(b);
  }
}
