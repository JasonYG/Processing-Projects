/* creates a class for paint brush tool */
class PaintBrush {
  float xPos, yPos, size;
  color colour;
  PaintBrush(float x, float y, float s, color c) {
    xPos = x;  //x coordinate
    yPos = y; //y coordinate
    size = s; //size, diameter or width/height of the brush
    colour = c; //colour
  }
  //to display a rounded line
  void circleDisplay() {
    //updates the paintbrush's x and y value to follow the mouse
    xPos = mouseX; 
    yPos = mouseY;
    strokeWeight(size);
    stroke(colour);
    fill(colour);
    line(pmouseX, pmouseY, xPos, yPos);
  }
  //to display squares
  void squareDisplay() {
    xPos = mouseX;
    yPos = mouseY;
    noStroke();
    fill(colour);
    rect(xPos, yPos, size, size);
  }
  //changes the brush to be white, thus "erasing"
  void erase() {
    strokeWeight(size);
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
  }
}