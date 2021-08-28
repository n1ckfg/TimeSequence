import processing.video.*;

Capture video;
int numFrames = 3;
int maxAlphaVal = 4;
int frameCounter = 0;
PImage[] frames = new PImage[numFrames];

void setup() {
  size(960, 540, P2D);
  video = new Capture(this, 960, 540);
  video.start();
  
  for (int i=0; i<frames.length; i++) {
    frames[i] = createImage(width, height, RGB);
  }
  
  background(0);
}

void captureEvent(Capture video) {
  video.read();
  
  frames[frameCounter++] = video;
  if (frameCounter > frames.length-1) frameCounter = 0;
}

void draw() {
  for (int i=frames.length - 1; i >= 0; i--) {
    float alphaVal = map((float) i/frames.length, 0, 1, 1, maxAlphaVal);
    if (i > frames.length / 2) {
      blendMode(ADD);
    } else {
      blendMode(DARKEST);
    }
    
    tint(255, alphaVal);
    image(frames[i], 0, 0);
  }
  
  surface.setTitle("" + frameRate);
}
