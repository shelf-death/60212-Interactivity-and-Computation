var w = 800;
var h = 800;
var margin = w/8;

var numParticles = 100;
var pStep = w/100;
var di = w/100; //diameter of particles
var particleArray = [];
var millisRolloverTime;
var myTree;

var sec, prevSec;

/////////////////////////////////SETUP/////////////////////////

function setup() {

  frameRate(100);
  createCanvas(w, h);
  myTree = new Tree(width / 2, height / 2, 0);
  sec = second();
  prevSec = sec;
  millisRollovertime = 0;
  
  //initialize with current minutes particles
  for (var i = 0; i < minute(); i++) {
    p = new Particle(random(width/8*3,width/8*5),random(height/8*3,height/8*5));
    particleArray.push(p);
  }
  println("initialized with "+particleArray.length);


}
/////////////////////////////////DRAW//////////////////////////
function draw() {
  // background(200);
  noStroke();

  var subSec = floor(millis() - millisRolloverTime) / 1000.0;

  var x = map( cos( map( sec+subSec,0,60,0,2*PI) ),-1,1,margin,width-margin );
  var y = map( sin( map( sec+subSec,0,60,0,2*PI) ),-1,1,margin,height-margin );
  
  sec = second(); //this MUST come after x y calculations
  
  
  //Time Stuff
  if (prevSec != sec) {
    millisRolloverTime = millis();
    prevSec = sec;
    p = new Particle(x, y);
    particleArray.push(p);
    println(hour()+':'+minute()+':'+sec);
  }

  for (var i = 0; i < particleArray.length; i++) {
    particleArray[i].update();
    particleArray[i].collide(myTree);
    particleArray[i].display();
    if (particleArray[i].collided === true) {
      println("collided");
      myTree.nodes.push(createVector(particleArray[i].pos.x, particleArray[i].pos.y));
      particleArray.splice(i, 1);
    }
  }
  
  

  
  myTree.display();

  
  //draw indicator circle
  fill(0);
  ellipse(x,y,di*8,di*8);

} //end of draw


//////////////////////////////////////////Particle Object///////////////////////////////////
function Particle(x, y) {
  this.pos = createVector(x, y);
  this.diameter = di;
  this.collided = false;
  // this.acc = acc;

  ///////////////////////////
  this.update = function() {

    this.pos.x += random(-1, 1) * pStep;
    this.pos.y += random(-1, 1) * pStep;

    //check bounds
    if (this.pos.x <= 0) {
      this.pos.x = 0
    }
    if (this.pos.x >= width) {
      this.pos.x = width
    }
    if (this.pos.y <= 0) {
      this.pos.y = 0
    }
    if (this.pos.y >= height) {
      this.pos.y = height
    }

  }; //end update method

  ////////////////////////////
  this.display = function() {
      fill(255);
      ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
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
        // this.nodes[i] = rotateAngle(random(100,150),random(100,150),this.nodes[i].x, this.nodes[i].y,1);
        fill(0, 0, 0);
        ellipse(this.nodes[i].x, this.nodes[i].y, this.diameter, this.diameter);
      } //end for loop
    } //end tree display method
} //end of tree object


function rotateAngle (pivotX,pivotY,pointX,pointY,angle) {

        var sine = sin(radians(angle));
        var cosine = cos(radians(angle));
        
        pointX = map(pointX - pivotX,0,width,0,1);
        pointY = map(pointY - pivotY,0,height,0,1);

        var xNew = pointX * cosine - pointY * sine;
        var yNew = pointX * sine - pointY * cosine;
        
        
        var newPoint = createVector (xNew + pivotX,yNew + pivotY);
        return newPoint;
    } //end rotateAngle



//////