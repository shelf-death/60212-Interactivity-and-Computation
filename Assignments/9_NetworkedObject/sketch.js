var eu = [3,11];																									//Euclidian Rhythm
var d = Math.floor(eu[1]/eu[0]);  								//Divisor
var r = eu[1]%eu[0];																			//Remainder
if (eu[0] > (eu[1]/2)) { r = eu[1]-eu[0]}	//If the value doesn't divide once, remainder is difference
var beat = [];																											//The beat array
var shift = 0;

var mySound, myPhrase, myPart;

var notes =  ["c","d","e","f","g","a","b"];
var rootNote = 48;
var bassDivider = 1.25;
var noteScale = [rootNote, rootNote+2, rootNote+4, rootNote+5, rootNote+7, rootNote+9, rootNote+11]; // 48 is base note
var currentNote = 0;
var currentNote2 = 0;

var margin = 20;

var list = [];
var s = "This is an intermediate level course in creative coding, interactive new-media art, and computational design. Ideal as a second course for students who have already had one semester of elementary programming (in any language), this course is for you if you’d like to use code to make art, design, architecture, and/or games — AND you’re already fluent in the basics of programming, such as for() loops, if() statements, and arrays.";
///////////////////////////////////Preload/////////////////////////////////////////
function preload() {
  
}
///////////////////////////////////Setup/////////////////////////////////////////
function setup() {

	createCanvas(250,100);
	rectMode(CENTER);
	// noStroke();

	c1 = color(255, 255, 0);
	c2 = color(0, 255, 255);
	
	//Web MIDI Object Check
	// request MIDI access
	if (navigator.requestMIDIAccess) {
	    navigator.requestMIDIAccess({
	        sysex: false // this defaults to 'false' and we won't be covering sysex in this article. 
	    }).then(onMIDISuccess, onMIDIFailure);
	} else {
	    // alert("No MIDI support in your browser.");
	}
	
	// midi functions
	function onMIDISuccess(midiAccess) {
	    // when we get a succesful response, run this code
	    console.log('MIDI Access Object', midiAccess);
	}
	
	function onMIDIFailure(e) {
	    // when we get a failed response, run this code
	    console.log("No access to MIDI devices or your browser doesn't support WebMIDI API. Please use WebMIDIAPIShim " + e);
	}
	////////end of MIDI shit
	
	osc = new p5.Oscillator('triangle');
	osc.start();
	frameRate(10);
	
	osc2 = new p5.Oscillator('sine');
	// osc2.start();
	
	calculateEuclid(eu,beat,shift);
	textToBeat(s,notes,list);
}//end setup

///////////////////////////////////Draw///////////////////////////////////////////
function draw() {
  background(0);
  
  currentNote++;
  currentNote2++;

  if (currentNote >= list.length){
    currentNote = 0;
    // osc.freq(0);
  }
  if (currentNote2 >= beat.length){
    currentNote2 = 0;
  }
  
  freq = midiToFreq(list[currentNote]);
  freq2 = midiToFreq(beat[currentNote2])

  if (list[currentNote] == 0){
  	freq = 0;
  }

  osc.freq(freq);
  osc2.freq(freq2);

  //draw bass beat debugger
  for (var beats = 0; beats < beat.length; beats++) {
  	fill(160);
  	if (beat[beats] == rootNote/bassDivider){fill(60)}
  	if (beats == currentNote2){fill(255)}
  	//bass rect
  	rect(
  		(width-margin/2)/beat.length*beats+margin,
  		height-width/beat.length,width/beat.length,width/beat.length);
  	//melody rect
  	fill(0);
  	var mapped = map(list[currentNote+beats%list.length],noteScale[0],noteScale[6],0,1);
  	fill( lerpColor(c1,c2,mapped));
  	rect(
  		(width-margin/2)/beat.length*beats+margin,
  		height/2-width/beat.length,width/beat.length,width/beat.length);
  }//end visualization for loop


}//end draw
///////////////////////////////////makeSound///////////////////////////////////////////
function makeSound(time, playbackRate) {
  mySound.rate(playbackRate);
  mySound.play(time);
}

///////////////////////////////////textToBeat///////////////////////////////////////////
function textToBeat(words,noteList,melody) {
	for (var i = 0; i<words.length; i++){
		var isItANote = false;
    	for (var j = 0; j<noteList.length; j++){
      		if (words[i] == noteList[j]){
        		melody.push(noteScale[j]);
        		isItANote = true;
      		}
    	}

    	if (isItANote == false){
    		if (words[i] == " "){
    			// melody.push(0);
    			melody.push(melody[i-1]);
    		}
    		else{melody.push(melody[i-1]);} //base note 
    	}
  	}
  console.log(melody);
}
///////////////////////Calculate Euclidian Rhythms///////////////////////////
function calculateEuclid(euclid,beatArray,shiftAmt) {
  for (var i = 0; i < euclid[0]; i++){
  	
  	beatArray.push(rootNote/bassDivider);																						//initialize with beats
  	
  	if (d > 1) {
	  	for (var j = 0; j < d-1; j++ ){
	  		beatArray.push(rootNote/bassDivider-4); 																							//adds d-1 rests after every beat
	  	}																																										//end inner for
  	}																																											//end d > 1
  	
  	if (i < r){ 
  		beatArray.push(rootNote/bassDivider-4);																								 //add extra rest on remainders
  	} 											
  }																																												//end for
  rotateArray(beatArray,shift);
  console.log(beat);
}//end calculate Euclid
/////////////////////////////Rotate array function////////////////////////////
function rotateArray(arr, count){
		for (var i = 0; i < count; i++){
					arr.unshift(arr.pop());
		}
 	return arr;
}//end rotate array