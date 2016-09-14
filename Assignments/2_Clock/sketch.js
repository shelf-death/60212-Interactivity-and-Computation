var w = 200;
var h = 200;
var margin = w/8;

var numParticles = 100;
var pStep = w/200;
var di = w/200; //diameter of particles
var particleArray = [];
var orbArray = [];
var millisRolloverTime;
var myTree;

var sec, prevSec, subsec, cHour;

/////////////////////////////////SETUP/////////////////////////

function setup() {
  rectMode(CENTER);
  frameRate(60);
  createCanvas(w, h);
  myTree = new Tree(width / 2, height / 2, 0);
  sec = second();
  prevSec = sec;
  millisRollovertime = 0;
  
  //colors
  tFill = color(30);
  oFill = color(30);
  
  //initialize with current minutes particles
  for (var i = 0; i < minute()*60; i++) {
    p = new Particle(random(margin,width-margin),random(margin,height-margin));
    particleArray.push(p);
  }
  println("initialized with "+particleArray.length);
  
  //make orbs for hours
  for (var j = 0; j < 23; j++) {
    o = new Orb(width/2,height/2,j);
    orbArray.push(o);
  }

}
/////////////////////////////////DRAW//////////////////////////
function draw() {
  // background(200);
  noStroke();

  subSec = floor(millis() - millisRolloverTime) / 1000.0;

  //Calculation for where 'front' of orbs is, which is where particles are added
  var x = map( cos( map( sec+subSec,0,60,0,2*PI) ),-1,1,margin,width-margin );
  var y = map( sin( map( sec+subSec,0,60,0,2*PI) ),-1,1,margin,height-margin );
  
  for (var o = 0; o < orbArray.length; o++) {
    orbArray[o].update(); //update first
  }
  
  sec = second(); //this MUST come after x y calculations
  cHour = hour();
  if (cHour > 12){ cHour -= 12;}
  if (cHour === 0){ cHour = 12;}
  
  
  //Add a new particle every "tick" of a second
  if (prevSec != sec) {
    millisRolloverTime = millis();
    prevSec = sec;
    p = new Particle(x, y);
    particleArray.push(p);
    println(hour()+':'+minute()+':'+sec);
  }

  //Iterate over particle array, moving them, checking for collision with tree, then drawing them
  for (var i = 0; i < particleArray.length; i++) {
    particleArray[i].update();
    particleArray[i].collide(myTree);
    if (particleArray[i].collided === true) {
      println("collided");
      myTree.nodes.push(createVector(particleArray[i].pos.x, particleArray[i].pos.y));
      particleArray.splice(i, 1);
    }
    particleArray[i].display();
  }
  
  //Render nodes of the DLA tree
  myTree.display();
  
  //Render number of orbs based on hour
  for (var h = 0; h < hour(); h++) {
    orbArray[h].display(); //update first
  }
} //end of draw


//////////////////////////////////////////Particle Object///////////////////////////////////
function Particle(x, y) {
  this.pos = createVector(x, y);
  this.diameter = di;
  this.collided = false;

  ///////////////////////////
  this.update = function() {
    
    //drunk walk particles
    this.pos.x += random(-1, 1) * pStep;
    this.pos.y += random(-1, 1) * pStep;

    //check bounds of particles against canvas
    if (this.pos.x <= 0) { this.pos.x = 0 }
    if (this.pos.x >= width) { this.pos.x = width }
    if (this.pos.y <= 0) { this.pos.y = 0 }
    if (this.pos.y >= height) { this.pos.y = height }

  }; //end particle update method

  ////////////////////////////
  this.display = function() {
      fill(255);
      rect(this.pos.x, this.pos.y, this.diameter, this.diameter);
    } //end particle display method

  ////////////////////////////////		
  this.collide = function(tree) {
      for (var i = 0; i < tree.nodes.length; i++) {
        if (dist(this.pos.x, this.pos.y, tree.nodes[i].x, tree.nodes[i].y) <= this.diameter) {
          this.collided = true;
        } //end distance check
      } //end for loop
    } //end particle collide method
} //end of particle object

///////////////////////////////////////////////Tree Object////////////////////////////////////
function Tree(startX, startY, rot) {
  this.nodes = [createVector(startX, startY)];
  this.diameter = di;

  ///////////////////////////
  this.display = function() {
      for (var i = 0; i < this.nodes.length; i++) {
        fill(tFill);
        rect(this.nodes[i].x, this.nodes[i].y, this.diameter, this.diameter);
      } //end for loop
    } //end tree display method
} //end of tree object

///////////////////////////////////////////////Orb Object////////////////////////////////////
function Orb(x,y,id) {
  this.pos = [createVector(x, y)];
  this.diameter = di*12;
  this.id = id;
  
  this.update = function() {
    //calculate the position of each orb using unit circle rotation over minute, divided by how many orbs
    this.pos.x =  map( cos( map( sec+subSec,0,60,0,2*PI)-radians(this.id*360/cHour)),-1,1,margin,width-margin );
    this.pos.y =  map( sin( map( sec+subSec,0,60,0,2*PI)-radians(this.id*360/cHour)),-1,1,margin,height-margin );
  }//end orb update method

  ///////////////////////////
  this.display = function() {
      fill(oFill);
      ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
    } //end orb display method
} //end of orb object

//////