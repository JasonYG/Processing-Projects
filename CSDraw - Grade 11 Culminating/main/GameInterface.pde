/** 
 * This class displays UI of the game
 * 
 * @author Jason Guo
 * @since June 4, 2018
 * @version 1.0
 */
public class GameInterface {
  float brushWeight = 35;
  float menuX, menuY, thicknessX, thicknessY, redX, redY, redR, redValue,
    greenX, greenY, greenR, greenValue, blueX, blueY, blueR, blueValue, opacityX,
    opacityY, opacityR, opacityValue;

  /*
   * Constructor for the interface
   *
   * @param x The width of the screen
   * @param y The height of the screen
   */
  GameInterface(float x, float y) {
    menuX = x/6;
    menuY = y;
    thicknessX = (menuX*0.1 + menuX*0.9)/2;
    thicknessY = menuY/16;

    redX = menuX*0.1;
    redY = menuY/6;
    redR = brushWeight - 2;
    redValue = 0;

    greenX = menuX*0.1;
    greenY = 1.25*menuY/6;
    greenR = brushWeight - 2;
    greenValue = 0;

    blueX = menuX*0.1;
    blueR = brushWeight - 2;
    blueY = greenY + blueR + 10;
    blueValue = 0;

    opacityX = menuX*0.9;
    opacityR = blueR;
    opacityY = blueY + opacityR + 10;
    opacityValue = 255;
  }
  /* 
   * Draws menu on the left of the screen 
   */
  void drawMenu() {
    stroke(0);
    strokeWeight(5);
    fill(255);
    rectMode(CORNER);
    rect(0, 0, menuX, menuY*5/6);

    thicknessSelector(); //creates slider to change thickness of brush
    RGBSelector(); //creates slider to change colour of brush
    eraser(); //creates parallelogram for eraser
    brush(); //creates rectangle for brush
    squareBrush(); //creates square for square brush

    selectedTool(); //display the selected tool
    rectMode(CORNER);
    clearScreen(); //creates rectangle for the "cool sketch"
    nextDrawing(); //switches to next drawing
  }
  /*
   * Draws the top portion of the UI
   */
  void gameUI() {
    fill(255);
    rect(menuX, 0, width-menuX, height/6);

    //score
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Score: " + (int)ImageProcess.score, (width+menuX)*0.22, 1.1*height/12);

    //title
    fill(0);
    textAlign(CENTER);
    textSize(100);
    text(ImageProcess.objective, (menuX+width)/2, 1.3*height/12);

    //timer
    fill(0);
    textAlign(CENTER);
    textSize(100);
    text(60 + (int)currentTime/1000 - (int)millis()/1000, (width+menuX)*0.8, 1.3*height/12);

    //out of time
    if (60 + (int)currentTime/1000 - (int)millis()/1000 < 0) {
      screen = 2;
    }
  }
  /*
   * Creates the thickness slider
   */
  void thicknessSelector() {
    textSize(32);
    fill(0);
    textAlign(CENTER);
    text("Thickness Selector", menuX/2, menuY/32);

    stroke(0);
    strokeWeight(5);
    line(menuX*0.1, menuY/16, menuX*0.9, menuY/16);

    stroke(redValue, greenValue, blueValue, opacityValue);
    fill(redValue, greenValue, blueValue, opacityValue);
    ellipse(thicknessX, thicknessY, brushWeight, brushWeight);
  }
  /*
   * Allows each slider to be moved 
   */
  void sliders() {
    //thickness slider
    if (dist(mouseX, mouseY, thicknessX, thicknessY) < brushWeight && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      thicknessX = mouseX;
      brushWeight = map(thicknessX, menuX*0.1, menuX*0.9, 10, 60);

      //updates brush's thickness
      brush.changeWeight(brushWeight);
    }
    //red slider
    if (dist(mouseX, mouseY, redX, redY) < redR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      redX = mouseX;
      redValue = map(redX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value 
      brush.changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //green slider
    if (dist(mouseX, mouseY, greenX, greenY) < greenR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      greenX = mouseX;
      greenValue = map(greenX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value
      brush.changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //blue slider
    if (dist(mouseX, mouseY, blueX, blueY) < blueR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      blueX = mouseX;
      blueValue = map(blueX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value
      brush.changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //opacity slider
    if (dist(mouseX, mouseY, opacityX, opacityY) < opacityR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      opacityX = mouseX;
      opacityValue = map(opacityX, menuX*0.1, menuX*0.9, 25, 255);

      //updates brush's colour (and opacity) value
      brush.changeColour(redValue, greenValue, blueValue, opacityValue);
    }
  }
  /*
   * Creates the colour selectors
   */
  void RGBSelector() {
    fill(0);
    textAlign(CENTER);
    text("Colour Selector", menuX/2, menuY/8);

    //red slider
    stroke(255, 0, 0);
    strokeWeight(5);
    line(menuX*0.1, menuY/6, menuX*0.9, menuY/6);

    stroke(redValue, 0, 0);
    fill(redValue, 0, 0);
    ellipse(redX, redY, redR, redR);

    //green slider
    stroke(0, 255, 0);
    strokeWeight(5);
    line(menuX*0.1, greenY, menuX*0.9, greenY);

    stroke(0, greenValue, 0);
    fill(0, greenValue, 0);
    ellipse(greenX, greenY, greenR, greenR);

    //blue slider
    stroke(0, 0, 255);
    strokeWeight(5);
    line(menuX*0.1, blueY, menuX*0.9, blueY);

    stroke(0, 0, blueValue);
    fill(0, 0, blueValue);
    ellipse(blueX, blueY, blueR, blueR);

    //opacity slider
    stroke(0, 0, 0, opacityValue);
    strokeWeight(5);
    line(menuX*0.1, opacityY, menuX*0.9, opacityY);

    noStroke();
    fill(0, 0, 0, opacityValue);
    ellipse(opacityX, opacityY, opacityR, opacityR);
  }
  /* 
   * Displays the eraser element of the UI
   */
  void eraser() {
    strokeJoin(ROUND);
    stroke(0);
    fill(255, 181, 187);

    beginShape();
    vertex(menuX/2 - 75, menuY/3);
    vertex(menuX/2 - 95, menuY/2.5);
    vertex(menuX/2 + 75, menuY/2.5);
    vertex(menuX/2 + 95, menuY/3);
    vertex(menuX/2 - 75, menuY/3);
    endShape();

    fill(0);
    textAlign(CENTER);
    text("Eraser", menuX/2, menuY/2.75);
  }
  /*
   * Displays the brush element of the UI
   */
  void brush() {
    fill(255);
    stroke(0);
    rect(menuX*0.2, menuY/2.3, menuX*0.6, menuY*0.05);

    fill(0); 
    textMode(CENTER);
    text("Brush", menuX/2, menuY/2.15);
  }
  /*
   * Displays the square brush element of the UI
   */
  void squareBrush() {
    fill(255);
    stroke(0);
    rect(menuX*0.3, menuY/2, menuX*0.4, menuX*0.4);

    fill(0);
    rectMode(CENTER);
    text("Square brush", menuX*0.5, menuY*0.58, menuX*0.4, menuX*0.4);
  }
  /*
   * Displays the tool that is currently selected
   */
  void selectedTool() {

    //draws invisible rectangle for the tool selected info
    noFill();
    noStroke();
    rect(0, menuY*0.65, menuX, menuY*0.1);

    fill(0);
    if (screen == 2) {
      text("Cool sketch", menuX/2, menuY*0.7);
    } else if (switchBrush == 0) {
      rectMode(CENTER);
      text("Round brush selected", menuX/2, menuY*0.7, menuX, menuY*0.1);
    } else if (switchBrush == 1) {
      text("Eraser selected", menuX/2, menuY*0.7);
    } else if (switchBrush == 2) {
      text("Square brush selected", menuX/2, menuY*0.7, menuX, menuY*0.1);
    }
  }
  /*
   * Displays the clear screen element of the UI
   */
  void clearScreen() {
    stroke(0);
    fill(255);
    rect(0, menuY*0.75, menuX, menuY*0.1);

    fill(0);
    text("Clear screen", menuX/2, menuY*0.8);
  }
  /*
   * Displays the next drawing element of the UI
   */
  void nextDrawing() {
    stroke(0);
    fill(255);
    rect(0, menuY*0.85, menuX, menuY*0.15);

    fill(0);
    text("NEXT DRAWING", menuX/2, menuY*0.92);
  }
}