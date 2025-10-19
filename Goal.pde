// In Goal.java tab

class Goal {
  
  PVector position;
  float w, h;
  int requiredShapeType; 
  boolean isSatisfied = false;

  Goal(float x, float y, int type) {
    position = new PVector(x, y);
    w = 60;
    h = 60;
    requiredShapeType = type;
  }

  // UPDATED DISPLAY METHOD
  void display() {
    noFill();
    strokeWeight(3);
    
    if (isSatisfied) {
      stroke(100, 255, 100); // Bright green
    } else {
      stroke(0, 200, 0); // Normal green
    }
    
    // We set BOTH modes every time to prevent bugs
    rectMode(CORNER);
    ellipseMode(CORNER);
    
    if (requiredShapeType == 0) {
      rect(position.x, position.y, w, h);
    } else if (requiredShapeType == 1) {
      ellipse(position.x, position.y, w, h);
    }
  }
}
