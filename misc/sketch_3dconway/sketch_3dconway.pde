int dim = 140;      // dimensions for the cell board
int cellSize = 6; // How big a single cell cube is


Cell[][][] cellLocs;
//  x  y  z


void setup(){
  size(1600, 1000, P3D);
  cellLocs = new Cell[dim][dim][dim];
  initCells();
}

void initCells(){
  for (int x = 0; x < dim; x++) { // Initialize Cells
    for (int y = 0; y < dim; y++) {
      for(int z = 0; z < dim; z++) {
        cellLocs[x][y][z] = new Cell(x, y, z);
      }
    }
  }
  for (int x = 0; x < dim; x++) { // Set their neighbors
    for (int y = 0; y < dim; y++) {
      for(int z = 0; z < dim; z++) {
        cellLocs[x][y][z].setNeighbors();
      }
    }
  }
}


float xmag, ymag = 0;      // Used to rotate the scene around
float newXmag, newYmag = 0; 

void handleMouseRotations(){
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { 
    xmag -= diff/4.0; 
  }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0; 
  }
  
  rotateX(-ymag); 
  rotateY(-xmag); 
}

float yRot = 0.00;
int count = 0;
void draw(){
  background(0);
  yRot += 0.1;
  translate(width/2 + 50, height/2 + 150);
  
  //rotateY(0.1);
  //handleMouseRotations();
  
  rotateY(-2.6);
  rotateX(-2.6);
  
  for (int x = 0; x < dim; x++) {
    for (int y = 0; y < dim; y++) {
      for(int z = 0; z < dim; z++) {
        Cell cell = cellLocs[x][y][z];
        cell.display();
        cell.setNextState();        
      }
    }
  }
  for (int x = 0; x < dim; x++) {
    for (int y = 0; y < dim; y++) {
      for(int z = 0; z < dim; z++) {
        cellLocs[x][y][z].state = cellLocs[x][y][z].nextState;     
      }
    }
  }
  saveFrame("frame_"+count+".png");
  count++;
}
