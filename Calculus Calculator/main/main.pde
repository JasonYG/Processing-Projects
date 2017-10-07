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
  case 1:
    graphScreen();
  println(screen);
}
void openingScreen() {
  imageMode(CENTER);
  image(openScreen, width/2, height/2);
}
void graphScreen() {
  fill(0);
  strokeWeight(25);
  line(width/2, 0, width/2, height); //draws y-axis
  line(0, height/2, width, height/2); //draws x-axis
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