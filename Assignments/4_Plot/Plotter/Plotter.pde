//Array of Node objects, where paths are drawn to.
ArrayList<Node> nodes = new ArrayList<Node>();
//Array of Path objects, which holds paths to be drawn.
ArrayList<Path> paths = new ArrayList<Path>();

int numNodes = 100;
int subWide = 100;
int subTall = 100;

float minDist;
float nearestX,nearestY;

float margin = 30;
float jitter = 10;
//Note to self: instead of doing this on a grid, 
//consider generating points using poisson disc

//Add margin when you can
//Also this is dope: http://matsysdesign.com/tag/parametric/

/////////////////////////////SETUP//////////////////////////
void setup(){
  //Visual Things
  size(600,400);
  strokeWeight(1.0);
  rectMode(CORNERS);
  
  //Generate Nodes
  for (int i = 0; i < numNodes; i++){
    Node n = new Node(random(0+margin,width-margin),random(0+margin,height-margin));
    nodes.add(n);
  }//end nodes loop
  println("Nodes: "+nodes.size());
  
  //Generate Paths
  for (int col = 0; col < subTall; col++){
    for (int row = 0; row < subWide; row++){
      minDist = width*3;
      float cx = (row * ((width - margin) / subWide) + margin/2);
      float cy = ((col * (height - margin) / subTall) + margin/2);
      for (int i = 0; i < nodes.size(); i++){
        //If the distance between current XY and Node XY is new minimum
        float distance = dist(cx,cy,nodes.get(i).pos.x,nodes.get(i).pos.y);
        if ( distance < minDist){
        //Set new minimum and record x,y
        minDist = distance;
        nearestX = nodes.get(i).pos.x;
        nearestY = nodes.get(i).pos.y;
        }//end if distance check
      }//end distance loop
      //Create new path from cx,cy to nearX,nearY
      Path p = new Path(cx,cy,nearestX,nearestY);
      paths.add(p);
    }//end row
  }//end col
  println("Paths: "+paths.size());

} // end setup

/////////////////////////////DRAW//////////////////////////
void draw(){
  background(255);
  //Iterate over path array drawing lines
  for (int p = 0; p < paths.size(); p++){
    rect(paths.get(p).start.x,paths.get(p).start.y,
    paths.get(p).end.x,paths.get(p).end.y);
    line(paths.get(p).start.x,paths.get(p).start.y,
    paths.get(p).end.x,paths.get(p).end.y);
  }//end line loop
}//end draw
/////////////////////////////NODE//////////////////////////
class Node {
  PVector pos;
  //Constructor
  Node (float x, float y){
    pos = new PVector(x,y);
  }
}
/////////////////////////////PATH//////////////////////////
class Path {
  PVector start,end;
  //Constructor
  Path (float sx, float sy, float ex, float ey){
    start = new PVector(sx, sy);
    end = new PVector (ex,ey);
  }
}