//functional
PVector[][] lineArray = new PVector[0][];
int numLines = 20;          //number of lines
float magnitude = 533 / 2;      //maximum length of line
int minMag = 4;              //magnitude / minMag minimum distance
ArrayList<PVector> intersectionArray = new ArrayList<PVector>();

//aesthetics
int weight = 1;
color lColor = color(255,255,255);         //line color
int intSize = 10;           //size of intersection markers
////////////////////////////////SETUP//////////////////////////////////////////////
void setup() {
  size(533, 300);
  //lineArray = new PVector[0][];
  createLines();
}

////////////////////////////////DRAW/////////////////////////////////////////////
void draw() {
  background(color(187,170,238));        // always bae <3
  translate(width / 2, height / 2);   //center viewport
  intersectionArray = new ArrayList<PVector>();    //reset Intersections each frame
  
  int len = lineArray.length;
  for (int i = 0; i < len; i++) {
    
    //Render Lines
    stroke(lColor);
    strokeWeight(weight);
    line(lineArray[i][0].x, lineArray[i][0].y,lineArray[i][1].x,lineArray[i][1].y);
    
    lineArray[i][0].x += random(-1,1);        //wiggle wiggle wiggle
    lineArray[i][0].y += random(-1,1);
    lineArray[i][1].x += random(-1,1);
    lineArray[i][1].y += random(-1,1);
    
    if (i < len){                             //if you're not the last line, check for intersections
      for (int l = i; l < len; l++) {         //only check lines 'after' you
      intersect(lineArray[i],lineArray[l]);
      }
    }
  }
  //Render Intersections
  len = intersectionArray.size();
  for (int i = 0; i < len; i++) {
    noStroke();
    fill(250,128,114,150);
    ellipse(intersectionArray.get(i).x,intersectionArray.get(i).y,intSize,intSize);
  }
}//end draw

////////////////////////////////CREATE LINES///////////////////////////////////////////
void createLines() {
  //Create Lines
  lineArray = new PVector[numLines][];
  intersectionArray = new ArrayList<PVector>();
  for (int i = 0; i < numLines; i++) {
    PVector lineStart = PVector.random2D(); //rand3D start vector
    lineStart.setMag(random(magnitude/minMag,magnitude));

    PVector lineEnd = PVector.random2D(); //rand3D end vector
    lineEnd.setMag(random(magnitude/minMag,magnitude));
    
    PVector[] newLine = new PVector[] {lineStart, lineEnd};
    lineArray[i] = newLine;
  }
}

//////////////////////////////////INTERSECT///////////////////////////////////////////
void intersect(PVector[] line1,PVector[] line2){
  
  float x1 = line1[0].x;
  float x2 = line1[1].x;
  float x3 = line2[0].x;
  float x4 = line2[1].x;
  
  float y1 = line1[0].y;
  float y2 = line1[1].y;
  float y3 = line2[0].y;
  float y4 = line2[1].y;
  
  float denom = ( (y4 - y3) * (x2 -x1) - (x4 - x3) * (y2 - y1) );
  float ua = ( (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3) ) / denom;
  float ub = ( (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3) ) / denom;
  
  float intX = x1 + ua*(x2-x1);
  float intY = y1 + ua*(y2-y1);
  
  if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1){
    PVector intersection = new PVector(intX,intY);
    intersectionArray.add(intersection);
  }
}

////////////////////////////////MOUSE PRESSED/////////////////////////////////
void mousePressed() {
  intersectionArray = new ArrayList<PVector>();
  createLines();
}