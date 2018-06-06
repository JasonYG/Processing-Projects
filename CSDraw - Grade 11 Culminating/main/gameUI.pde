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
  if (60 + (int)currentTime/1000 + (int)millis()/1000 == 0) {
    screen = 2;
  }
}