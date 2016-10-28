var wNet = require('./wordnetjs');
//
//
//
//
var wordCount = 0;	//total wordcount
var sText; 			//Source Text
var joinedText;		//text array joined into single string
var oneLine;		//nlp object
var lineArray = [];	//Array of all lines of text

//NlP Compromise
var nlp = window.nlp_compromise;

//for keeping references to index for swapping
var randLine,randWord,firstWord;

/////////////////////////Preload/////////////////////
function preload() {
	sText = loadStrings('texts/rose.txt');
}//end preload

//////////////////////////Setup//////////////////////
function setup() {
	createCanvas(600,600);
	background(230);

	for (var i = 0; i < sText.length; i++){
		oneLine = nlp.sentence(sText[i]);

    negateLine(sText[i]);
		
		lineArray[i] = oneLine;

	}//end for loop

	// getSimilarSound(10);
	// getRhymes(50);
	reBuildText();
	
}//end setup

///////////////////Reconjugate verbs//////////////////
function negateLine(theLine) {
  oneLine = nlp.statement(theLine).negate();
}

///////////////////Reconjugate verbs//////////////////
function reconjugate() {
  for (var t = 0; t < oneLine.terms.length; t++) {
			var part = oneLine.terms[t].pos;
			var oneTerm = oneLine.terms[t];
			if (part.Verb){
				oneLine.terms[t].text = 
				nlp.verb(
				  oneTerm.text.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"")
				  ).conjugate().present;
			}
		}//end for loop
}//endpluralize line

///////////////////Pluralize Line//////////////////
function pluralizeLine() {
  for (var t = 0; t < oneLine.terms.length; t++) {
			var part = oneLine.terms[t].pos;
			var oneTerm = oneLine.terms[t];
			if (part.Noun && !part.Pronoun){
				oneLine.terms[t].text = nlp.noun(oneTerm.text).pluralize();
			}
		}//end for loop
}//endpluralize line

///////////////////Rebuild Text//////////////////
function reBuildText() {
	for (var i = 0; i < lineArray.length; i++){
		console.log(lineArray[i].str);
		text(lineArray[i].text(), 10,i*15+30,500,500);
	}
}//end rebuild text
