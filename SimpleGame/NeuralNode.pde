class NeuralNode {
 int number;
 String label;
 ArrayList<NeuralConnection> connections = new ArrayList();
 float inputSum = 0;
 float output;
 
  public NeuralNode(int num, String l) {
   number = num;
   label = l;
 }
 
 public NeuralNode(int num) {
   this(num, "" + num);
 }
 
 void feedForward(float val) {
  for(NeuralConnection nc : connections) {
    if(nc.enabled) {
      nc.toNode.inputSum +=nc.weight * val;
    }
  }
 }
 
 void feedForward() {
   output = leakyReLu(inputSum);
   feedForward(output);
   inputSum = 0;
 }
 
 boolean isConnectedTo(NeuralNode node) {
   for (int i = 0; i < node.connections.size(); i++) {
     if (node.connections.get(i).toNode == this) {
       return true;
     }
   }
   for (int i = 0; i < connections.size(); i++) {
     if (connections.get(i).toNode == node) {
       return true;
     }
   }
   return false;
 }
 
 float sigmoid(float x) {
    float y = 1 / (1 + pow((float)Math.E, -4.9*x));
    return y;
  }
  
  float leakyReLu(float x) {
    if(x>0) {
      return x;
    } else {
      return 0.001 * x;
    }
  }

  void addConnection(NeuralConnection nc) {
    connections.add(nc);
  }   
  
}
