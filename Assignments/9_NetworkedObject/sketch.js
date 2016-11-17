var eu = [6,10];																										//Euclidian Rhythm
var d = Math.floor(eu[1]/eu[0]);  								//Divisor
var r = eu[1]%eu[0];  																				//Remainder
if (eu[0] > (eu[1]/2)) { r = eu[1]-eu[0]}	//If the value doesn't divide once, remainder is difference
var beat = [];																												//The beat array
var shift = 0;

var mySound, myPhrase, myPart;

var notes =  ["c","d","e","f","g","a","b"];
var noteScale = [72, 74, 76, 77, 79, 81, 83]; // 48 is base note
var currentNote = 0;
var currentNote2 = 0;


var list = []; 
var s = "golan levin is lit af af af studio of creative inquiry"
///////////////////////////////////Preload/////////////////////////////////////////
function preload() {
  
}
///////////////////////////////////Setup/////////////////////////////////////////
function setup() {
	
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
	// osc.start();
	frameRate(8);
	
	osc2 = new p5.Oscillator('sine');
	osc2.start();
	
	calculateEuclid(eu,beat,shift);
	textToBeat(s,notes,list);
	
	
	// myPart.start();
}//end setup

///////////////////////////////////Draw///////////////////////////////////////////
function draw() {
  background(0);
  
  freq = midiToFreq(list[currentNote]);
  freq2 = midiToFreq(beat[currentNote2])
  osc.freq(freq);
  osc2.freq(freq2);
  currentNote++;
  currentNote2++;
  if (currentNote >= list.length){
    currentNote = 0;
  }
  if (currentNote2 >= beat.length){
    currentNote2 = 0;
  }
  
}//end draw
///////////////////////////////////makeSound///////////////////////////////////////////
function makeSound(time, playbackRate) {
  mySound.rate(playbackRate);
  mySound.play(time);
}

///////////////////////////////////textToBeat///////////////////////////////////////////
function textToBeat(words,noteList,melody) {
	for (var i = 0; i<words.length; i++){
    for (var j = 0; j<noteList.length; j++){
      if (words[i] == noteList[j]){
        melody.push(noteScale[j]);
      }
    }
    if (melody[i] != 1){
      melody.push(melody[i-1]); //base note    
    }
  }
  console.log(melody);
}
///////////////////////Calculate Euclidian Rhythms///////////////////////////
function calculateEuclid(euclid,beatArray,shiftAmt) {
  for (var i = 0; i < euclid[0]; i++){
  	
  	beatArray.push(60); 																									//initialize with beats
  	
  	if (d > 1) {
	  	for (var j = 0; j < d-1; j++ ){
	  		beatArray.push(0); 																							//adds d-1 rests after every beat
	  	}																																										//end inner for
  	}																																											//end d > 1
  	
  	if (i < r){ 
  		beatArray.push(0);																								 //add extra rest on remainders
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