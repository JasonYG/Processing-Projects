/*
 * Author: Jason Guo
 * Revision Date: June 17, 2017
 * Program Name: CSPaint - Culminating Activity (ICS20)
 * Program Description:
 *         Program developed to demonstrate my learning of programming concepts.
 */


PImage openScreen; //for displaying the welcome screen
int switchScreens = 0;

float brushWeight = 35; //default brush size
PaintBrush brush = new PaintBrush(mouseX, mouseY, brushWeight, color(0)); //default settings
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

//for loading images
PImage oldSketch;
boolean loaded = false;

//for the "cool sketch" screen
float protectionValue; //creates exit condition for recursive tree function
float heightValue; //creates height of the tree
float intervalValue; //creates the rate at which the tree grows

ArrayList<PVector> sketchCircles; //stores the positions of the random circles
ArrayList<PVector> sketchSpeed; //stores the speeds of the random circles

void settings() {
  fullScreen();
}
void setup() {
  openScreen = loadImage("openScreen.png"); //loads welcome screen image

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

  background(255);

  /* cool sketch screen */
  sketchCircles = new ArrayList<PVector>(); 
  sketchSpeed = new ArrayList<PVector>();
  //fills the circle arrays with random values, random positional values and random speed values
  for (int i = 0; i < 10; i++) {
    sketchCircles.add(new PVector(random(menuX, width), random(height)));
    sketchSpeed.add(new PVector(random(30), random(30)));
  }
}

void draw() {
  rectMode(CORNER); //resets rectmode back to default

  //switches between each screen
  switch (switchScreens) {
  case 0:
    openingScreen(); //welcoming screen
    break;
  case 1:
    paintScreen(); //main paint screen
    break;
  case 2:
    coolSketch(); //"cool sketch" screen
    drawMenu();
    break;
  }
}

void openingScreen() {
  imageMode(CENTER);
  background(255); 
  image(openScreen, width/2, height/2);
}
void paintScreen() {
  drawMenu(); //draws menu on the left
}

//press any key to exit out of the welcome screen
void keyPressed() {
  if (switchScreens == 0) {
    background(255);
    switchScreens = 1;
  }
}

void mouseDragged() {
  //checks if the mouse is not over the menu AND which brush is selected
  if (switchScreens != 0) {
    //regular brush
    if (mouseButton == LEFT && switchScreens == 1 && switchBrush == 0 && 
      mouseX > menuX) {
      brush.circleDisplay();
    }
    //square brush
    if (mouseButton == LEFT && switchScreens == 1 && switchBrush == 2 && 
      mouseX > menuX) {
      brush.squareDisplay();
    }
    //eraser
    if (mouseButton == LEFT && switchBrush == 1 && mouseX > menuX) {
      brush.erase();
    }
  }
  sliders(); //allows the sliders to be moved by the mouse
}
void mouseClicked() {
  if (switchScreens != 0) {
    //changes to eraser
    if (mouseButton == LEFT && switchBrush != 1) {
      if (mouseX > menuX/2 - 95 && mouseX < menuX/2 + 95 && 
        mouseY > menuY/3 && mouseY < menuY/2.5) {
        switchBrush = 1;
      }
    }
    //changes to brush
    if (mouseButton == LEFT && switchBrush != 0) {
      if (mouseX > menuX*0.2 && mouseX < menuX*0.8 && 
        mouseY > menuY/2.3 && mouseY < (menuY/2.3) + (menuY*0.05)) {
        switchBrush = 0;
      }
    }
    //changes to square brush
    if (mouseButton == LEFT && switchBrush != 2) {
      if (mouseX > menuX*0.3 && mouseX < menuX*0.7 && 
        mouseY > menuY/2 && mouseY < (menuY/2) + (menuY*0.4)) {
        switchBrush = 2;
        //  rect(menuX*0.3, menuY/2, menuX*0.4, menuX*0.4
      }
    }
    //"cool sketch" button
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menuX &&
        mouseY > menuY*0.75 && mouseY < menuY*0.85) {
        if (switchScreens == 1) {
          switchScreens = 2;
        } else if (switchScreens == 2) {
          switchScreens = 1;
        }
      }
    }    
    //save button
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menuX*0.5 &&
        mouseY > menuY*0.85 && mouseY < menuY*0.95) {
        PImage saveScreen = get(int(menuX)+5, int(0), int(width-menuX)-5, int(height));
        saveScreen.save("sketch.jpg");
      }
    }
    //load button
    if (mouseButton == LEFT) {
      if (mouseX > menuX/2 && mouseX < menuX &&
        mouseY > menuY*0.85 && mouseY < menuY*0.95) {
        selectInput("Select a sketch to load:", "sketchSelected");
      }
    }
    //clear screen
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menuX && 
        mouseY > menuY*0.95 && mouseY < menuY) {
        background(255);
        if (switchScreens == 2) {
          sketchCircles.clear();
        }
      }
    }
    //add circles in "cool sketch"
    if (mouseButton == LEFT && switchScreens == 2) {
      if (mouseX > menuX && mouseX < width) { 
        for (int i = 0; i < 10; i++) {
          sketchCircles.add(new PVector(random(mouseX-50, mouseX+50), random(mouseY-50, mouseY+50)));
          sketchSpeed.add(new PVector(random(30), random(30)));
        }
      }
    }
  }
}
//for loading sketches
void sketchSelected(File sketch) {
  oldSketch = loadImage(sketch.getAbsolutePath());
  loaded = true;
}