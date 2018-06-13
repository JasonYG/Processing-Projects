int screen = 0;
PImage openingScreen;

PaintBrush brush; //with default brush properties
GameInterface menu; //displays game's menu
int switchBrush = 0; //brush 0 is the regular round brush

float currentTime;

void settings() {
  fullScreen();
  //size(50, 50);
}
void setup() {
  openingScreen = loadImage("openScreen.png");
  brush = new PaintBrush();
  menu = new GameInterface(width, height);
}
void draw() {
  switch(screen) {
  case 0:
    welcomeScreen();
    break;
  case 1:
    menu.drawMenu();
    menu.gameUI();
    break;
  case 2:
    endScreen();
    break;
  }
}
void keyPressed() {
  if (screen == 0) {
    screen++;
    currentTime = millis();
    ImageProcess.resetObjectives();
    ImageProcess.changeObjective();
    background(255);
  }
  if (screen == 2) {
    screen = 0;
    ImageProcess.score = 0;
  }
}
void mousePressed() {
  if (screen != 0) {
    //changes to eraser
    if (mouseButton == LEFT && switchBrush != 1) {
      if (mouseX > menu.menuX/2 - 95 && mouseX < menu.menuX/2 + 95 && 
        mouseY > menu.menuY/3 && mouseY < menu.menuY/2.5) {
        switchBrush = 1;
      }
    }
    //changes to brush
    if (mouseButton == LEFT && switchBrush != 0) {
      if (mouseX > menu.menuX*0.2 && mouseX < menu.menuX*0.8 && 
        mouseY > menu.menuY/2.3 && mouseY < (menu.menuY/2.3) + (menu.menuY*0.05)) {
        switchBrush = 0;
      }
    }
    //changes to square brush
    if (mouseButton == LEFT && switchBrush != 2) {
      if (mouseX > menu.menuX*0.3 && mouseX < menu.menuX*0.7 && 
        mouseY > menu.menuY/2 && mouseY < (menu.menuY/2) + (menu.menuX*0.4)) {
        switchBrush = 2;
        //  rect(menu.menuX*0.3, menu.menuY/2, menu.menuX*0.4, menu.menuX*0.4
      }
    }
    //clear screen
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menu.menuX && 
        mouseY > menu.menuY*0.75 && mouseY < (menu.menuY*0.75) + (menu.menuY*0.1)) {
        background(255);
      }
    }
    //switches to the next drawing
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menu.menuX && 
        mouseY > menu.menuY*0.85 && mouseY < menu.menuY) {
        //saves the picture
        PImage saveScreen = get(int(menu.menuX)+5, int(height/6), int(width-menu.menuX)-5, int(height-height/6));
        saveScreen.save("sketch.jpg");
        //calls API
        ImageProcess.analyzeImage(ImageProcess.encode(loadBytes("sketch.jpg")), 
          "key=" + loadStrings("API_KEY.txt")[0]);
        ImageProcess.changeObjective();
        background(255);
      }
    }
  }
}
void mouseDragged() {
  //checks if the mouse is not over the menu AND which brush is selected
  if (screen != 0) {
    if (mouseY > height/6) {
      //regular brush
      if (mouseButton == LEFT && screen == 1 && switchBrush == 0 && 
        mouseX > menu.menuX) {
        brush.circleDisplay();
      }
      //square brush
      if (mouseButton == LEFT && screen == 1 && switchBrush == 2 && 
        mouseX > menu.menuX) {
        brush.squareDisplay();
      }
      //eraser
      if (mouseButton == LEFT && switchBrush == 1 && mouseX > menu.menuX) {
        brush.erase();
      }
    }
  }
  menu.sliders(); //allows the sliders to be moved by the mouse
}
void welcomeScreen() {
  background(255);
  imageMode(CENTER);
  image(openingScreen, width/2, height/2);
}
void endScreen() {
  background(255);
  imageMode(CENTER);
  textSize(100);
  text("Your final score is " + (int)ImageProcess.score, width/2, height/2);
  textSize(50);
  text("Press any key to play again.", width/2, height*0.75);
}