class Hunter{
  PVector location;
  PImage sprite;
  
  float r;
  float maxspeed;
  float health;
  float xoff;
  float yoff;
  
  DNA dna;
  
  Hunter(PVector loc, DNA _dna){
    location = loc;
    health = 200;
    dna = _dna;
    
    xoff = random(-random(100), random(100));
    yoff = random(-random(100), random(100));
    
    
    maxspeed = map(dna.genes[0], 0, 1, 15, 0);
    r        = map(dna.genes[0], 0, 1, 1, 50);
    
    sprite = hunterSprite.copy();
    sprite.resize((int)r*2, (int)r*2);
  }
  
  boolean deathCheck(){
    if(health < 0.0){
      return true;
    }else{
      return false;
    }
  }
  
  void eat(Grazer g){
    health += g.health;
  }
  
  void collideWith(ArrayList<Grazer> grazers){
    for(Grazer g: grazers){
      if(PVector.dist(location, g.location) < (r + g.r) && r > g.r){
         eat(g);
         g.health = 0;
      }
    }
  }
  
  void borderCheck(){
    if(location.x > width){
      location.x = 0;
    }
    else if(location.x < 0){
      location.x = width;
    }
    
    if(location.y > height){
      location.y = 0;
    }
    else if(location.y < 0){
      location.y = height;
    }
  }
  
  void update(){
    float vx = map(noise(xoff), 0, 1, -maxspeed, maxspeed);
    float vy = map(noise(yoff), 0, 1, -maxspeed, maxspeed);
    
    location.add(new PVector(vx, vy));
    
    xoff += 0.01;
    yoff += 0.01;
    
    borderCheck();
    
    health -= 1;
    
    display();
  }
  
  void display(){
    image(sprite, location.x - sprite.width/2, location.y - sprite.height/2);
  }
  
}
