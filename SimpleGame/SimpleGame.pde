
ArrayList<Coin> coins;
int cooldown;
int cooldownVal;
float coinSpeed;
int coinsSpawned = 0;
ArrayList<Player> players;

void setup() {
   size(1280, 1024);
   coins = new ArrayList();
   cooldownVal = 120;
   cooldown = cooldownVal;
   coinSpeed = 2;
   players = new ArrayList();
   players.add(new HumanPlayer(this));
   players.add(new NeuralNetworkPlayer(this));
}



boolean circleRect(PVector rectPos, PVector rectSize, PVector circlePos, float radius) {
  float testX = circlePos.x;
  float testY = circlePos.y;

  if (circlePos.x < rectPos.x) {
    testX = rectPos.x;
  } else if (circlePos.x > rectPos.x+rectSize.x) {
    testX = rectPos.x+rectSize.x;
  }
  if (circlePos.y < rectPos.y) {         
    testY = rectPos.y;
  } else if (circlePos.y > rectPos.y+rectSize.y) {
    testY = rectPos.y+rectSize.y;
  }

  float distX = circlePos.x-testX;
  float distY = circlePos.y-testY;
  float distance = (distX*distX) + (distY*distY);
  if (distance <= (radius*radius)) {
    return true;
  }
  return false;
}

void coinLogic() {
 if(cooldown <= 0) {
   coins.add(new Coin(this, new PVector(random(1250)+20, 0),(ArrayList<Player>) players.clone()));
   coinsSpawned++;
   cooldownVal = (1/coinsSpawned) * 250 + 70;
   cooldown = cooldownVal;
   coinSpeed+=1/coinsSpawned;
 } else {
   cooldown--;
 }
 for (int i = coins.size() - 1; i >= 0; i--) {
   Coin c = coins.get(i);
   if(c.logic()) {
     c.display();
   } else {
     coins.remove(i);
   }
 }
}

void draw() {
  background(#FFFFFF);
  fill(#289D08);
  rect(-1,1000,1281,24);
  for(Player p : players) {
    p.logic();
    p.display();
  }
  coinLogic();

}
