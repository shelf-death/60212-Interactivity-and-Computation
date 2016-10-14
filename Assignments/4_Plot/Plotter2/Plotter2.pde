import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;
import processing.pdf.*;

PeasyCam cam;
boolean savePDF;

//Array of Node objects, where paths are drawn to.
ArrayList<Node> nodes = new ArrayList<Node>();
//Array of Path objects, which holds paths to be drawn.
ArrayList<Path> paths = new ArrayList<Path>();

int numNodes = 100;
int subWide = 60;
int subTall = 60;

float minDist;
float nearestX,nearestY,nearestZ;

float margin = 30;
float jitter = 10;
float rad = 100;
float ns = 0.2;
/////////////////////////////SETUP//////////////////////////
void setup(){
  //Visual Things
  size(900,600,P3D);
  pixelDensity(2);
  stroke(30);
  strokeWeight(0.7);
  noFill();
  rectMode(CORNERS);
  ellipseMode(CENTER);
  //camera things
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(150);
  cam.setMaximumDistance(400);
  
  //Generate Nodes
  for (int i = 0; i < numNodes; i++){
    Node n = new Node(map(noise(i*ns),0,1,0,rad),
    random(0,2*PI),
    map(i,0,numNodes,0,PI*2));
    nodes.add(n);
  }//end nodes loop
  println("Nodes: "+nodes.size());
  
  //Generate Paths
  for (int col = 0; col < subWide; col++){
    for (int row = 0; row < subTall; row++){
      minDist = 99999999;
      float cRad = rad;
      float cTheta = map(row,0,subWide,0,PI*2);
      float cPhi = map(col,0,subTall,0,PI*2);
      float cx = cRad*sin(cTheta)*cos(cPhi);
      float cy = cRad*sin(cTheta)*sin(cPhi);
      float cz = cRad*cos(cTheta);
      for (int i = 0; i < nodes.size(); i++){
        //If the distance between current XY and Node XY is new minimum
        float distance = dist(cx,cy,cz,nodes.get(i).pos.x,nodes.get(i).pos.y,nodes.get(i).pos.z);
        if ( distance < minDist){
        //Set new minimum and record x,y
        minDist = distance;
        nearestX = nodes.get(i).pos.x;
        nearestY = nodes.get(i).pos.y;
        nearestZ = nodes.get(i).pos.z;
        }//end if distance check
      }//end distance loop
      //Create new path from cx,cy to nearX,nearY
      Path p = new Path(cx,cy,cz,nearestX,nearestY,nearestZ);
      paths.add(p);
    }//end row
  }//end col
  println("Paths: "+paths.size());
} // end setup
/////////////////////////////DRAW//////////////////////////
void draw(){
  background(255);
  if (savePDF == true){
    beginRaw(PDF, "export.pdf");
  }
  
  beginShape();
  //Iterate over path array drawing lines
  for (int p = 0; p < paths.size(); p++){
    //curveVertex(paths.get(p).start.x,paths.get(p).start.y,paths.get(p).start.z);
    curveVertex(paths.get(p).end.x,paths.get(p).end.y,paths.get(p).end.z);
  }//end line loop
  endShape();
  
  
  if (savePDF == true){
  endRaw();
  savePDF = false;
  }
}//end draw
/////////////////////////////KEYPRESSED//////////////////////////
void keyPressed() { if (key == 'p') { savePDF = true; }
}//end keypressed
/////////////////////////////NODE//////////////////////////
class Node {
  PVector pos;
  //Constructor
  Node (float r, float theta, float phi){
    pos = new PVector(r*sin(theta)*cos(phi),r*sin(theta)*sin(phi),r*cos(theta));
  }
}//end node class
/////////////////////////////PATH//////////////////////////
class Path {
  PVector start,end;
  float distance;
  //Constructor
  Path (float sx, float sy, float sz, float ex, float ey, float ez){
    start = new PVector(sx, sy, sz);
    end = new PVector (ex,ey, ez);
    distance = dist(sx, sy, sz,ex,ey, ez);
  }
}//end path class