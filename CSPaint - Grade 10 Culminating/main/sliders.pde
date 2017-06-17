/* makes each slider able to be moved */
void sliders() {
   //thickness slider
    if (dist(mouseX, mouseY, thicknessX, thicknessY) < brushWeight && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      thicknessX = mouseX;
      brushWeight = map(thicknessX, menuX*0.1, menuX*0.9, 10, 60);

      //updates brush's thickness
      changeWeight(brushWeight);
    }
    //red slider
    if (dist(mouseX, mouseY, redX, redY) < redR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      redX = mouseX;
      redValue = map(redX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value 
      changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //green slider
    if (dist(mouseX, mouseY, greenX, greenY) < greenR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      greenX = mouseX;
      greenValue = map(greenX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value
      changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //blue slider
    if (dist(mouseX, mouseY, blueX, blueY) < blueR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      blueX = mouseX;
      blueValue = map(blueX, menuX*0.1, menuX*0.9, 0, 255);

      //updates brush's colour value
      changeColour(redValue, greenValue, blueValue, opacityValue);
    }
    //opacity slider
    if (dist(mouseX, mouseY, opacityX, opacityY) < opacityR && mouseX > menuX*0.1 && mouseX < menuX*0.9) {
      opacityX = mouseX;
      opacityValue = map(opacityX, menuX*0.1, menuX*0.9, 25, 255);

      //updates brush's colour (and opacity) value
      changeColour(redValue, greenValue, blueValue, opacityValue);
    } 
}