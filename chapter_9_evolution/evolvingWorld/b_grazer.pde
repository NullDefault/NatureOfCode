class Grazer{
  PVector location;
  PImage sprite;
  
  float r;
  float maxspeed;
  float health;
  float xoff;
  float yoff;
  
  DNA dna;
  Grazer partner;
  int sexCD; // sex cooldown
  boolean isMale;
  
  Grazer(PVector loc, DNA _dna, boolean gend){
    location = loc;
    health = 200;
    dna = _dna;
    sexCD = 0;
    partner = null;
    isMale = gend;
    
    xoff = random(-random(100), random(100));
    yoff = random(-random(100), random(100));
    
    
    maxspeed = map(dna.genes[0], 0, 1, 15, 0);
    r        = map(dna.genes[0], 0, 1, 1, 50);
    
    sprite = grazerSprite.copy();
    sprite.resize((int)r*2, (int)r*2);
  }
  
  // Only used by female grazers
  Grazer reproduce(){
    if(partner != null && health > 100){
      DNA childDNA = dna.breedWith(partner.dna);
      childDNA.mutate();
      Grazer baby = new Grazer(location.copy(), childDNA, randomGender());
      partner = null;
      sexCD = 50;
      baby.health = 60;
      baby.sexCD = 100; // babies need to mature before bonin'
      return baby;
    }else{
      return null;
    }
  }
  
  // Only used by male grazers
  void breedWith(Grazer other){
    if(other.isMale == false){
      sexCD = 10;
      other.partner = this;
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
  
  // only used by males
  void collideWith(ArrayList<Grazer> others){
    for(Grazer g: others){
      if(g == this){
        continue;
      }else{
        if(PVector.dist(location, g.location) < (r + g.r)){
          breedWith(g);
        }
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
    
    if(sexCD > 0){
      sexCD--;
    }
    
    health -= 1;
    
    display();
  }
  
  void display(){
    image(sprite, location.x - sprite.width/2, location.y - sprite.height/2);
  }
}
