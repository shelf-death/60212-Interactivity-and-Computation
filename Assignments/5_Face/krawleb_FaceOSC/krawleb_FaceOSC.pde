import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import oscP5.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;
//A list of claw arms units
ArrayList<Claw> claws;

//Initialize OSC object
OscP5 oscP5;

//declare new crane
Crane crane;

// face boolean and raw data array
int found;
float[] rawArray;

//which point is selected
int highlighted;

//Mouth open boolean
boolean mouthOpen;
float jawThreshhold = 0.5;

//Did you win
boolean youWin = false;
PFont proxima;


////////////////////////////////////////////////////////////////////
void setup() {
  size(960, 720);
  frameRate(60);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "rawData", "/raw");
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -30);
  
  //Create Arraylists 
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  claws = new ArrayList<Claw>();
  
  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/2,height-10,width-20,10));
  
  //add a collection box
  boundaries.add(new Boundary(width/8-45,height-180,10,50)); //left
  boundaries.add(new Boundary(width/8-5,height-150,90,10)); //bottom
  boundaries.add(new Boundary(width/8 + 35,height-180,10,50)); //right
  
  //create our crane object
  crane = new Crane();
  
  //loadfont
  proxima = createFont("data/ProximaNova-Black.otf",150);
  textFont(proxima);
}//end setup

///////////////////////////////////DRAW/////////////////////////////////
void draw() {  
  background(255);
  noStroke();
  
  //Box2D Step
  box2d.step();
  
  //Check mouth
  isMouthOpen();
  
  
  //Draw Objects
  if (rawArray!=null) {
    
    if ( found > 0 ) {
    for (int val = 0; val < rawArray.length -1; val+=2){
      //if (val == highlighted){ fill(255,0,0);}
      //else{fill(100);}
      fill(240);
      noStroke();
      ellipse(rawArray[val], rawArray[val+1],10,10); 
    }//end points array loop
    
    //GUI AND DEBUGGING
    //debugging();
    }//end face found check
    
    crane.update();
    crane.drawCrane();
    
  }//end rawArray length check
  
  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }//end boundary draw
  
  // Display all the boxes
  for (Box b: boxes) {
    b.display();
    didYouWin(b);
  }//end box draw
  
  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  
  //Display the cord
  crane.cord.display();
  
  // Display all the claws
  for (int i = 0; i < claws.size(); i++) {
    claws.get(i).display();
  }//end claw draw
  
  if (youWin == true){
    textAlign(CENTER);
    textSize(100);
    text("YOU WIN!",width/2,height/2);
  }
    
}//end Draw

///////////////////////////////Crane Class//////////////////////////////////
class Crane {
  Float glideSpeed = 0.02;
  PVector pulley,cross,base;
  Float baseWidth = width*0.05;
  Float baseHeight = height*0.9;
  Float crossWidth = width*0.875;
  Float crossHeight = height*0.04;
  Float pulleyWidth = 50.0;
  Float pulleyHeight = 50.0; 
  Bridge cord;
  Crane(){
  pulley = new PVector (width/2,height/2);
  cross = new PVector (width*0.1,height*0.5);
  base = new PVector(width*0.9,height*0.1);
  //length , number , anchorX, anchorY
  cord = new Bridge(width/5,width/40,pulley.x,pulley.y);
  }
  //update method
  void update(){
  //update crossbar with top of nose Y value
  cross.y = cross.y - (cross.y - rawArray[55])*glideSpeed;
  //update pulley with top of nose X value
  pulley.x = (pulley.x - (pulley.x - rawArray[54])*glideSpeed);
  //update pulley Y with same as crossbar
  pulley.y = cross.y;
  //update the cord position
  Vec2 pulleyWorld = new Vec2(box2d.coordPixelsToWorld(pulley));
  Vec2 anchorVec = cord.particles.get(0).body.getPosition();
  cord.particles.get(0).body.setLinearVelocity(new Vec2(
  (pulleyWorld.x-anchorVec.x)*8,
  (pulleyWorld.y-anchorVec.y)*8));
  
  }
  
  //drawCrane method
  void drawCrane(){
    //stroke(0);
    noStroke();
    fill(0);
    rectMode(CORNER);
    
    //Base
    rect(base.x,base.y,baseWidth,baseHeight);
    
    //Crossbar
    rect(cross.x,cross.y,crossWidth,crossHeight);
    
    //Pulley
    rectMode(CENTER);
    rect(pulley.x,pulley.y,pulleyWidth,pulleyHeight);
    
    //Claws drawn in draw loop
  }
}//end crane class

//////////////////////////////Did You Win/////////////////////////////
void didYouWin(Box box) {
  Vec2 boxPos = new Vec2 (box2d.getBodyPixelCoord(box.body));
  if ( boxPos.x > width/8-35 && boxPos.x < width/8 + 35 && boxPos.y > height-180 && boxPos.y < height - 130){
  youWin = true;
  }
}
//////////////////////////////Create New Box/////////////////////////////
void newBoxes() {
    Box p = new Box(crane.pulley.x,height-40);
    boxes.add(p);
}//end new boxes function

//////////////////////////////Is Mouth Open/////////////////////////////
void isMouthOpen() {
  if (dist(rawArray[102],rawArray[103],rawArray[114],rawArray[115]) > dist(rawArray[108],rawArray[109],rawArray[96],rawArray[97])*jawThreshhold){
  mouthOpen = true;
  crane.cord.toggleClaw(mouthOpen);
  //rect(0,200,10,10);
  }
  else{mouthOpen = false; crane.cord.toggleClaw(mouthOpen);}
}

///////////////////////////////Debugging//////////////////////////////////
void debugging() {
   fill(255);
   rect(0,0,160,30);
   fill(0);
   text( "current index = [" + highlighted + "," + int(highlighted + 1) + "]", 10, 20);
}//end debugging function

///////////////////////////////////////MousePressed///////////////
void mousePressed() {
  //crane.cord.toggleClaw();
}
///////////////////////////////KeyPressed//////////////////////////////////
void keyPressed(){
  if (keyCode == RIGHT){
  highlighted = (highlighted + 2) % rawArray.length;
  } //end right key
  if (keyCode == LEFT){
    highlighted = (highlighted - 2);
    if (highlighted < 0){
      highlighted = rawArray.length-1;
    }//end highlighted if
  }//end left key
  if (keyCode == UP){
  newBoxes();
  }
}//emd keypressed
////////////////////////////// OSC CALLBACK FUNCTIONS//////////////////////////////
public void found(int i) {
  println("found: " + i);
  found = i;
}//end found
public void rawData(float[] raw) {
  println("raw data saved to rawArray");
  rawArray = raw;
  for (int i = 0; i < rawArray.length; i++) {
  rawArray[i] *= 1.5;
  if (i%2 == 0){
  rawArray[i] = map(rawArray[i],0,width,width,0);
  }
  }//end for loop
}//end found