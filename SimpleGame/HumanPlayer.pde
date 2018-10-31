class HumanPlayer extends Player {
  
  public HumanPlayer(SimpleGame game) {
    super(game);
  }
  
  @Override
  void logic() {
    if (keyPressed == true) {
      if(key == 'a' || key == 'A') {
        move(MovingDir.LEFT);
      } else if(key == 'd' || key == 'D') {
        move(MovingDir.RIGHT);
      }
    } else {
      move(MovingDir.STAY);
    }
  }
}
