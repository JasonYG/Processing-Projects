float score = pow(600000,10);
void gameUI() {
  fill(255);
  rect(menuX, 0, width-menuX, height/6);
  
  fill(0);
  textAlign(CENTER);
  text("Score\n" + (int)score, width*0.2, 0.9*height/12);
  
  //score
  //timer
  fill(0);
  textAlign(CENTER);
  textSize(100);
  text(60 - millis()/1000, width*0.95, 1.3*height/12);
  
  //out of time
  if (60 - millis()/1000 == 0) {
    screen = 2;
  }
}