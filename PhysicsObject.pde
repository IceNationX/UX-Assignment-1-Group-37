

class PhysicsObject {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float w, h;
  int shapeType; 
  
  boolean isLocked = false; // NEW: Added a lock property

  PhysicsObject(float x, float y, int type) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0); 
    shapeType = type;
    w = 40;
    h = 40;
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() { // adds gravity for the shapes to fall in an updated velocity
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void checkEdges() { // check collisions and then reverse the velocity upwards which creates the movement
    if (position.y + h / 2 > height) {
      position.y = height - h / 2;
      velocity.y *= -0.8;
    }
  }

  // UPDATED DISPLAY METHOD
  void display() {
    stroke(0);
    
    // We set the mode we need, right when we need it.
    if (shapeType == 0) {
      fill(100, 150, 250); // Blue
      rectMode(CENTER);
      rect(position.x, position.y, w, h);
    } else if (shapeType == 1) {
      fill(250, 150, 100); // Orange
      ellipseMode(CENTER);
      ellipse(position.x, position.y, w, h);
    }
  }
}
