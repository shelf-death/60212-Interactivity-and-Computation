//
//
//
//
var wordCount = 0;	//total wordcount
var sText; 			//Source Text
var joinedText;		//text array joined into single string
var words;			//tokenized words
var lineArray = [];	//Array of all lines of text

//for keeping references to index for swapping
var randLine,randWord,firstWord;

/////////////////////////Preload/////////////////////
function preload() {
	sText = loadStrings('texts/stevens.txt');
	lexicon = new RiLexicon();
}//end preload

//////////////////////////Setup//////////////////////
function setup() {
	createCanvas(600,600);
	background(230);

	for (var i = 0; i < sText.length; i++){
		words = RiTa.tokenize(sText[i],' ');
		lineArray[i] = words;

		wordCount += words.length;
	}//end for loop

	console.log(wordCount);
	console.log(lineArray);

	getSimilarSound(wordCount*2);
	// getRhymes(wordCount/3);
	reBuildText();
	
}//end setup

///////////////////Get Similar Sound//////////////////
function getSimilarSound(num) {
	for (var i = 0; i < num; i++){
		randLine = int(random(lineArray.length));
		randWord = int(random(lineArray[randLine].length));
		firstWord = lineArray[randLine][randWord];

		var similarSound = lexicon.similarBySound(firstWord);

		if (similarSound.length > 0){
		lineArray[randLine][randWord] = similarSound[0];
		console.log(firstWord);
		console.log(similarSound[0]);
		}//end if
		else{i-=1}
	}//end num loop
}//end Similar Sound function

///////////////////Get Rhymes//////////////////
function getRhymes(num) {
	for (var i = 0; i < num; i++){
		randLine = int(random(lineArray.length));
		randWord = int(random(lineArray[randLine].length));
		firstWord = lineArray[randLine][randWord];

		var rhymes = lexicon.rhymes(firstWord);

		if (rhymes.length > 0){
		lineArray[randLine][randWord] = rhymes[0];
		console.log(firstWord);
		console.log(rhymes[0]);
		}//end if
		else{i-=1}
	}//end num loop
}//end Similar Sound function

///////////////////Rebuild Text//////////////////
function reBuildText() {
	for (var i = 0; i < lineArray.length; i++){
		lineArray[i] = lineArray[i].join(' ');
		console.log(lineArray[i]);
		text(lineArray[i], 10,i*15+30,500,500);
	}
}//end rebuild text
