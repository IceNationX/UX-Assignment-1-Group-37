// Global objects
GameManager game;
PVector gravity; // Gravity is a universal force, so it can stay global.

void setup() {
  size(800, 600);

  
  gravity = new PVector(0, 0.2);
  game = new GameManager(); // Create one instance of the game brain.
}

void draw() {
  background(220);
  
  game.update();  // Tell the game to update its state.
  game.display(); // Tell the game to draw everything.
}

// Pass mouse events to the GameManager to handle.
void mousePressed() {
  game.handleMousePressed();
}

void mouseDragged() {
  game.handleMouseDragged();
}

void mouseReleased() {
  game.handleMouseReleased();
}
void keyPressed() {
  // If the game is over, pressing a key will load the next level.
  if (game.gameOver) {
    game.nextLevel();
  }
}
