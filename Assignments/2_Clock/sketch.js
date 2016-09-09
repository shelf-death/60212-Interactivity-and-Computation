var w = 400;
var h = 400;

var numParticles = 100;
var pStep = 1;
var particleArray = [];

var sec, prevSec;

/////////////////////////////////SETUP/////////////////////////

function setup() {

	createCanvas(w, h);
	t = new Tree(width/2,height/2);
 sec = second();
	prevSec = sec;
	
}
/////////////////////////////////DRAW//////////////////////////
function draw() {
	background(0);
	
	sec = second();
	if (prevSec != sec) {
		prevSec = sec;
		p = new Particle(width/2,0);
		particleArray.push(p);
		println(particleArray.length);
	}

	for (var i = 0; i < particleArray.length; i++) {
		particleArray[i].update();
		particleArray[i].collide(t);
		if (particleArray[i].collided == true){
			particleArray.splice(i, 1);
		}
		particleArray[i].display();
	}
} //end of draw


//Particle Object
function Particle(x, y) {
	this.pos = createVector(x, y);
	this.diameter = 3;
	this.collided = false;
	// this.acc = acc;

	this.update = function() {
		this.pos.x += round(random(-1, 1)) * pStep;
		
		if (this.pos.y <= height*0.5){
		this.pos.y += round(random(0, 1)) * pStep;
		}
		else {this.pos.y += round(random(0, -1)) * pStep;}
	}; //end update method

	this.display = function() {
			fill(255);
			ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
		} //end particle display method
		
		this.collide = function(tree) {
			for (var i = 0; i < tree.nodes.length; i++) {
				if ( dist(this.pos.x,this.pos.y,tree.nodes[i].x,tree.nodes[i].y) <= this.diameter) {
					this.collided = true;
					tree.nodes.push(createVector(this.pos.x,this.pos.Y));
				}//end distance check
			}//end for loop
		}//end particle collide method

} //end of particle object

//Tree Object
function Tree(startX,startY){
	this.nodes = [createVector(startX, startY)];

this.display = function() {
			fill(255);
			ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
}//end tree display

}//end of tree object




//////