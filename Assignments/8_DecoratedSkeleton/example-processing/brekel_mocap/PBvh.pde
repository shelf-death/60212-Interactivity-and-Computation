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

  //------------------------------------------------
  //void draw() {
  //  // Previous method of drawing, provided by Rhizomatiks/Perfume

  //  fill(color(255));
  //  for ( BvhBone b : parser.getBones()) {
  //    pushMatrix();
  //    translate(b.absPos.x, b.absPos.y, b.absPos.z);
  //    ellipse(0, 0, 2, 2);
  //    popMatrix();
  //    if (!b.hasChildren()) {
  //      pushMatrix();
  //      translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
  //      ellipse(0, 0, 10, 10);
  //      popMatrix();
  //    }
  //  }
  //}//end draw

  //------------------------------------------------
  // Alternate method of drawing, added by Golan
  void drawBones(boolean renderExtras) {
    noFill(); 
    stroke(255); 
    strokeWeight(2);

    //int skeleLen = 1;
    //for (int skele = 0; skele<skeleLen; skele++) {

    //  float x = 200;
    //  float y = 0;
    //  float z = 0;

    //  if (skele == 1) {
    //    translate(x, y, z);
    //  }

      List<BvhBone> theBvhBones = parser.getBones();
      int nBones = theBvhBones.size();       // How many bones are there?
      BvhBone aBone;


      for (int i=0; i<nBones; i++) {         // Loop over all the bones
      
        PVector anchorTranslation = new PVector (0,0,0);
        
        pushMatrix();
        //if (theBvhBones.get(i)._name.equals("LeftArm") && skele == 1){
        //  aBone = theBvhBones.get(i);    //theBvhBones.get(i);  // Get the i'th bone
        //  println(aBone);
        //}else{
        //  aBone = theBvhBones.get(i);
        //}

        ////if (skele == 0){
        ////  aBone = theBvhBones.get(i);
        ////}
        aBone = theBvhBones.get(i);
        if (aBone.getName().equals("LeftShoulder") && renderExtras == true) {
          aBone.duplicates.add("LeftLeg");

          //draw root bone in original position
          line(
            aBone.absPos.x, 
            aBone.absPos.y, 
            aBone.absPos.z, 
            aBone.getChildren().get(0).absPos.x, 
            aBone.getChildren().get(0).absPos.y, 
            aBone.getChildren().get(0).absPos.z);

          for (String dupe : aBone.duplicates) {
            for (int l = 0; l < theBvhBones.size(); l++) {
              if (theBvhBones.get(l)._name.equals(dupe))
              {
                //then, save the translation in preparation for drawing duplicate
                anchorTranslation = new PVector(theBvhBones.get(l).absPos.x, theBvhBones.get(l).absPos.y, theBvhBones.get(l).absPos.z);
              }
            }
          }

          //draw a line at the current absPos to 1st child absPos,
          //then, run same process on child, line from 1st child absPos to 2nd child's abs pos
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
                // println("FINGERS "+ j);
                println(grandchildren.get(0).absEndPos.x);

                //line(
                //  currentChildren.get(j).absPos.x, 
                //  currentChildren.get(j).absPos.y, 
                //  currentChildren.get(j).absPos.z, 
                //  grandchildren.get(0).absPos.x*0, 
                //  grandchildren.get(0).absPos.y*0, 
                //  grandchildren.get(0).absPos.z*0);
                //}
              }
              BvhBone nextBone = currentChildren.get(0);
              currentBone = nextBone;
              popMatrix();
            } // end for loop
          }//end of while loop
      }// UNDO THIS IF BROKEN
      
      //////////////////////////////////////////////////////////
      
      if (aBone.getName().equals("RightShoulder") && renderExtras == true) {
          aBone.duplicates.add("RightLeg");

          //draw root bone in original position
          line(
            aBone.absPos.x, 
            aBone.absPos.y, 
            aBone.absPos.z, 
            aBone.getChildren().get(0).absPos.x, 
            aBone.getChildren().get(0).absPos.y, 
            aBone.getChildren().get(0).absPos.z);

          for (String dupe : aBone.duplicates) {
            for (int l = 0; l < theBvhBones.size(); l++) {
              if (theBvhBones.get(l)._name.equals(dupe))
              {
                //then, save the translation in preparation for drawing duplicate
                anchorTranslation = new PVector(theBvhBones.get(l).absPos.x, theBvhBones.get(l).absPos.y, theBvhBones.get(l).absPos.z);
              }
            }
          }

          //draw a line at the current absPos to 1st child absPos,
          //then, run same process on child, line from 1st child absPos to 2nd child's abs pos
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
                // println("FINGERS "+ j);
                println(grandchildren.get(0).absEndPos.x);

                //line(
                //  currentChildren.get(j).absPos.x, 
                //  currentChildren.get(j).absPos.y, 
                //  currentChildren.get(j).absPos.z, 
                //  grandchildren.get(0).absPos.x*0, 
                //  grandchildren.get(0).absPos.y*0, 
                //  grandchildren.get(0).absPos.z*0);
                //}
              }
              BvhBone nextBone = currentChildren.get(0);
              currentBone = nextBone;
              popMatrix();
            } // end for loop
          }//end of while loop
      }// UNDO THIS IF BROKEN

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
          }
        } else {
          // Otherwise, if this bone has no children (it's a terminus)
          // then draw it differently. 

          PVector boneCoord1 = aBone.absEndPos;  // Get its start point
          float x1 = boneCoord1.x;
          float y1 = boneCoord1.y;
          float z1 = boneCoord1.z;

          line(x0, y0, z0, x1, y1, z1);

          String boneName = aBone.getName(); 
          //if (boneName.equals("Head")) { 
          //  pushMatrix();
          //  translate( x1, y1, z1);
          //  ellipse(0, 0, 30, 30);
          //  popMatrix();
          //}
        }
        popMatrix();
      }
    }
  }