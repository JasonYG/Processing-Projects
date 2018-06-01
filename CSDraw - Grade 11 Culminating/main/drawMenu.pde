/* draws menu on the left of the screen */
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
  authorInfo(); //information about the author
}

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
void brush() {
  fill(255);
  stroke(0);
  rect(menuX*0.2, menuY/2.3, menuX*0.6, menuY*0.05);

  fill(0); 
  textMode(CENTER);
  text("Brush", menuX/2, menuY/2.15);
}
void squareBrush() {
  fill(255);
  stroke(0);
  rect(menuX*0.3, menuY/2, menuX*0.4, menuX*0.4);

  fill(0);
  rectMode(CENTER);
  text("Square brush", menuX*0.5, menuY*0.58, menuX*0.4, menuX*0.4);
}
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
void clearScreen() {
  stroke(0);
  fill(255);
  rect(0, menuY*0.75, menuX, menuY*0.1);

  fill(0);
  text("Clear screen", menuX/2, menuY*0.8);
}
void authorInfo() {
  stroke(0);
  fill(255);
  rect(0, menuY*0.85, menuX, menuY*0.15);

  fill(0);
  text("Created by\n Jason Guo", menuX/2, menuY*0.9);
}