import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

PeasyCam cam;

float count = 4000;
////////////////////////SETUP//////////////////////
void setup() {
  //Settings Things
  size(400, 400, P3D);
  smooth(64);
  frameRate(60);
  colorMode(HSB,120,120,120);
  rectMode(CENTER);
  sphereDetail(3);
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/5, width/height, cameraZ/10.0, cameraZ*10.0);
  //camera things
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1);
}
/////////////////////////DRAW//////////////////////
void draw() {
  //Refresh stuff
  //background(255);
  fill(0);
  pushMatrix();
  translate(0,0,-3000);
  rect(0,0,100000000,100000000);
  popMatrix();
  lights();
  
  noFill();
  strokeWeight(1);

  for (int i = 0; i < count; i++){
    //float h = abs((((frameCount+i+00)%120)-60)*2);
    float h = abs((((frameCount+(i*sin(abs((((frameCount+i+00)%120)-60)*2)/100.0)+1))%120)-60)*2);
    float s = abs((((frameCount+(i*sin(abs((((frameCount+i+40)%120)-60)*2)/200.0)+1))%120)-60)*2);
    float b = abs((((frameCount+(i*sin(abs((((frameCount+i+80)%120)-60)*2)/300.0)+1))%120)-60)*2);
    stroke(0,0,h);
    //stroke(100);
    pushMatrix();
    //(i*sin(abs((((frameCount+i+00)%120)-60)*2)/100.0)+1)
    rotateZ(-radians(i+frameCount%240.0*360.0/240.0));
    //rotateZ((i/10.0*sin(abs((((frameCount+i+00)%120.0)-60)*2.0)/700.0)+1.0));
    translate(0,0,-i/3.0);
    //translate((i/10.0*sin(abs((((frameCount+i+00)%120.0)-60)*2.0)/800.0)+1.0),0,0);
    //rotateY((i/10.0*sin(abs((((frameCount+i+00)%120.0)-60)*2.0)/800.0)+1.0));
    
    //rotateX(-radians(i+frameCount%40.0*360.0/40.0));
    rect(0,0,50-(i+1)*0.02,50-(i+1)*0.02);
    popMatrix();
  }
  
  //if (frameCount < 121){
  //saveFrame("gif-3/######.png");
  //}
  //else{
  //exit();
  //}//end saveframe stuff
}//end draw