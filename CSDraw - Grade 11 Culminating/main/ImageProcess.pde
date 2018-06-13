import java.net.URL;
import java.net.URLConnection;
import java.net.HttpURLConnection;
import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.util.Scanner;
import java.util.Base64;
import java.util.Random;
/** 
 * This class converts an image to a base64-encoded string
 *
 * In order for this class to work properly, there must be a text file
 * called "API_KEY.txt" in the same directory as this file. Inside the text
 * file must be a valid API key for the Google Cloud Vision API.
 *
 * @author Jason Guo
 * @since June 6, 2018
 * @version 1.0
 */
public static class ImageProcess {
  /**
   * The URL of the google vision API
   */
  private static final String TARGET_URL = 
    "https://vision.googleapis.com/v1/images:annotate?";

  /**
   * The user's score
   */
  public static float score = 0;

  /**
   * What the user must draw next
   */
  public static String objective;

  /**
   * The choices that the objective could be
   */
  public static ArrayList<String> objectiveChoices = new ArrayList<String>();

  /**
   * Makes a request to the Cloud Vision API for image analysis
   *
   * This uses the API key to authenticate a request to the Google Cloud
   * server. This code was based off of the official tutorial found on the
   * Google Cloud website. The tutorial can be found here:
   * https://goo.gl/r938mZ
   *
   * @param encodedImage The base64 encoded image 
   */
  static void analyzeImage(String encodedImage, String API_KEY) {
    URL serverUrl;
    try {
      serverUrl = new URL(TARGET_URL + API_KEY);
      URLConnection urlConnection = serverUrl.openConnection();
      HttpURLConnection httpConnection = (HttpURLConnection)urlConnection;
      httpConnection.setRequestMethod("POST");
      httpConnection.setRequestProperty("Content-Type", "application/json");
      httpConnection.setDoOutput(true);
      BufferedWriter httpRequestBodyWriter = new BufferedWriter(new
        OutputStreamWriter(httpConnection.getOutputStream()));
      httpRequestBodyWriter.write
        ("{\"requests\":  [{ \"features\":  [ {\"type\": \"LABEL_DETECTION\""
        +"}], \"image\": {\"content\":  \"" + encodedImage + "\"}}]}");
      httpRequestBodyWriter.close();

      if (httpConnection.getInputStream() == null) {
        System.out.println("No stream");
        return;
      }

      Scanner httpResponseScanner = new Scanner (httpConnection.getInputStream());
      while (httpResponseScanner.hasNext()) {
        //adds to the user's score
        String line = httpResponseScanner.nextLine();
        if (line.contains(objective.toLowerCase())) {
          String addScore = httpResponseScanner.nextLine();
          addScore = addScore.split("\"score\"")[1];
          addScore = addScore.split(",")[0];
          addScore = addScore.split(": ")[1];
          score += Float.valueOf(addScore) * 100;
          httpResponseScanner.close();
          return;
        }
      }
      score -= 20;
      httpResponseScanner.close();
      return;
    }  
    catch(Exception e) {
      e.printStackTrace();
    }
  }
  /**
   * Randomly changes the objective
   */
  static void changeObjective() {
    Random generateRandomNumber = new Random();
    if (objectiveChoices.size() == 0) return;
    int randomNumber = generateRandomNumber.nextInt(objectiveChoices.size());
    objective = objectiveChoices.get(randomNumber);
    objectiveChoices.remove(objective);
  }
  /**
   * Encodes a byte[] into a base64 string
   *
   * @param imageBytes The byte[] to be encoded
   * @return the encoded string
   */
  static String encode(byte[] imageBytes) {
    return Base64.getEncoder().encodeToString(imageBytes);
  } 
  /**
   * Resets the objective choices
   */
  static void resetObjectives() {
    objectiveChoices.clear();
    objectiveChoices.add("FLOWER");
    objectiveChoices.add("HAND");
    objectiveChoices.add("INSECT");
    objectiveChoices.add("CAT");
    objectiveChoices.add("APPLE");
    objectiveChoices.add("DUCK");
    objectiveChoices.add("BALLOON");
    objectiveChoices.add("BICYCLE");
    objectiveChoices.add("PENGUIN");
    objectiveChoices.add("TREE");
    objectiveChoices.add("HEART");
  }
}   