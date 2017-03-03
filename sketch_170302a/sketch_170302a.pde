PImage img;
public float r;
public float g;
public float b;
public int imageLocation;
public int displayLocation;
public int resizeFactor=3;
 //-----------------------------------------------------------------------------
 //The states to choose from, take a look at line 18/19
public enum states {
  stateNormal, stateInvertColors, stateEveryThirdPixel, stateReverseImage, stateIDontEvenKnow
};
//-----------------------------------------------------------------------------
public states state;

void setup() {
  //-----------------------------------------------------------------------------
  //change this states for different effects
  state = states.stateNormal;
  //-----------------------------------------------------------------------------
  size(999, 999);
  img = loadImage("Ahmedabad_Railway_Station.jpg");//ImageSize: 333x333
  //image(img, 0, 0); //method to draw the picture, below is the code to draw it on my own.
  loadPixels();
  drawsImage();
  updatePixels();
}

public void drawsImage() {
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      imageLocation = x+y*img.width;
      int factor=3;
      if (state == states.stateInvertColors) {//interestingly, photoshop invert looks slightly different(smoother)
        r = red(255-img.pixels[imageLocation]);
        g = green(255-img.pixels[imageLocation]);
        b = blue(255-img.pixels[imageLocation]);
      } else {
        r = red(img.pixels[imageLocation]);
        g = green(img.pixels[imageLocation]);
        b = blue(img.pixels[imageLocation]);
      }
      pixels[x*factor+y*width*factor] =  color(r, g, b);
    }
  }
  if (state != states.stateEveryThirdPixel) {
    drawOtherPixels();
  }
  if(state == states.stateReverseImage) {
    reverseImage();
  }
}
public void drawOtherPixels() {
  //Draw first line for every 3rd line
  for (int j = 0; j<pixels.length; j+=3) {
    for (int i = 0; i<3; i++) {
      if (pixels[i+j]!=pixels[j]) {//stop drawing the same pixel over the same pixel
        pixels[i+j] = pixels[j];
      }
    }
  }
  if (state == states.stateIDontEvenKnow) {
    resizeFactor=2;
  } else {
    resizeFactor=3;
  }
  //picks first pixel and draws it for the other 2 lines
  for (int j=1; j<width-1; j+=resizeFactor) {
    for (int i=1; i<width; i++) {
      pixels[j*width+i]=pixels[(j-1)*width+i];
      pixels[(j+1)*width+i]=pixels[(j-1)*width+i];
    }
  }
}

public void reverseImage() {
  int[] arrPixels = new int[pixels.length];
  for (int i = 0; i <pixels.length; i++) {
    arrPixels[i] = pixels[i];
  }
  arrPixels= reverse(arrPixels);
  for (int i = 0; i <pixels.length; i++) {
    pixels[i] = arrPixels[i];
  }
}