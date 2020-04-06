class DNA{
  float[] genes;
  
  DNA(){
    genes = new float[1];
    for( int i = 0; i < genes.length; i++){
      genes[i] = random(0, 1);
    }
  }
  
  DNA(float[] newGenes){
    genes = newGenes;
  }
  
  void mutate(){
    float mutationRate = 0.01;
    for(int i = 0; i < genes.length; i++){
      if(random(0, 1) < mutationRate){
        genes[i] = random(0, 1);
      }
    }
  }
  
  DNA copyGenes(){
    float[] newgenes = new float[genes.length];
    arraycopy(genes, newgenes);
    return new DNA(newgenes);
  }
  
}
