class Neuron{
  PVector renderLocation;
  float r = 64;
  float sum = 0;  
  
  ArrayList<Synapse> synapses;
  
  Neuron(float x, float y){
    synapses = new ArrayList<Synapse>();
    renderLocation = new PVector(x, y);
  }
  
  void connectSynapse(Synapse s){
    synapses.add(s);
  }
  
  void feedForward(float input){
    sum = sum + input;
    activationFunction();
  }
  
  void activationFunction(){
    if(sum > 1){
      fire();
      sum = 0;  
    }
  }
  
  void fire(){
    for(Synapse s: synapses){
      s.feedForward(sum);
    }
  }
  
  void render(){
    for(Synapse s: synapses){
      s.update();
      s.display();
    }
    stroke(0);
    fill(0);
    ellipse(renderLocation.x, renderLocation.y, r, r);
  }

}

class NNetwork{
  ArrayList<Neuron> neurons;
  PVector location;
  
  NNetwork(float x, float y){
    location = new PVector(x, y);
    neurons = new ArrayList<Neuron>();  
  }
  
  void addNeuron(Neuron n){
    neurons.add(n);
  }
  
  void connectNeurons(Neuron a, Neuron b){
    Synapse s = new Synapse(a, b, random(1));
    a.connectSynapse(s);
  }
  
  void feedForward(float input){
    Neuron start = neurons.get(0);
    start.feedForward(input);
  }
    
  void display(){
    pushMatrix();
    translate(location.x, location.y);
    for(Neuron n: neurons){
      n.render();
    }
    popMatrix();
  }
}

class Synapse{
  Neuron x;
  Neuron y;
  float weight;
  
  boolean sending = false;
  PVector sender;
  float output;
  
  Synapse(Neuron from, Neuron to, float w){
    weight = w;
    x = from;
    y = to;
  }
  
  void feedForward(float val){
    sending = true;
    sender = x.renderLocation.get();
    output = val*weight;
  }
  
  void update(){
    if (sending){
      sender.x = lerp(sender.x, y.renderLocation.x, 0.1);
      sender.y = lerp(sender.y, y.renderLocation.y, 0.1);
      
      float d = PVector.dist(sender, y.renderLocation);
      
      if (d < 1){
        y.feedForward(output);
        sending = false;
      }
    }
  }
    
  void display(){
    stroke(0);
    strokeWeight(1+weight*4);
    line(x.renderLocation.x, 
         x.renderLocation.y,
         y.renderLocation.x,
         y.renderLocation.y);
         
    if(sending){
      fill(175);
      strokeWeight(1);
      ellipse(sender.x, sender.y, 64, 64);
    }
  }
}


NNetwork net;

void setup(){
  size(1000, 800);
  net = new NNetwork(width/2, height/2);
  
  Neuron a = new Neuron(-400, 0);
  Neuron b = new Neuron(0, 200);
  Neuron c = new Neuron(0, -200);
  Neuron d = new Neuron(400, 0);
  
  net.addNeuron(a);
  net.addNeuron(b);
  net.addNeuron(c);
  net.addNeuron(d);
  
  net.connectNeurons(a,b);
  net.connectNeurons(a,c);
  net.connectNeurons(b,d);
  net.connectNeurons(c,d);
  
  net.feedForward(random(1));
}

void draw(){
  background(255);
  net.display();
  if(frameCount % 30 == 0){
    net.feedForward(random(1));
  }
}
