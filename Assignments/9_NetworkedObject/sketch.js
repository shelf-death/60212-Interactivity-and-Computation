var eu = [1,1];	 																									//Euclidian Rhythm
var d = Math.floor(eu[1]/eu[0]);  								//Divisor
var r = eu[1]%eu[0];  																				//Remainder
if (eu[0] > (eu[1]/2)) { r = eu[1]-eu[0]}	//If the value doesn't divide once, remainder is difference
var beat = [];																												//The beat array
var shift = 0;

var mySound, myPhrase, myPart;

var freq =  				//relative to c3 = 1
[0.8409143032,		//a
0.943888082,				//b
1.000000000,				//c
1.122467701,				//d
1.259918966,			 //e
1.334836786,				//f
1.498356395]; 		//gN

var list = []; 
var s = "sick beats bro";
var notes = ["a","b","c","d","e","f","g"];

///////////////////////////////////Preload/////////////////////////////////////////
function preload() {
  mySound = loadSound('assets/beatbox.mp3');
}
///////////////////////////////////Setup/////////////////////////////////////////
function setup() {
	
	masterVolume(0.1);
	myPhrase = new p5.Phrase('bbox', makeSound, list);
 myPart = new p5.Part();
 myPart.addPhrase(myPhrase);
 myPart.setBPM(60);
	
	calculateEuclid(eu,beat,shift);
	textToBeat(s,notes,list);
	
	
	// myPart.start();
}//end setup

///////////////////////////////////Draw///////////////////////////////////////////
function draw() {
  background(0);
}//end draw


function mouseClicked() {
  if (1) {
    myPart.start();
    msg = 'playing pattern';
  }
}

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
        melody.push(freq[j]);
      }
    }
    if (melody[i] != 1){
      melody.push(0);    
    }
  }
  console.log(melody);
}
///////////////////////Calculate Euclidian Rhythms///////////////////////////
function calculateEuclid(euclid,beatArray,shiftAmt) {
  for (var i = 0; i < euclid[0]; i++){
  	
  	beatArray.push(1); 																									//initialize with beats
  	
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