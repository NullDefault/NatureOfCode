class DNA{
  PVector[] genes;
  
  float maxforce = 0.1;
  
  DNA(int lifetime){
    genes = new PVector[lifetime];
    for(int i = 0; i < genes.length; i++){
      genes[i] = PVector.random2D();
      genes[i].mult(random(0, maxforce));
    }
  }

}
