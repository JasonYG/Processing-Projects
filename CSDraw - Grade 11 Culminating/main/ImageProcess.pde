/** 
 * This class converts an image to a base64-encoded string
 *
 * @author Jason Guo
 * @since June 4, 2018
 .+
 * @version 1.0
 */
import java.util.Base64;
public static class ImageProcess {
  private static final String TARGETURL = 
  "https://vision.googleapis.com/v1/images:annotate?";
  private static final String KEY = "AIzaSyCVeCZ_Y6M7nRuzPQ6w3tae6j_xS7xSocY";
  /**
   * Encodes a byte[] into a base64 string
   *
   * @param imageBytes The byte[] to be encoded
   * @return the encoded string
   */
   static String encode(byte[] imageBytes) {
    return Base64.getEncoder().encodeToString(imageBytes);
  }
}