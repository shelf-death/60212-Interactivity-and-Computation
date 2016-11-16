import java.util.List;

class PBvh
{
  BvhParser parser;  
  PBvh(String[] data) {
    parser = new BvhParser();
    parser.init();
    parser.parse( data );
  }
  void update( int ms ) {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }
  void drawBones(boolean renderExtras) {
    noFill(); 
    stroke(255); 
    strokeWeight(2);

      List<BvhBone> theBvhBones = parser.getBones();
      int nBones = theBvhBones.size();       // How many bones are there?
      BvhBone aBone;

      /////////MAIN BONE LOOP/////////
      for (int i=0; i<nBones; i++) {         // Loop over all the bones
      
        PVector anchorTranslation = new PVector (0,0,0);
        pushMatrix();
        
        aBone = theBvhBones.get(i);
        
        /////////////////////////////////////////////////////////////////
        //Manual Duplicated adding
        if (aBone.getName().equals("LeftForeArm") && renderExtras == true) {
          aBone.duplicates.add("Head");
          
          stroke(255);
        
          //draw root bone in original position
          line(
            aBone.absPos.x, 
            aBone.absPos.y, 
            aBone.absPos.z, 
            aBone.getChildren().get(0).absPos.x, 
            aBone.getChildren().get(0).absPos.y, 
            aBone.getChildren().get(0).absPos.z);

          // Look through duplicates array, find the matching translation Vectors (where to attach the duplicated limb)
          for (String dupe : aBone.duplicates) {
            for (int l = 0; l < theBvhBones.size(); l++) {
              if (theBvhBones.get(l)._name.equals(dupe))
              {
                //then, save the translation in preparation for drawing duplicate
                anchorTranslation = new PVector(theBvhBones.get(l).absPos.x, theBvhBones.get(l).absPos.y, theBvhBones.get(l).absPos.z);
              }//end if
            }//end the for loop
          }//end for dupe

          BvhBone currentBone = aBone;
          float modifier = 4.0;
          translate(-currentBone.absPos.x,-currentBone.absPos.y,-currentBone.absPos.z);
          while (currentBone.hasChildren()) {
            List<BvhBone> currentChildren = currentBone.getChildren();

            for (int j = 0; j < currentChildren.size(); j++) {
              pushMatrix();
              translate(anchorTranslation.x,anchorTranslation.y,anchorTranslation.z);
              
              line(
                currentBone.absPos.x, 
                currentBone.absPos.y, 
                currentBone.absPos.z, 
                currentChildren.get(j).absPos.x, 
                currentChildren.get(j).absPos.y, 
                currentChildren.get(j).absPos.z);

              println(currentBone);
              println(currentChildren.size());
              println(currentChildren.get(0));
              println("--------");

              List<BvhBone> grandchildren =  currentChildren.get(j).getChildren();

              for (int k = 0; k < grandchildren.size(); k++) {

                //line(
                //  currentChildren.get(j).absEndPos.x*0, 
                //  currentChildren.get(j).absEndPos.y*0, 
                //  currentChildren.get(j).absEndPos.z*0, 
                //  grandchildren.get(0).absPos.x, 
                //  grandchildren.get(0).absPos.y, 
                //  grandchildren.get(0).absPos.z);
              }//end grandchildren for
              popMatrix();
            }//end current children for

            BvhBone nextBone = currentChildren.get(0);
            currentBone = nextBone;
            
          }//end of while loop
        }//end specific bone if
        /////////////////////////////////////////////////////////////////
        
        /////////////////////////////////////////////////////////////////
        //Manual Duplicated adding
        if (aBone.getName().equals("RightForeArm") && renderExtras == true) {
          aBone.duplicates.add("Head");
          
          stroke(255);
        
          //draw root bone in original position
          line(
            aBone.absPos.x, 
            aBone.absPos.y, 
            aBone.absPos.z, 
            aBone.getChildren().get(0).absPos.x, 
            aBone.getChildren().get(0).absPos.y, 
            aBone.getChildren().get(0).absPos.z);

          // Look through duplicates array, find the matching translation Vectors (where to attach the duplicated limb)
          for (String dupe : aBone.duplicates) {
            for (int l = 0; l < theBvhBones.size(); l++) {
              if (theBvhBones.get(l)._name.equals(dupe))
              {
                //then, save the translation in preparation for drawing duplicate
                anchorTranslation = new PVector(theBvhBones.get(l).absPos.x, theBvhBones.get(l).absPos.y, theBvhBones.get(l).absPos.z);
              }//end if
            }//end the for loop
          }//end for dupe

          BvhBone currentBone = aBone;
          float modifier = 4.0;
          translate(-currentBone.absPos.x,-currentBone.absPos.y,-currentBone.absPos.z);
          while (currentBone.hasChildren()) {
            List<BvhBone> currentChildren = currentBone.getChildren();

            for (int j = 0; j < currentChildren.size(); j++) {
              pushMatrix();
              translate(anchorTranslation.x,anchorTranslation.y,anchorTranslation.z);
              
              line(
                currentBone.absPos.x, 
                currentBone.absPos.y, 
                currentBone.absPos.z, 
                currentChildren.get(j).absPos.x, 
                currentChildren.get(j).absPos.y, 
                currentChildren.get(j).absPos.z);

              println(currentBone);
              println(currentChildren.size());
              println(currentChildren.get(0));
              println("--------");

              List<BvhBone> grandchildren =  currentChildren.get(j).getChildren();

              for (int k = 0; k < grandchildren.size(); k++) {

                //line(
                //  currentChildren.get(j).absEndPos.x*0, 
                //  currentChildren.get(j).absEndPos.y*0, 
                //  currentChildren.get(j).absEndPos.z*0, 
                //  grandchildren.get(0).absPos.x, 
                //  grandchildren.get(0).absPos.y, 
                //  grandchildren.get(0).absPos.z);
              }//end grandchildren for
              popMatrix();
            }//end current children for

            BvhBone nextBone = currentChildren.get(0);
            currentBone = nextBone;
            
          }//end of while loop
        }//end specific bone if
        /////////////////////////////////////////////////////////////////

   
        ////////////////////////////////STUFF THAT DRAWS THE ORIGINAL SKELETON/////////////////////////////////

        PVector boneCoord0 = aBone.absPos;   // Get its start point
        float x0 = boneCoord0.x;             // Get the (x,y,z) values 
        float y0 = boneCoord0.y;             // of its start point
        float z0 = boneCoord0.z;

        if (aBone.hasChildren()) {
          println(aBone);
           
          // If this bone has children,
          // draw a line from this bone to each of its children
          List<BvhBone> childBvhBones = aBone.getChildren();
          int nChildren = childBvhBones.size();
          for (int j=0; j<nChildren; j++) {
            BvhBone aChildBone = childBvhBones.get(j);
            PVector boneCoord1 = aChildBone.absPos;

            float x1 = boneCoord1.x;
            float y1 = boneCoord1.y;
            float z1 = boneCoord1.z;


            line(x0, y0, z0, x1, y1, z1);
            
          /////////////////////////////////MEAT//////////////////
          //if (bDrawMeat) {
          //  float dx = x1 - x0; 
          //  float dy = y1 - y0; 
          //  float dz = z1 - z0; 
          //  float dh = dist(x0, y0, z0, x1, y1, z1); // r
          //  float cx = (x0+x1)/2.0; 
          //  float cy = (y0+y1)/2.0; 
          //  float cz = (z0+z1)/2.0; 
          //  float theta = atan2(dx, dz); 
          //  float phi = acos(dy/dh); 

          //  if (true) {//aBone.getName().equals("LeftUpLeg")) {
          //    PVector boneOrientation = new PVector(dx, dy, dz); 

          //    //stroke(255);
          //    noStroke();
          //    fill(222, 111, 55); 

          //    // draw a sphere at the start joint of each bone. 
          //    float boneR = 12; 
          //    pushMatrix(); 
          //    translate(x0, y0, z0); 
          //    sphereDetail(6, 6);
          //    sphere(boneR); 
          //    popMatrix();

          //    // http://mathworld.wolfram.com/SphericalCoordinates.html
          //    // Draw a cylinder oriented along the leg. Whew!
          //    pushMatrix(); 
          //    translate (cx, cy, cz);
          //    rotateY(theta);
          //    rotateX(HALF_PI + phi); 
          //    // box (dh/3, dh/3, dh); //Or a box, if you want

          //    beginShape(QUAD_STRIP); 
          //    int cylinderResolution = 12; 
          //    for (int c=0; c<=cylinderResolution; c++) {
          //      float ang = map(c, 0, cylinderResolution, 0, TWO_PI); 
          //      float ex = boneR * cos(ang); 
          //      float ey = boneR * sin(ang);
          //      float ez0 = 0- dh/2;
          //      float ez1 =    dh/2;
          //      vertex(ex, ey, ez0); 
          //      vertex(ex, ey, ez1);
          //    }
          //    endShape();
          //    popMatrix();
          //  }
          //} //end draw meat
            
            
            
          }//end if children loop
        } else {
          // Otherwise, if this bone has no children (it's a terminus)
          // then draw it differently. 

          PVector boneCoord1 = aBone.absEndPos;  // Get its start point
          float x1 = boneCoord1.x;
          float y1 = boneCoord1.y;
          float z1 = boneCoord1.z;

          line(x0, y0, z0, x1, y1, z1);

          String boneName = aBone.getName(); 
          if (boneName.equals("Head")) { 
            pushMatrix();
            translate( x1, y1, z1);
            ellipse(0, 0, 30, 30);
            popMatrix();
          } //end if head
        } //end else
        popMatrix();
      }//end loop over all bones
    } //end drawbones
  } //end class BVH