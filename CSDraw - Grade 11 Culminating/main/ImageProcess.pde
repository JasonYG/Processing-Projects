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
   * The API key for authentication
   */
  private static final String API_KEY = 
    "key=AIzaSyDDC0pAD50g0eJVViG7LmISflq83aTPSDk";

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
  public static ArrayList<String> objectiveChoices = new ArrayList<String>() {
    {
      add("FLOWER");
      add("HAND");
      add("INSECT");
      add("CAT");
      add("APPLE");
      add("DUCK");
      add("BALLOON");
      add("BICYCLE");
      add("PENGUIN");
      add("TREE");
      add("HEART");
      
    }
  };

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
   * Makes a request to the Cloud Vision API for image analysis
   *
   * This uses the API key to authenticate a request to the Google Cloud
   * server. This code was based off of the official tutorial found on the
   * Google Cloud website. The tutorial can be found here:
   * https://goo.gl/r938mZ
   *
   * @param encodedImage The base64 encoded image 
   */
  static void analyzeImage(String encodedImage) {
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
        println(line);
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
}   