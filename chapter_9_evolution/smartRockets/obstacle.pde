class Obstacle{
  PVector location;
  float w, h;
  
  Obstacle(){
    location = new PVector(random(0, width), random(0, height));
    w = random(20, 40);
    h = random(5, 20);
  }
  
  boolean contains(PVector v){
    if(v.x > location.x && v.x < location.x + w && v.y > location.y && v.y < location.y + h){
      return true;
    }else{
      return false;
    }
  }
  
  void display(){
    fill(50);
    rect(location.x, location.y, w, h);
  }
}
