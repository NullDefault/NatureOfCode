void branch(float len){
  line(0, 0, 0, -len);
  translate(0, -len);
  len *= 0.66;
  if (len > 2){
    int n = int(random(2, 4));
    for (int i = 0; i < n; i++){
      float theta = random(-PI/2, PI/2);
      pushMatrix();
      rotate(theta);
      branch(len);
      popMatrix();
    }
  }
}
