/** 
 * This class is used for the paint brush tool 
 * 
 * @author Jason Guo
 * @since June 14, 2018
 * @version 1.0
 */
public class PaintBrush {
  float xPos, yPos;
  float size = 35;
  color colour = color(0, 0, 0);
  
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
   * Uses the bucket tool
   *
   * This method is similar to a flood fill algorithm,
   * in that it checks whether the adjacent pixels are
   * the same colour. If they are, then they are added to 
   * to a queue. Each pixel in the queue is "visited", and
   * the algorithm stops when the queue is empty.
   */
  void bucketDisplay() {
    loadPixels();
    boolean[] visitedPixels = new boolean[width*height];
    ArrayList<Integer> pixelQueue = new ArrayList<Integer>();
    color initialColor = pixels[mouseX + mouseY*width];
    //if the bucket tool is used on a pixel of the same colour
    if (initialColor == colour) {
      return;
    }
    pixelQueue.add(mouseX + mouseY*width);

    while (!pixelQueue.isEmpty()) {
      int currentCoordinate = pixelQueue.get(0);

      //checks if the currentCoordinate has already been visited
      if (visitedPixels[currentCoordinate]) {
        pixelQueue.remove(0);
        continue;
      } else {
        visitedPixels[currentCoordinate] = true;
      }
      
      pixels[currentCoordinate] = colour; //updates colour of pixel
      
      //pixel to the right
      if ((currentCoordinate + 1) % width+1 <= width && currentCoordinate + 1 < width*height) {
        if ((pixels[currentCoordinate+1]) == initialColor) {
          if (!pixelQueue.contains(currentCoordinate+1)) {
            pixelQueue.add(currentCoordinate + 1);
          }
        }
      }
      //pixel to the left
      if (currentCoordinate % width-1 >= width/6) {
        if (pixels[currentCoordinate-1] == initialColor) {
          if (!pixelQueue.contains(currentCoordinate-1)) {
            pixelQueue.add(currentCoordinate-1);
          }
        }
      }
      
      //pixel to the top
      if (currentCoordinate - width >= height/6) {
        if ((pixels[currentCoordinate - width]) == initialColor) {
          if (!pixelQueue.contains(currentCoordinate-width)) {
            pixelQueue.add(currentCoordinate-width);
          }
        }
      }
      //pixel to the bottom
      if (currentCoordinate + width < width*height) {
        if ((pixels[currentCoordinate+width]) == initialColor) {
          if (!pixelQueue.contains(currentCoordinate+width)) {
            pixelQueue.add(currentCoordinate+width);
          }
        }
      }
      pixelQueue.remove(0);
    }
    updatePixels();
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