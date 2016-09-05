var w = 400;
var h = 400;
var lineArray = [];
var numLines = 10;
var magnitude = w / 3; //length of line

function setup() {

	createLines();
	createCanvas(w, h);
}

function draw() {
	background('#facade');
	translate(w / 2, h / 2); //center viewport


	//Render Lines
	stroke('#bae');
	strokeWeight(3);
	var len = lineArray.length;
	for (var i = 0; i < len; i++) {
		push();
		translate(lineArray[i][1].x/2, lineArray[i][1].y/2);
		line(0, 0, lineArray[i][0].x, lineArray[i][0].y);
		pop();
	}
}

function createLines() {
	//Create Lines
	for (i = 0; i < numLines; i++) {
		var lineStart = p5.Vector.random2D(); //rand3D start vector
		lineStart.setMag(magnitude);
		var lineEnd = p5.Vector.random2D(); //rand3D end vector
		lineEnd.setMag(magnitude);
		var newLine = [lineStart, lineEnd];
		lineArray.push(newLine);
	}
}