/* Changes various settings of the brush */
//updates the thickness or size of the brush
void changeWeight(float weight) {
  brush.size = weight;
}
//updates the colour of the brush
void changeColour(float redValue, float greenValue, float blueValue, float opacityValue) {
  brush.colour = color(redValue, greenValue, blueValue, opacityValue);
}