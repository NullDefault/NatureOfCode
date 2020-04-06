class Food{
  PVector location;
  
  Food(PVector loc){
    location = loc;
  }
  
  void draw(){
    image(foodSprite, location.x, location.y);
  }
}
