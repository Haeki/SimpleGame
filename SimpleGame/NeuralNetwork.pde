class NeuralNetwork {
 
  ArrayList<NeuralNode> inputNodes = new ArrayList();
  ArrayList<NeuralNode> outputNodes = new ArrayList();
  ArrayList<NeuralConnection> connections = new ArrayList();
  ArrayList<ArrayList<NeuralNode>> network = new ArrayList(); //replace with TreeList?
  int nodeNum = 0;
  NeuralNode biasNode;
  
  public NeuralNetwork(String[] inputs, String[] outputs) {
    biasNode = new NeuralNode(nodeNum, "Bias");
    nodeNum++;
    
    for(String la : inputs) {
      NeuralNode in = new NeuralNode(nodeNum, la);
      inputNodes.add(in);
      nodeNum++;
    }
    network.add(inputNodes);
    
    for(String la : outputs) {
      outputNodes.add(new NeuralNode(nodeNum, la));
      nodeNum++;
    }
    network.add(outputNodes);
  }
  
  float[] process(float[] ins) {
     if(ins.length != inputNodes.size()) {
       return null;
     }
     biasNode.feedForward(1);
     for(int i = 0; i < inputNodes.size(); i++) {
       inputNodes.get(i).feedForward(ins[i]);
     }
     for(int i = 1; i < network.size(); i++) {
       for(NeuralNode nn : network.get(i)) {
         nn.feedForward();
       }
     }
     float[] output = new float[outputNodes.size()];
     for(int i = 0; i < outputNodes.size(); i++) {
       output[i] = outputNodes.get(i).output;
     }
     return output;
  }
  
  boolean fullyConnected() {
   int maxConnections = 0;
   for (int i = 0; i < network.size()-1; i++) {
     int nodesInFront = 0;
     for (int j = i+1; j < network.size(); j++) {
       nodesInFront += network.get(j).size();//add up nodes
     }
     maxConnections += network.get(i).size() * nodesInFront;
    }
    return maxConnections == network.size();
  }
  
  NodeLayerTuple getNode(int index) {
    if(index <= 0) {
      return new NodeLayerTuple(biasNode, 0);
    }
    index--;
    for(int i = 0; i < network.size(); i++) {
       ArrayList<NeuralNode> layer = network.get(i);
       if(index >= layer.size()) {
         index -= layer.size();
         continue;
       } else {
         return new NodeLayerTuple(layer.get(index), i);
       }
    }
    return null;
  }
  
  void addConnection() {
    if (fullyConnected()) {
      println("connection failed because network is fully connected");
      return;
    }
    NodeLayerTuple randomNode1; 
    NodeLayerTuple randomNode2;
    while(true) {
      randomNode1 = getNode(floor(random(nodeNum)));
      randomNode2 = getNode(floor(random(nodeNum)));
      if(nodesAreOkForConnection(randomNode1, randomNode2)) {
        break;
      } 
    }
    
    NeuralNode node1;
    NeuralNode node2;
    if(randomNode1.layer > randomNode2.layer) {
      node1 = randomNode2.nn;
      node2 = randomNode1.nn;
    } else {
      node1 = randomNode1.nn;
      node2 = randomNode2.nn;
    }
    
    NeuralConnection con = new NeuralConnection(node1, node2, random(-1,1));
    connections.add(con);
    node1.addConnection(con);
  }
  
  void addNode() {
    //pick a random connection to create a node between
    if (connections.size() ==0) {
      addConnection(); 
      return;
    }
    NeuralConnection randomConnection = connections.get(floor(random(connections.size())));

    while (randomConnection.fromNode == biasNode && connections.size() !=1 ) {//dont disconnect bias
      randomConnection = connections.get(floor(random(connections.size())));
    }

    randomConnection.enabled = false;
    
    NodeLayerTuple nlt1 = getNode(randomConnection.fromNode.number);
    NodeLayerTuple nlt2 = getNode(randomConnection.toNode.number);
    NeuralNode n = new NeuralNode(nodeNum);
    nodeNum++;
    if((nlt2.layer - nlt1.layer) > 1) {
      network.get(nlt1.layer + 1).add(n);
    } else {
      ArrayList<NeuralNode> newLayer = new ArrayList();
      newLayer.add(n);
      network.add(nlt2.layer, newLayer); 
    }

    NeuralConnection con1 = new NeuralConnection(nlt1.nn, n, 1);
    connections.add(con1);
    nlt1.nn.addConnection(con1);

    NeuralConnection con2 = new NeuralConnection(n, nlt2.nn, randomConnection.weight);
    connections.add(con2);
    n.addConnection(con2);
  }
  
  
  boolean nodesAreOkForConnection(NodeLayerTuple node1, NodeLayerTuple node2) {
    if(node1.layer == node2.layer) {
      return false;
    }
    if(node1.nn.isConnectedTo(node2.nn)) {
      return false;
    }
    return true;
  }
  
  void mutate() {
    if (connections.size() ==0) {
      addConnection();
    }

    float rand1 = random(1);
    if (rand1<0.8) { // 80% of the time mutate weights
      for (int i = 0; i< connections.size(); i++) {
        connections.get(i).mutateWeight();
      }
    }
    //5% of the time add a new connection
    float rand2 = random(1);
    if (rand2<0.08) {
      addConnection();
    }


    //1% of the time add a node
    float rand3 = random(1);
    if (rand3<0.02) {
      addNode();
    }
  }
  
}
