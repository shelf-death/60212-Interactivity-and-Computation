var w = 400;
var h = 400;

var numParticles = 100;
var pStep = 30;
var particleArray = [];
var myTree;

var sec, prevSec;

/////////////////////////////////SETUP/////////////////////////

function setup() {

  frameRate(15);
  createCanvas(w, h);
  myTree = new Tree(width / 10, height / 10, 0);
  sec = second();
  prevSec = sec;


}
/////////////////////////////////DRAW//////////////////////////
function draw() {
  background(240);

  sec = second();
  if (prevSec != sec) {
    prevSec = sec;
    p = new Particle(width / 2, 0);
    particleArray.push(p);
  }

  for (var i = 0; i < particleArray.length; i++) {
    particleArray[i].update();
    particleArray[i].collide(myTree);
    particleArray[i].display();
    if (particleArray[i].collided === true) {
      println("collide");
      myTree.nodes.push(createVector(particleArray[i].pos.x, particleArray[i].pos.y));
      particleArray.splice(i, 1);
    }
  }

  myTree.display();

} //end of draw


//////////////////////////////////////////Particle Object///////////////////////////////////
function Particle(x, y) {
  this.pos = createVector(x, y);
  this.diameter = 20;
  this.collided = false;
  // this.acc = acc;

  ///////////////////////////
  this.update = function() {

    this.pos.x += random(-1, 1) * pStep;
    this.pos.y += random(-0.9, 1) * pStep;

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
  this.diameter = 20;

  ///////////////////////////
  this.display = function() {
      for (var i = 0; i < this.nodes.length; i++) {
        this.nodes[i] = rotateAngle(random(100,150),random(100,150),this.nodes[i].x, this.nodes[i].y,1);
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