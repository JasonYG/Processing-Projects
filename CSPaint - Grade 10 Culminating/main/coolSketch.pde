/* draws the "cool sketch" screen */
void coolSketch() {
  background(255);
  protectionValue = height*0.05; //condition to exit out of the recursive function
  heightValue = height*0.92; //height of the tree branches
  intervalValue = height/6;  //the rate in which the tree branches "grow"

  //random moving circles
  for (int i = 0; i < sketchCircles.size(); i++) {
    PVector loc = sketchCircles.get(i);
    PVector speed = sketchSpeed.get(i);

    //prevents the circles from moving out of the screen
    if (loc.x < menuX || loc.x > width) {
      speed.x *= -1;
    }
    if (loc.y < 0 || loc.y > height) {
      speed.y *= -1;
    }
    loc.x += speed.x;
    loc.y += speed.y;
    
    //circle collision, prevents the circles from moving through one another
    for (int j = 0; j < sketchCircles.size(); j++) {
      //checks the current circle with every other circle in the array, to make sure they do not overlap
      PVector check = sketchCircles.get(j);
      if (j == i) {
        continue;
      } else {
        if (dist(loc.x, loc.y, check.x, check.y) < brushWeight/2) {
          speed.x *= -1;
          speed.y *= -1;
        }
      }
    }
    //draws all the circles
    noStroke();
    fill(redValue, greenValue, blueValue);
    ellipse(loc.x, loc.y, brushWeight, brushWeight);
  }
  
  //draws the recursive tree
  strokeWeight(10);
  stroke(random(redValue), random(greenValue), random(blueValue), random(opacityValue));
  line((width+menuX)/2, height, (width+menuX)/2, heightValue);
  fractalTree((width+menuX)/2, heightValue, intervalValue);
}
//draws a tree using recursion
void fractalTree(float x, float y, float interval) {
  interval *= 0.9; //each tree branch is 90% the size of the previous one
  if (interval > protectionValue) {
    stroke(random(redValue), random(greenValue), random(blueValue), random(opacityValue));
    line(x, y, x + interval, y - interval); //draws right branch
    line(x, y, x - interval, y - interval); //draws left branch
    fractalTree(x + interval, y - interval, interval); //draws the right half of the tree
    fractalTree(x - interval, y - interval, interval); //draws the left half of the tree
  }
}