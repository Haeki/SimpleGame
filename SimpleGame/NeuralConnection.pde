class NeuralConnection {
  NeuralNode toNode;
  NeuralNode fromNode;
  float weight;
  boolean enabled = true;
  
  public NeuralConnection(NeuralNode from, NeuralNode to, float w) {
   fromNode = from;
   toNode = to;
   weight = w;
    
  }
  
  void mutateWeight() {
    float rand2 = random(1);
    if (rand2 < 0.1) {//10% of the time completely change the weight
      weight = random(-1, 1);
    } else {//otherwise slightly change it
      weight += randomGaussian()/50;
      //keep weight between bounds
      if(weight > 1) {
        weight = 1;
      }
      if(weight < -1) {
        weight = -1;
      }
    }
    
  }
  
}
