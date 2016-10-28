import rita.*;

void setup(){
size(300,300);

RiWordNet wordnet = new RiWordNet("/wn");


String[] test = wordnet.getSynonyms("ugly", "adj");

println( test[0] );




}//end setup