//functional
var w = 400;                //canvas width
var h = 400;                //canvas height
var lineArray = [];
var numLines = 20;          //number of lines
var magnitude = w / 2;      //maximum length of line
var minMag = 4              //magnitude / minMag minimum distance
var intersectionArray = [];

//aesthetics
var weight = 1;
var lColor = '#fff'         //line color
var intSize = 10;           //size of intersection markers
////////////////////////////////SETUP//////////////////////////////////////////////
function setup() {
	createLines();
	createCanvas(w, h);
}

////////////////////////////////DRAW/////////////////////////////////////////////
function draw() {
	background('#bae');        // always bae <3
	translate(w / 2, h / 2);   //center viewport
	intersectionArray = [];    //reset Intersections each frame
  
	var len = lineArray.length;
	for (var i = 0; i < len; i++) {
	  
	  //Render Lines
	  stroke(lColor);
	  strokeWeight(weight);
		line(lineArray[i][0].x, lineArray[i][0].y,lineArray[i][1].x,lineArray[i][1].y);
		
		lineArray[i][0].x += random(-1,1);        //wiggle wiggle wiggle
		lineArray[i][0].y += random(-1,1);
		lineArray[i][1].x += random(-1,1);
		lineArray[i][1].y += random(-1,1);
		
		if (i < len){                             //if you're not the last line, check for intersections
		  for (var l = i; l < len; l++) {         //only check lines 'after' you
		  intersect(lineArray[i],lineArray[l]);
		  }
		}
	}
	//Render Intersections
	len = intersectionArray.length;
	for (i = 0; i < len; i++) {
	  noStroke();
	  fill(250,128,114,150);
		ellipse(intersectionArray[i].x,intersectionArray[i].y,intSize,intSize);
	}
}

////////////////////////////////CREATE LINES///////////////////////////////////////////
function createLines() {
	//Create Lines
	lineArray = [];
	intersectionArray=[];
	for (i = 0; i < numLines; i++) {
		var lineStart = p5.Vector.random2D(); //rand3D start vector
		lineStart.setMag(random(magnitude/minMag,magnitude));
		var lineEnd = p5.Vector.random2D(); //rand3D end vector
		lineEnd.setMag(random(magnitude/minMag,magnitude));
		var newLine = [lineStart, lineEnd];
		lineArray.push(newLine);
	}
}

//////////////////////////////////INTERSECT///////////////////////////////////////////
function intersect(line1,line2){
  
  var x1 = line1[0].x;
  var x2 = line1[1].x;
  var x3 = line2[0].x;
  var x4 = line2[1].x;
  
  var y1 = line1[0].y;
  var y2 = line1[1].y;
  var y3 = line2[0].y;
  var y4 = line2[1].y;
  
  var denom = ( (y4 - y3) * (x2 -x1) - (x4 - x3) * (y2 - y1) );
  var ua = ( (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3) ) / denom;
  var ub = ( (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3) ) / denom;
  
  var intX = x1 + ua*(x2-x1);
  var intY = y1 + ua*(y2-y1);
  
  if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1){
    var intersection = createVector([intX],[intY]);
    intersectionArray.push(intersection);
  }
}

////////////////////////////////MOUSE PRESSED/////////////////////////////////
function mousePressed() {
  intersectionArray=[];
  createLines();
}