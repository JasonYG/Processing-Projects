/** 
 * This class is used for the paint brush tool 
 * 
 * @author Jason Guo
 * @since June 4, 2018
 * @version 1.0
 */
public class PaintBrush {
  float xPos, yPos;
  float size = 35;
  color colour;
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
  /* 
   * Updates the thickness or size of the brush
   *
   * @param weight The desired thickness of the brush
   */
  //updates the thickness or size of the brush
  void changeWeight(float weight) {
   size = weight;
  }
  /*
   * Updates the colour of the brush
   *
   * @param redValue The new red value of the brush
   * @param greenValue The new green value of the brush
   * @param blueValue The new blue value of the brush
   * @param opacityValue The new opacity value of the brush
   */
  void changeColour(float redValue, float greenValue, float blueValue, float opacityValue) {
    colour = color(redValue, greenValue, blueValue, opacityValue);
  }
}