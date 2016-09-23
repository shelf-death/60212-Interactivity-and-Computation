/////////Sizes Etc./////////
var w = 350;
var h = 350;
var margin = w/20;
var numColumns = 58;
var numRows = 58;
var rowStep = (h-margin*2) / numRows;
var colStep = (w-margin*2) / numColumns;
var x = margin;
var y =margin;

///////////Array/////////////
var lineArray = [];

///////Noise Scaling/////////
var nsRot = w/1000; 																	//rotation scale
var nsRender = w/15000;														//visibility scale
var nsTimeRender = w/20000;										//visibility time scale
var nsTimeRot = w/30000;												 //rotation time scale
var threshhold = 0.33;															//visibility threshhold: if noise > threshhold, render.
var randSeed = 0;																				//random seed to regenerate noise
var std = 40;																							  //standard deviation for roations
var rnd = 10;																							 //round to nearest quantity of

////A E S T H E T I C S/////
var lineScale = 1.2;
var sw = w/500;

/////////////////////////////////////SETUP///////////////////////////////////
function setup() {
	createCanvas( w, h);
	rectMode(CENTER);
	frameRate(30);
	
	//Iterate over grid to populate array
	for ( var r = 0; r < numRows; r++) {
		for ( var c = 0; c < numColumns; c++ ) {
			var l = new LineSegment(x,y);
			lineArray.push(l);
			x += colStep; 																					//increase to make row
		}																																			//end row loop
	x = margin; 																														//reset at end of each row
	y += rowStep; 																							//increase to next column
	}																																				//end column loop
} 																																				//end setup

///////////////////////////////////////DRAW//////////////////////////////////
function draw() {
	background(245);
	
	//Iterate over array, update then display
	for (var i = 0; i < lineArray.length; i++) {
		lineArray[i].update();
		lineArray[i].display();
	}																																				//end lineArray loop
}																																					//end draw

//////////////////////////////////MOUSE CLICKED//////////////////////////////
function mouseClicked(){
	randSeed = random(0,1000000);
	for (var i = 0; i < lineArray.length; i++) {
	lineArray[i].newRotation();
	}
}

/////////////////////////////////LINE SEGMENT OBJECT//////////////////////////
function LineSegment(lx,ly) {
	this.pos = createVector(lx,ly);
	this.rot = radians(int(randomGaussian(0,std)/rnd)*rnd);
	this.visible = 1;
	
	//////////UPDATE//////////
	this.update = function() {
	//Visibility uses 3D perlin noise
	this.visible = noise(this.pos.y*nsRender+randSeed,this.pos.x*nsRender+randSeed,frameCount*nsTimeRender+randSeed);
	}																																				//end update method
	
	////////Re-Rotate////////
	this.newRotation = function() {
		//Gaussian distribution for rotation
		this.rot = radians(int(randomGaussian(0,std)/rnd)*rnd);
	}
	
	//////////DISPLAY//////////
	this.display = function() {
		push();
		translate(this.pos.x,this.pos.y);			//get into the right position
		rotate(this.rot);																			//rotate the correct amount
		strokeWeight(sw);																				//drawing stuff
		noFill();
		stroke(0);
		if (this.visible > threshhold) { 			//only draw if 'visible'
			rect(rowStep/2,rowStep/2,0,rowStep/2+rowStep*lineScale);
		}	//end if	
		pop();
	}																																				//end of display method
}																																					//end of line segment class