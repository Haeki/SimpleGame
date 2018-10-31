class Coin{
  PVector pos;
  ArrayList<Player> players;
  SimpleGame game;
  
  boolean logic() {
   pos.add(0, game.coinSpeed);
   if (pos.y > 1024) {
     return false;
   } else {
     if(pos.y > 900) {
       for(int i = 0; i < players.size(); i++) {
         Player p = players.get(i);
         if(circleRect(p.playerPos, p.playerSize, pos, 15)) {
           p.score++;
           players.remove(i);
           //println(score);
           //coins.remove(i);
         }
       }
     }
     if(players.size() <= 0) {
       return false;
     }
   }
   return true;
  }
  
  void display() {
    fill(#F7ED1E);
    ellipse(pos.x,pos.y,30,30);
  }
  
  public Coin(SimpleGame game, PVector pos, ArrayList<Player> p) {
    this.game = game;
    this.pos = pos;
    players = p;
  }
  
  PVector getPos() {
    return pos;
  }
}
