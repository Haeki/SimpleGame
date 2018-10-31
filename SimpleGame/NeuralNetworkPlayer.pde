class NeuralNetworkPlayer extends Player {
  NeuralNetwork brain;
  final String[] inputTypes = {"Player Vel", "X Pos", "CoinSpeed", "Coin 1 X", "Coin 1 Y", "Coin 2 X", "Coin 2 Y"};
  final String[] outputTypes = {"None", "Left", "Right"};
  
  public NeuralNetworkPlayer(SimpleGame game) {
    super(game);
    brain = new NeuralNetwork(inputTypes, outputTypes);
  }
  
  @Override
  void logic() {
    float[] inputs = new float[inputTypes.length];
    inputs[0] = playerVel.x;
    inputs[1] = playerPos.x;
    inputs[2] = game.coinSpeed;
    try {
      Coin coin1 = game.coins.get(0);
      inputs[3] = coin1.getPos().x;
      inputs[4] = coin1.getPos().y;
      Coin coin2 = game.coins.get(1);
      inputs[5] = coin2.getPos().x;
      inputs[6] = coin2.getPos().y;
    } catch (IndexOutOfBoundsException e) {
      println(e);
    }
    float[] outs = brain.process(inputs);
    float maxOutVal = 0;
    int outIndex = 0;
    for(int i = 0; i < outputTypes.length; i++) {
       if(outs[i] > maxOutVal) {
         outIndex = i;
       }
    }
    switch(outIndex) {
      case 0:
        move(MovingDir.STAY);
        break;
      case 1:
        move(MovingDir.LEFT);
        break;
      case 2:
        move(MovingDir.RIGHT);
        break;
    }
  }
}
