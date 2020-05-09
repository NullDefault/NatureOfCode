import java.util.*;

class Node{
  Node parent;
  Node child_A;
  Node child_B;
  PVector loc;
  int depth;
  int r = 6;
  
  Node(Node _p, PVector _l, int _d){
    parent = _p;
    loc = _l;
    depth = _d;
    child_A = null; child_B = null;
  }
  
  void addChild(Node n){
    if(child_A == null){
      child_A = n;
    }else{
      child_B = n;
    }
  }
  
  void removeChild(Node n){
    if(child_A == n){
      child_A = null;
    }else{
      child_B = null;
    }
  }
  
  void display(){
    if(child_A != null){
        line(loc.x, loc.y, child_A.loc.x, child_A.loc.y);
    }
    if(child_B != null){
        line(loc.x, loc.y, child_B.loc.x, child_B.loc.y);
    }
    ellipse(loc.x, loc.y, r, r);
  }
  
  
}

ArrayList<Node> nodes;
ArrayList<Node> edgeNodes;
Node root;
Random rand = new Random();

Node pickRandomEdgeNode(){
  int high = edgeNodes.size();
  int pick = rand.nextInt(high);
  return edgeNodes.get(pick);
}

boolean is_node_valid(PVector k){
  for(Node n: nodes){
    if(n.loc.dist(k) <= n.r){
      return false;
    }
  }
  return true;
}

PVector fail = new PVector(-13, -37);

PVector make_loc(Node n, PVector used_loc){
  PVector k = null;
  boolean done = false;
  int attempt = 0;
  int dist = n.r * 2;
  while(!done){
    attempt++;
    k = new PVector(n.loc.x + random(-dist * attempt, dist * attempt), 
                                     n.loc.y + random(-dist * attempt, dist * attempt));
    done = is_node_valid(k);
    if(used_loc != null){
      if(k.dist(used_loc) <= n.r){
        done = false;
      }
    }
    if(attempt >= 3){
      return fail; // This is a dummy PVector we use to symbolize that no valid location was found
    }
  }
  return k;
}

int getMaxPathDepth(Node n){
  if(n.child_A == null){
    return n.depth;
  }else{
    int a_depth = getMaxPathDepth(n.child_A);
    int b_depth = getMaxPathDepth(n.child_B);
    if(a_depth > b_depth){
      return a_depth;
    }else{
      return b_depth;
    }
  }
}


boolean growNode(Node n){
  edgeNodes.remove(n);
  int new_depth = n.depth+1;
  
  PVector loc_a = make_loc(n, null);
  if(loc_a == fail){
    return false;
  } 
  PVector loc_b = make_loc(n, loc_a);
  if(loc_b == fail){
    return false;
  }
  
  Node a = new Node(n, loc_a, new_depth);
  Node b = new Node(n, loc_b, new_depth);
  
  n.addChild(a); n.addChild(b);
  nodes.add(a); nodes.add(b);
  edgeNodes.add(a); edgeNodes.add(b);
  return true;
}


void setup(){
  size(1000, 1000);
  
  nodes = new ArrayList<Node>();
  edgeNodes = new ArrayList<Node>();
  root = new Node(null, new PVector(width/2, height/2), 0);
  nodes.add(root);
  
  edgeNodes.add(root);
}

void draw(){
  background(255);
  for(Node n: nodes){
    int pathMaxDepth = getMaxPathDepth(n);
    int g = int(map(n.depth, 0, pathMaxDepth, 0, 255));
    fill(0, g, 0);
    if(edgeNodes.contains(n)){
      strokeWeight(3);
      stroke(255, 0, 0);
    }else{
      strokeWeight(0);
      stroke(0);
    }
    n.display();
  }
  
  boolean new_node_created = false;
  
  while(!new_node_created){
    Node nextNode = pickRandomEdgeNode();
    new_node_created = growNode(nextNode);
  }
}
