/** 
 * This class is used for the paint brush tool 
 * 
 * @author Jason Guo
 * @since June 4, 2018
 * @version 1.0
 */
public class PaintBrush {
  float xPos, yPos, size;
  color colour;
  PaintBrush(float x, float y, float s, color c) {
    xPos = x;  //x coordinate
    yPos = y; //y coordinate
    size = s; //size, diameter or width/height of the brush
    colour = c; //colour
  }
  /**
   * Displays a rounded brush
   */
  void circleDisplay() {
    //updates the paintbrush's x and y value to follow the mouse
    xPos = mouseX; 
    yPos = mouseY;
    strokeWeight(size);
    stroke(colour);
    fill(colour);
    line(pmouseX, pmouseY, xPos, yPos);
  }
  /**
   * Displays a square brush
   */
  void squareDisplay() {
    xPos = mouseX;
    yPos = mouseY;
    noStroke();
    fill(colour);
    rect(xPos, yPos, size, size);
  }
  /**
   * Switches brush to erase
   */
  void erase() {
    strokeWeight(size);
    stroke(255);
    line(pmouseX, pmouseY, mouseX, mouseY); 
  }
}