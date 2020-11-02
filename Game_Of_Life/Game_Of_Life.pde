final int size = 600;
int cubeSize = 30;
int arraySize = size / cubeSize;
Cell[][] grid;
boolean run = false;
final int msDelay = 70;

// Creates window of size size. Runs before everything else
void settings(){
  size(size,size);
}

// Sets initial conditions like background, initializes the grid.
void setup(){
  background(255);
  grid = new Cell[arraySize][arraySize];
  initializeGrid();
  updateGrid();

}

// Main loop, updates every msDelay milliseconds
void draw(){
  if(run){
    startGame();
  }

  updateGrid();
  
}

// Function that calls only when mouse is pressed.
// Here I go over what Cell my mouse is on and changes the state of that specific Cell.
// If chosen cell is [0][0] (top left), run is set to true and the game starts/pauses
void mousePressed(){
  int y = mouseX/cubeSize;
  int x = mouseY/cubeSize;
  if(grid[y][x].state == 1){grid[y][x].state = 0;}
  else{grid[y][x].state = 1;}
  
  if(y == 0 & x == 0){run = !run;}
}

// Sets starting state of every cell to 0 (dead)
void initializeGrid(){
  for(int y = 0; y < arraySize; y++){
    for(int x = 0; x < arraySize; x++){
      grid[y][x] = new Cell(y, x, 0);
    }
  }
}

// Method is locked behind boolean value run. This method just calls for update methods for the cells
void startGame(){
  updateNB();
  updateState();
  delay(msDelay);
}

// Nested for loops to update the amount of neighbours for every cell.
void updateNB(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      grid[i][j].getNB();
    }
  }
}

// Nested for loops to change the state of the cell to either dead or alive based on the amount of neighbours
void updateState(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      grid[i][j].changeState();
    }
  }
}

// Nested for loops to draw every Cell
void updateGrid(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      grid[i][j].display();
    }
  }
}

// Class for the cells. Has values for what row/column it is, amount of neighbours, current state etc
class Cell{
  int col;
  int row;
  int state;
  int nb;
  int colour;
  
  Cell(int tempCol, int tempRow, int tempState){
    col = tempCol;
    row = tempRow;
    state = tempState;
  }
  
  
  // This method updates the amount of neighbours the cell currently has using a nested for loop. This way it can check all 8 surrounding cells.
  void getNB(){
    nb = 0;
    int rcol ;
    int rrow;
    for(int i = -1; i < 2; i++){
      for(int j = -1; j < 2; j++){
        // make sure cant get out of grid

          rcol = col + i;
          rrow = row + j;
          if(rcol >= 0 & rrow >= 0 & rcol < arraySize & rrow < arraySize){
            nb = nb + grid[rcol][rrow].state;
          }
        }
      }
      
      nb = nb - grid[col][row].state;
  }
   
   
  // This method changes the state of the cell based on the rules of the game of life, so the amount of neighbours it currently has
  void changeState(){
    if(state == 1){
      if(nb < 2){state = 0;}
      else if(nb == 2 | nb == 3){state = 1;}
      else if(nb > 3){state = 0;}
    }
    
    else if(state == 0){
      if(nb == 3){state = 1;}
    }
  }   
  
  // Here we draw each individual cell, just a white rectangle if its dead or a black rectangle if its alive.
  void display(){
    if(state == 0){colour = 255;}
    else{colour = 0;}
    fill(colour);
    rect(col*cubeSize, row*cubeSize, cubeSize, cubeSize);
  }
    
}
