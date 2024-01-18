int windowSize = 800;
int numberSquares = windowSize/60;
int squareWidth = windowSize/numberSquares;


void setup() {
  size(800, 800); // must match windowSize

  background(255, 255, 255);
  createGrid(numberSquares, squareWidth);
  algo(35, 37, 6, 36, 10, 12);
}


void draw() {
  // keeps drawing and deleting
  //background(255, 255, 255);
  //createGrid(numberSquares, squareWidth);
  //algo(5, 7, 3, 6, 5, 3);
  //delay(100);
}


void createGrid(int squares, int squareWidth) {
  stroke(0); 

  // Draw vertical lines
  for (int i = 0; i <= squares; i++) {
    float x = i * squareWidth;
    line(x, 0, x, windowSize*4);
  }

  // Draw horizontal lines
  for (int j = 0; j <= squares; j++) {
    float y = j * squareWidth;
    line(0, y, windowSize*4, y);
  }
} 

void randomColor() {
  int R = (int) random(0, 255);
  int G = (int) random(0, 255);
  int B = (int) random(0, 255);
  fill(R, G, B); 
}

void drawSquare(int row, int col) {
   randomColor();
   rect(row*squareWidth, col*squareWidth, squareWidth, squareWidth); 
}

void drawCircle(int row, int col) {
   randomColor();
   circle(row*squareWidth - squareWidth/2, col*squareWidth - squareWidth/2, squareWidth); 
}

void drawRecLeft(int row, int col) {
   randomColor();
   rect(row*squareWidth, col*squareWidth, squareWidth / 2, squareWidth); 
}

void drawRecRight(int row, int col) {
   randomColor();
   rect(row*squareWidth + squareWidth/2, col*squareWidth, squareWidth / 2, squareWidth); 
}

void drawTriTopLeft(int row, int col) {
  randomColor();
  triangle(row*squareWidth- squareWidth, 
           squareWidth*col, 
           
           squareWidth*row - squareWidth, 
           squareWidth*col + squareWidth, 
           
           squareWidth*row, 
           squareWidth*col);
}

void drawTriBotRight(int row, int col) {
  randomColor();
  triangle(row*squareWidth + squareWidth, 
           squareWidth*col, 
           
           squareWidth*row + squareWidth, 
           squareWidth*col - squareWidth, 
           
           squareWidth*row, 
           squareWidth*col);
}

int getRandom() {
  return (int) random(0, numberSquares);
}

void algo(int numSquare, int numCircles, int numTopTri, int numBotTri,int numRecRight, int numRecLeft) {
  
  for(int i = 0; i<numSquare; i++) {
    drawSquare(getRandom(), getRandom());
}
  for(int i = 0; i<numCircles; i++) {
    drawCircle(getRandom(), getRandom());
}
  for(int i = 0; i<numTopTri; i++) {
    drawTriTopLeft(getRandom(), getRandom());
}
  for(int i = 0; i<numBotTri; i++) {
    drawTriBotRight(getRandom(), getRandom());
}
  for(int i = 0; i<numRecRight; i++) {
    drawRecRight(getRandom(), getRandom());
}
  for(int i = 0; i<numRecLeft; i++) {
    drawRecLeft(getRandom(), getRandom());
}

}

// doesn't work super well rounding problems
//void mousePressed() {
//  int x = (int) mouseX / squareWidth;
//  int y = (int) mouseY / squareWidth;
  
//  println("click!");
//  println("x: " + x);
//  //print(y);
//  println("y: " + y);
  
//  println("click!");
//  println("x div : " + x / squareWidth);
//  //print(y);
//  println("y div : " + y / squareWidth);
  
//  drawRandom(x , y);
  
//}

//void drawRandom(int row, int col) {
  
//  int value = (int) random(1, 4);
  
//  println("value : " + value);
  
//   switch(value) {
//    case 1:
//      drawSquare(row, col);
//      break;
//    case 2:
//      drawCircle(row, col);
//      break;
//    case 3:
//      drawTriTopLeft(row, col);
//      break;
//  }
  
//}
