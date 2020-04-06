class Food{
  PVector location;
  
  Food(PVector loc){
    location = loc;
  }
  
  void draw(){
    image(foodSprite, location.x - 8, location.y - 8);
  }
}
