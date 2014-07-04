/* --------------------------------------------------------------------------
 * Project '87' V. 0.01
 * --------------------------------------------------------------------------
 * Face metrics received via OSC (oscP5 library)
 * Then drawn with simple particle system (confetti)
 * ----------------------------------------------------------------------------
 * Made from examples by Daniel Shiffman's Nature of Code
 * FaceOscSyphon by Kyle McDonald
 * and Dan Wilcox's FaceOSCSyphon processing template
 */

import oscP5.*; // import osc P5 library

OscP5 oscP5;

// FaceOSC tracked face data
Face face = new Face();

// two types of particles, to be played with later.
Particle p1; 
Particle p2;

boolean clicked=false;
boolean moving=false;
int a=0;
int b=50;

void setup()
{
  background(b, b, b);

  stroke(0, 0, 255);
  strokeWeight(3);

  size(640, 480);


  // set up OSC, listen for incoming messages at localhost port 8338
  oscP5 = new OscP5(this, 8338);

  // make the particles
  p1 = new Particle(width/2, height/2);
  p2 = new Particle(width/2, height/2);

  smooth();
}

void draw()
{

  // if Face is found
  if (face.found > 0) {
    float mx = map(face.posePosition.x, 0, 640, 0, width);
    float my = map(face.posePosition.y, 0, 480, 0, height);
    //    drawConfetti(mappedX, mappedY); // draws the confetti where the face is.
    println("face is at "+mx+" and "+my);
    // Call the appropriate steering behaviors for our agents
    p1.seek(new PVector(mx, my));  
    p2.arrive(new PVector(mx, my));
  }

  p1.update();
  p1.display();

  p2.update();
  p2.display();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  face.parseOSC(theOscMessage); // parse the OSC Message
}

void mouseClicked() {
  clicked=!clicked;
}

