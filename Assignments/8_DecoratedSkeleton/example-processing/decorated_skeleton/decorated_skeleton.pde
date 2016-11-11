import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

//Camera and Physics Objects
PeasyCam cam;

BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;

public void setup()
{
  //println("cats");
  size( 1280, 720, P3D );
  background( 0 );
  noStroke();
  frameRate( 30 );
  
  PVector skeleScale = new PVector (-1,-1,-1);
  
  //PeasyCam
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  cam.setDistance(500);
  cam.lookAt(0,-100,0);

  bvh1 = new PBvh( loadStrings( "A_test.bvh") , skeleScale );
  //bvh2 = new PBvh( loadStrings( "B_test.bvh" ) );
  //bvh3 = new PBvh( loadStrings( "C_test.bvh" ) );
  
  bvh1.draw();
  
  for (int i = 0; i < bvh1.rawJointPositions.size(); i+=1){
   }//end bone for loop
   
  loop();
} // end setup loop

public void draw()
{
  background( 0 );

  //ground 
  fill( color( 255 ));
  stroke(127);
  //line(width/2.0f, height/2.0f, -30, width/2.0f, height/2.0f, 30);
  stroke(127);
  //line(width/2.0f-30, height/2.0f, 0, width/2.0f + 30, height/2.0f, 0);
  stroke(255);

  pushMatrix();
  //translate(0, 0, -400);
  //scale(-1, -1, -1);

  //model
  bvh1.update( millis() );
  //bvh2.update( millis() );
  //bvh3.update( millis() );
  
  bvh1.draw();
  //bvh2.draw();
  //bvh3.draw();
  
  popMatrix();
} //end draw loop