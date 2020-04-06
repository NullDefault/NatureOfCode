class Grazer{
  PVector location;
  float r;
  float maxspeed;
  float health;
  float xoff;
  float yoff;
  PImage sprite;
  
  DNA dna;
  
  Grazer(PVector loc, DNA _dna){
    location = loc.get();
    health = 200;
    dna = _dna;
    
    xoff = random(-random(100), random(100));
    yoff = random(-random(100), random(100));
    
    
    maxspeed = map(dna.genes[0], 0, 1, 15, 0);
    r        = map(dna.genes[0], 0, 1, 1, 50);
    sprite = grazerSprite.copy();
    sprite.resize((int)r*2, (int)r*2);
  }
  
  Grazer reproduce(){
    if(random(1) < 0.0001){
      DNA childDNA = dna.copyGenes();
      childDNA.mutate();
      Grazer baby = new Grazer(location, childDNA);
      return baby;
    }else{
      return null;
    }
  }
  
  boolean deathCheck(){
    if(health < 0.0){
      return true;
    }else{
      return false;
    }
  }
  
  void eat(){
    health += 100;
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
    image(sprite, location.x, location.y);
  }
}
