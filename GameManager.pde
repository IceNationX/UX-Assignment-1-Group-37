// In GameManager.java tab

class GameManager {
  
  ArrayList<PhysicsObject> objects;
  ArrayList<Goal> goals; 
  PhysicsObject draggedObject = null;
  int currentLevel;
  boolean gameOver = false;
  
  GameManager() {
    objects = new ArrayList<PhysicsObject>();
    goals = new ArrayList<Goal>();
    currentLevel = 1;
    loadLevel(currentLevel);
  }
  
  // UPDATED UPDATE METHOD
  void update() {
    if (gameOver) return;

    for (PhysicsObject obj : objects) {
      // ONLY apply physics if the object is NOT locked and NOT being dragged
      if (!obj.isLocked && obj != draggedObject) {
        obj.applyForce(gravity);
        obj.update();
        obj.checkEdges();
      }
    }
    checkWinCondition();
  }
  
  void display() {
    for (Goal g : goals) {
      g.display();
    }
    for (PhysicsObject obj : objects) {
      obj.display();
    }
    
    if (gameOver) {
      fill(0, 200, 0);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("LEVEL COMPLETE!", width / 2, height / 2);
      textSize(24);
      text("Press any key for the next level.", width/2, height/2 + 50);
    }
  }
  
  // UPDATED WIN CONDITION LOGIC
  void checkWinCondition() {
    // 1. Reset all goal and object states
    for (Goal g : goals) {
      g.isSatisfied = false;
    }
    for (PhysicsObject obj : objects) {
      if (obj != draggedObject) { // Don't unlock the one we are dragging
         obj.isLocked = false;
      }
    }

    // 2. Check for new locks
    for (Goal g : goals) {
      for (PhysicsObject obj : objects) {
        if (obj.isLocked) continue; // Skip objects already locked to a goal

        if (obj.shapeType == g.requiredShapeType) {
          if (obj.position.x > g.position.x && obj.position.x < g.position.x + g.w &&
              obj.position.y > g.position.y && obj.position.y < g.position.y + g.h) {
            
            // This is the fix! We lock the object.
            g.isSatisfied = true;
            obj.isLocked = true;
            obj.velocity.set(0, 0); // Stop all motion
            
            // Snap it to the center of the goal
            obj.position.x = g.position.x + g.w / 2;
            obj.position.y = g.position.y + g.h / 2;
            
            break; // This goal is done, stop checking
          }
        }
      }
    }

    // 3. Check if all goals are satisfied
    boolean allGoalsSatisfied = true;
    for (Goal g : goals) {
      if (!g.isSatisfied) {
        allGoalsSatisfied = false;
        break;
      }
    }

    if (allGoalsSatisfied) {
      gameOver = true;
    }
  }
  
  // No changes to loadLevel or nextLevel
  void loadLevel(int level) {
    objects.clear();
    goals.clear(); 
    gameOver = false;
    currentLevel = level;
    
    if (level == 1) {
      objects.add(new PhysicsObject(100, 100, 0));
      goals.add(new Goal(600, 400, 0));
    } else if (level == 2) {
      objects.add(new PhysicsObject(100, 100, 0));
      objects.add(new PhysicsObject(200, 100, 1));
      goals.add(new Goal(600, 400, 0)); 
      goals.add(new Goal(700, 400, 1)); 
    } else if (level == 3) {
      objects.add(new PhysicsObject(100, 100, 0));
      objects.add(new PhysicsObject(200, 100, 0));
      objects.add(new PhysicsObject(150, 50, 1));
      goals.add(new Goal(550, 400, 0));
      goals.add(new Goal(650, 400, 0));
      goals.add(new Goal(600, 300, 1));
    }
  }
  
  void nextLevel() {
    if (currentLevel < 3) {
      currentLevel++;
    } else {
      currentLevel = 1;
    }
    loadLevel(currentLevel);
  }
  
  // UPDATED MOUSE PRESSED
  void handleMousePressed() {
    if (gameOver) return;
    for (int i = objects.size() - 1; i >= 0; i--) {
      PhysicsObject obj = objects.get(i);
      if (mouseX > obj.position.x - obj.w/2 && mouseX < obj.position.x + obj.w/2 &&
          mouseY > obj.position.y - obj.h/2 && mouseY < obj.position.y + obj.h/2) {
        draggedObject = obj;
        obj.isLocked = false; // We must unlock it to drag it
        break;
      }
    }
  }
  
  void handleMouseDragged() {
    if (draggedObject != null) {
      draggedObject.position.x = mouseX;
      draggedObject.position.y = mouseY;
      draggedObject.velocity.set(0, 0);
    }
  }
  
  void handleMouseReleased() {
    draggedObject = null;
  }
}
