/*
 * Author: Jason Guo
 * Revision Date: June 14, 2018
 * Program Name: CSDraw - Culminating Activity (ICS3U)
 * Program Description:
 *         Program developed to build on my knowledge of programming concepts from Grade 10.
 */
int screen = 0;
PImage openingScreen;

PaintBrush brush; //with default brush properties
GameInterface menu; //displays game's menu

float currentTime;

void settings() {
  fullScreen();
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
    menu.resetSliders();
  }
}
void mousePressed() {
  if (screen != 0) {
    //changes to eraser
    if (mouseButton == LEFT && menu.switchBrush != 1) {
      if (mouseX > menu.menuX/2 - 95 && mouseX < menu.menuX/2 + 95 && 
        mouseY > menu.menuY/3 && mouseY < menu.menuY/2.5) {
        menu.switchBrush = 1;
      }
    }
    //changes to brush
    if (mouseButton == LEFT && menu.switchBrush != 0) {
      if (mouseX > menu.menuX*0.2 && mouseX < menu.menuX*0.8 && 
        mouseY > menu.menuY/2.3 && mouseY < (menu.menuY/2.3) + (menu.menuY*0.05)) {
        menu.switchBrush = 0;
      }
    }
    //changes to paint bucket
    if (mouseButton == LEFT && menu.switchBrush != 2) {
      if (mouseX > menu.menuX*0.3 && mouseX < menu.menuX*0.7 && 
        mouseY > menu.menuY/2 && mouseY < (menu.menuY/2) + (menu.menuX*0.4)) {
        menu.switchBrush = 2;
      }
    }
    //bucket tool
    if (mouseButton == LEFT && screen == 1 && menu.switchBrush == 2 && 
      mouseX > menu.menuX) {
      brush.bucketDisplay();
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
        PImage saveScreen = get(int(menu.menuX)+5, int(height/6)+5, int(width-menu.menuX)-5, int(height-height/6));
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
      if (mouseButton == LEFT && screen == 1 && menu.switchBrush == 0 && 
        mouseX > menu.menuX) {
        brush.circleDisplay();
      }
      //eraser
      if (mouseButton == LEFT && menu.switchBrush == 1 && mouseX > menu.menuX) {
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