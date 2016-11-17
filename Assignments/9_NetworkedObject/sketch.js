var eu = [7,9]; 																									//Euclidian Rhythm
var d = Math.floor(eu[1]/eu[0]);  								//Divisor
var r = eu[1]%eu[0];  																				//Remainder
if (eu[0] > (eu[1]/2)) { r = eu[1]-eu[0]}	//If the value doesn't divide once, remainder is difference
var beat = [];																												//The beat array
var shift = 0;

function setup() {

  for (var i = 0; i < eu[0]; i++){
  	
  	beat.push(1); 																									//initialize with beats
  	
  	if (d > 1) {
	  	for (var j = 0; j < d-1; j++ ){
	  		beat.push(0); 																							//adds d-1 rests after every beat
	  		console.log(j);
	  	}																																					//end inner for
  	}																																						//end d > 1
  	
  	if (i < r){ 
  		beat.push(0);																								 //add extra rest on remainders
  	} 											
  	
  }																																							//end for
  rotateArray(beat,shift);
  console.log(beat);
} 																																								//end setup

function draw() {
  
}

///////////////////Rotate array function//////////////////
function rotateArray(arr, count){
		for (var i = 0; i < count; i++){
					arr.unshift(arr.pop());
		}
 	return arr;
} 																																							//end rotate array