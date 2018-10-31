abstract class Player {
  PVector playerPos;
  PVector playerSize;
  PVector playerVel;
  SimpleGame game;
  int score = 0;
  float maxVel = 8;
  
  public Player(SimpleGame g) {
    game = g;
    playerPos = new PVector(random(100)+200,940);
    playerSize = new PVector(40,60);
    playerVel = new PVector();
  }
  
  void move(MovingDir dir) {
    switch(dir) {
      case LEFT:
        playerVel.add(-2,0);
        if(playerVel.x < (-maxVel)) {
          playerVel.set(-maxVel,0);
        }
        break;
    case RIGHT:
      playerVel.add(2,0);
      if(playerVel.x > maxVel) {
        playerVel.set(maxVel,0);
      }
      break;
    case STAY:
      if(playerVel.x < 0) {
        playerVel.add(2,0);
      }
      if(playerVel.x > 0) {
        playerVel.add(-2,0);
      }
      break;
    }
    if(playerPos.x < -10) {
      playerPos.set(1270, playerPos.y);
    }
    else if(playerPos.x > 1280) {
      playerPos.set(-10, playerPos.y);
    }
    playerPos.add(playerVel);
  }
  
  
  void logic() {
  }

  void display() {
    fill(#0A089D);
    rect(playerPos.x,playerPos.y,playerSize.x,playerSize.y);
  }
  
  void displayScore() {
    fill(0);
    textSize(32);
    text("Score: "+ score, 1070, 40);
    fill(#F7ED1E);
    ellipse(1250,26,30,30);
  }
    
}
