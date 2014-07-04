// Particle class based on Dan Shiffman's Code
// Daniel Shiffman <http://www.shiffman.net>

class Particle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  // additional display stuff to be added later
  // Ball[] balls = new Ball[20];
  // float curX, curY, lastX, lastY;
  


  Particle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
    
//   for (int i = 0; i < balls.length; i++) {
//    balls[i] = new Ball(mouseX, mouseY);
//  }
//  ellipseMode(CENTER);
//  rectMode(CENTER);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    applyForce(steer);
  }
  
  // A method that calculates a steering force towards a target, slowing down as target approaches
  // STEER = DESIRED MINUS VELOCITY
  void arrive(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    float d = desired.mag();
    
    // Normalize desired and scale with arbitrary damping within 100 pixels
    desired.normalize();
    if (d < 100) desired.mult(maxspeed*(d/100));
    else desired.mult(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }
    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}
//
//void drawConfetti(float x, float y) {
//  background(b, b, b);
//
//  curX = x;
//  curY = y;
//  noStroke();
//  for (int i = 5; i<width/50; i++) {      
//    fill(50, a*(i-4));
//    if (!clicked) {
//      ellipse(curX, curY, height/i, height/i);
//    } else {
//      rect(curX, curY, height/i, height/i);
//    }
//  }
//  for (int i = balls.length-1; i > 0; i--) {
//    balls[i].x = balls[i-1].x;
//    balls[i].y = balls[i-1].y;
//  }
//  balls[0].x=curX;
//  balls[0].y=curY;
//
//  for (int i = 0; i < balls.length; i++) {
//    balls[i].display();
//  }
//
//  if (curX!=lastX||curY!=lastY) {
//    moving=true;
//  } else {
//    moving=false;
//  }
//
//  if (moving)
//  {
//    if (a<255) {
//      a+=3;
//    }
//    if (b>0) {
//      b--;
//    }
//  } else
//  {
//    if (a>0) {
//      a-=5;
//    }
//    if (b<100) {
//      b++;
//    }
//  }
//  lastX = curX;
//  lastY = curY;
//}
//
//class Ball {
//  float x, y;
//
//  Ball(float _x, float _y) {
//    x=_x;
//    y=_y;
//  }
//
//  void update() {
//    if (x>width || x<0) {
//      x=0;
//    } else {
//      x=x+random(-(width/200), (width/200));
//    }
//    if (y>height|| x<0) {
//      y=0;
//    } else {
//      y=y+random(0, (height/50));
//    }
//  }
//
//  void display() {
//    noStroke();
//    fill(random(150, 255), random(150, 255), random(150, 255), a);
//    float s = random(0, 1);
//
//    float r=random(10, 30);
//    if (!clicked) {
//      ellipse(x, y, r, r);
//    } else {
//      rect(x, y, r, r);
//    }
//
//    for (int i = balls.length-1; i > 2; i--) {
//      stroke(255, 255, 255, a);
//      if (!clicked) {
//        curve(balls[i].x, balls[i].y, balls[i-1].x, balls[i-1].y, balls[i-2].x, balls[i-2].y, balls[i-3].x, balls[i-3].y);
//      } else {
//        line(balls[i].x, balls[i].y, balls[i-1].x, balls[i-1].y);
//        line(balls[i-1].x, balls[i-1].y, balls[i-2].x, balls[i-2].y);
//        line(balls[i-2].x, balls[i-2].y, balls[i-3].x, balls[i-3].y);
//      }
//    }
//  }
//}

