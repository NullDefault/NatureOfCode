class Cell{
  
  Cell left, right, front, back, top, bot; // Neighbors
  
  int x, y, z;
  int state;        //                                   n
  int nextState;    //                                   |
  int maxState = 1; // n means n+1 total states - [0, 1, 2, n+1]
  color c;
  
  Cell(int _x, int _y, int _z){
    x = _x;
    y = _y;
    z = _z;
    c = color(random(0, 255), random(0, 255), random(0, 255));
    
    if(x == (int) dim/2 && y == (int) dim/2 && z == (int) dim/2){
      state = 1;
    }
  }
  
  void setNeighbors(){
    if(x != 0){
      left = cellLocs[x-1][y][z];
    }else{
      left = cellLocs[dim-1][y][z];
    }
    
    
    if(x != dim - 1){
      right = cellLocs[x+1][y][z];
    }else{
      right = cellLocs[0][y][z];
    }
    
    if(y != 0){
      front = cellLocs[x][y-1][z];
    }else{
      front = cellLocs[x][dim-1][z];
    }
    
    if(y != dim - 1){
      back = cellLocs[x][y+1][z];
    }else{
      back = cellLocs[x][0][z];
    }
    
    if(z != 0){
      top = cellLocs[x][y][z-1];
    }else{
      top = cellLocs[x][y][dim-1];
    }
    
    if(z != dim - 1){
      bot = cellLocs[x][y][z+1];
    }else{
      bot = cellLocs[x][y][0];
    }
  }
  
  int getLivingNeighbors(){
    int count = 0;
    if(left.state  > 0) count++;
    if(right.state > 0) count++;
    if(front.state > 0) count++;
    if(back.state  > 0) count++;
    if(top.state   > 0) count++;
    if(bot.state   > 0) count++;
    return count;
  }
  
  void setNextState(){
    int lnc = getLivingNeighbors(); // lnc - living neighbor count
    if(state == 0){ // cell is dead
      if(lnc == 1){
        nextState = maxState;
      }else{
        nextState = 0;
      }
    }else{          // cell is alive
      if(lnc == 0 || lnc == 1 || lnc == 2 || lnc == 3 || lnc == 4 || lnc == 5 || lnc == 6){
        nextState = maxState;
      }else{
        nextState = 0;
      }
    }
  }
  
  void display(){
    pushMatrix();
    if(state > 0){ fill(0); stroke(c); }
    else { noFill(); noStroke(); }
    translate(x*cellSize, y*cellSize, z*cellSize);
    box(cellSize);
    popMatrix();
  }
}
