int screen = 0;
PImage openingScreen;

int brushWeight = 30;
int switchBrush = 0; //brush 0 is the regular round brush

//for the menus on the left
float menuX; 
float menuY;

//for the various sliders 
float thicknessX;
float thicknessY;

float redX;
float redY;
float redR = brushWeight - 2;
float redValue;

float greenX;
float greenY;
float greenR = brushWeight - 2;
float greenValue;

float blueX;
float blueY;
float blueR = brushWeight - 2;
float blueValue;

float opacityX;
float opacityY;
float opacityR = blueR;
float opacityValue;
void settings() {
  fullScreen();
}
void setup() {
  openingScreen = loadImage("openScreen.png");
  /* menu on the left */
  menuX = width/6; 
  menuY = height;

  //size of the sliders
  thicknessX = (menuX*0.1 + menuX*0.9)/2;
  thicknessY = menuY/16;

  redX = menuX*0.1;
  redY = menuY/6;
  redValue = 0;

  greenX = menuX*0.1;
  greenY = menuY/5;
  greenValue = 0;

  blueX = menuX*0.1;
  blueY = greenY + blueR + 10;
  blueValue = 0;

  opacityX = menuX*0.9;
  opacityY = blueY + opacityR + 10;
  opacityValue = 255;
}
void draw() {
  switch(screen) {
  case 0:
    welcomeScreen();
    break;
  case 1:
    drawMenu();
    break;
  }
}
void keyPressed() {
  if (screen == 0) {
    screen++;
    background(0);
  }
}
void welcomeScreen() {
  background(255);
  imageMode(CENTER);
  image(openingScreen, width/2, height/2);
}
void paintScreen() {
  background(255);
  fill(0);
  text("yo", width/2, height/2);
}