class World{
  
  ArrayList<Grazer> grazers;
  ArrayList<Food> food;
  
  World(int gNum){
    makeGrazers(gNum);
    
    food = new ArrayList<Food>();
    for(int i = 0; i < 250; i++){
      food.add(new Food(new PVector(random(0, width), random(0, height))));
    }
  }
    
  void makeGrazers(int num){
    grazers = new ArrayList<Grazer>();
    for(int i = 0; i < num; i++){
      grazers.add(new Grazer(
        new PVector(random(0, width), random(0, height)),
        new DNA()
      ));
    }
  }
  
  void runFood(){
    for(int i = food.size()-1; i >= 0; i--){
      Food f = food.get(i);
      PVector foodloc = f.location;
      f.draw();
      for(int k = grazers.size()-1; k >= 0; k--){
        Grazer grazer = grazers.get(k);
        if(PVector.dist(foodloc, grazer.location) < grazer.r/2){
          grazer.eat();
          food.remove(i);
          if(food.size() < 250){
            food.add(new Food(new PVector(random(width), random(height))));
          }
        }
      }
    }
  }
  
  void run(){
    runFood();
    
    for (int i = grazers.size()-1; i >= 0; i--){
      Grazer g = grazers.get(i);
      g.update();
      if(g.deathCheck()){
        grazers.remove(i);
        food.add(new Food(g.location));
      }else{
        Grazer child = g.reproduce();
        if(child != null) grazers.add(child);
      }
    }
  }

}
