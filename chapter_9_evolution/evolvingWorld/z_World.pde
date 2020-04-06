class World{
  
  ArrayList<Grazer> grazers;
  ArrayList<Hunter> hunters;
  ArrayList<Food> food;
  
  World(int gNum, int hNum){
    makeGrazers(gNum);
    makeHunters(hNum);
    
    food = new ArrayList<Food>();
    for(int i = 0; i < 250; i++){
      food.add(new Food(new PVector(random(0, width), random(0, height))));
    }
  }
    
  void makeGrazers(int num){
    grazers = new ArrayList<Grazer>();
    boolean newGend;
    for(int i = 0; i < num; i++){
      if( i < num/2){
        newGend = false;
      }else{
        newGend = true;
      }
      grazers.add(new Grazer(
        new PVector(random(0, width), random(0, height)),
        new DNA(),
        newGend
      ));
    }
  }
  
  void makeHunters(int num){
    hunters = new ArrayList<Hunter>();
    for(int i = 0; i < num; i++){
      hunters.add(new Hunter(
        new PVector(random(0, width), random(0, height)),
        new DNA()));
    }
  }
  
  void runFood(){
    ArrayList<Food> eatenFood = new ArrayList<Food>();
    for(Food f: food){
      PVector foodloc = f.location;
      for(Grazer g: grazers){
        if(PVector.dist(foodloc, g.location) < g.r/2){
          g.eat();
          eatenFood.add(f);
        }else{
          f.draw();
        }
      }
    }
    
    for(Food f: eatenFood){
      food.remove(f);
    }
    
    while(food.size() < 250){
      food.add(new Food(new PVector(random(0, width), random(0, height))));
    }
  }
  
  void run(){
    runFood();
    
    for(int j = grazers.size()-1; j >= 0; j--){
      Grazer g = grazers.get(j);
      g.update();
      if(g.deathCheck()){
        grazers.remove(g);
        food.add(new Food(g.location));
      }
      else if(g.isMale && g.sexCD <= 0){
        g.collideWith(grazers);
      }
    }
    
    for(int x = hunters.size()-1; x >= 0; x--){
      Hunter h = hunters.get(x);
      h.update();
      if(h.deathCheck()){
        hunters.remove(x);
      }
      else{
        h.collideWith(grazers);
      }
    }
    
    ArrayList<Grazer> newGrazers = new ArrayList<Grazer>();
    
    for(int k = grazers.size()-1; k >= 0; k--){
      Grazer g = grazers.get(k);
      if(g.isMale == false && g.sexCD <= 0){
        Grazer child = g.reproduce();
        if(child != null){
          newGrazers.add(child);
        }
      }
    }
    
    for(Grazer g: newGrazers){
      grazers.add(g);
    }
  }

}
