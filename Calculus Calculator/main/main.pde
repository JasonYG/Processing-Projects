PImage openScreen;
int screen = 0; //changes between the screens of the program
void settings() {
  fullScreen();
}
void setup() {
  openScreen = loadImage("openScreen.png"); //loads welcome screen image
  background(255);
}
void draw() {
  switch(screen) { //swaps between screens
  case 0:
    openingScreen();
    break;
  }
  println(screen);
}
void openingScreen() {
  imageMode(CENTER);
  image(openScreen, width/2, height/2);
}
void keyPressed() {
  switch(screen) {
  case 0:
    if (keyPressed) {
      screen = 1;
      background(255);
    }
    break;
  }
}