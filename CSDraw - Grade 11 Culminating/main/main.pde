int screen = 0;
PImage openingScreen;

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

float currentTime;
import java.net.URL;
import java.net.URLConnection;
import java.net.HttpURLConnection;
import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.util.Scanner;
//import com.google.http.client;
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
  greenY = 1.25*menuY/6;
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
    String TARGETURL = 
      "https://vision.googleapis.com/v1/images:annotate?";
    String KEY = "key=AIzaSyDDC0pAD50g0eJVViG7LmISflq83aTPSDk";
    URL serverUrl;
    try {
      serverUrl = new URL(TARGETURL + KEY);
      URLConnection urlConnection = serverUrl.openConnection();
      HttpURLConnection httpConnection = (HttpURLConnection)urlConnection;
      httpConnection.setRequestMethod("POST");
      httpConnection.setRequestProperty("Content-Type", "application/json");
      httpConnection.setDoOutput(true);
      BufferedWriter httpRequestBodyWriter = new BufferedWriter(new
        OutputStreamWriter(httpConnection.getOutputStream()));
      httpRequestBodyWriter.write
        ("{\"requests\":  [{ \"features\":  [ {\"type\": \"LABEL_DETECTION\""
        +"}], \"image\": {\"source\": { \"gcsImageUri\":"
        +" \"gs://vision-sample-images/4_Kittens.jpg\"}}}]}");
      httpRequestBodyWriter.close();
      String response = httpConnection.getResponseMessage();
      println(response);
      noLoop();
      
      if (httpConnection.getInputStream() == null) {
        System.out.println("No stream");
        return;
      }

      Scanner httpResponseScanner = new Scanner (httpConnection.getInputStream());
      String resp = "";
      while (httpResponseScanner.hasNext()) {
        String line = httpResponseScanner.nextLine();
        resp += line;
        System.out.println(line);  //  alternatively, print the line of response
        noLoop();
      }
      httpResponseScanner.close();
      noLoop();
    }  
    catch(Exception e) {
      e.printStackTrace();
    }


    //welcomeScreen();
    break;
  case 1:
    drawMenu();
    gameUI();
    break;
  }
}
void keyPressed() {
  if (screen == 0) {
    screen++;
    currentTime = millis();
    background(255);
  }
}
void mouseClicked() {
  if (screen != 0) {
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
        mouseY > menuY/2 && mouseY < (menuY/2) + (menuX*0.4)) {
        switchBrush = 2;
        //  rect(menuX*0.3, menuY/2, menuX*0.4, menuX*0.4
      }
    }
    //clear screen
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menuX && 
        mouseY > menuY*0.75 && mouseY < (menuY*0.75) + (menuY*0.1)) {
        background(255);
      }
    }
    //switches to the next drawing
    if (mouseButton == LEFT) {
      if (mouseX > 0 && mouseX < menuX && 
        mouseY > menuY*0.85 && mouseY < menuY) {
        //saves the picture
        PImage saveScreen = get(int(menuX)+5, int(height/6), int(width-menuX)-5, int(height-height/6));
        saveScreen.save("sketch.jpg");

        //clears screen
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
        mouseX > menuX) {
        brush.circleDisplay();
      }
      //square brush
      if (mouseButton == LEFT && screen == 1 && switchBrush == 2 && 
        mouseX > menuX) {
        brush.squareDisplay();
      }
      //eraser
      if (mouseButton == LEFT && switchBrush == 1 && mouseX > menuX) {
        brush.erase();
      }
    }
  }
  sliders(); //allows the sliders to be moved by the mouse
}
void welcomeScreen() {
  background(255);
  imageMode(CENTER);
  image(openingScreen, width/2, height/2);
}