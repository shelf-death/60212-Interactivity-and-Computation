public class PBvh
{
  public BvhParser parser; 
  public PVector skeleScale;

  public ArrayList<PVector> rawJointPositions = new ArrayList<PVector>();

  public PBvh(String[] data, PVector _skeleScale)
  {
    parser = new BvhParser();

    skeleScale = _skeleScale;

    parser.init();
    parser.parse( data );
  }

  public void update( int ms )
  {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }

  public void draw()
  {
    fill(color(255));

    for ( BvhBone b : parser.getBones())
    {
      pushMatrix();
      translate(b.absPos.x*this.skeleScale.x, b.absPos.y*this.skeleScale.y, b.absPos.z*this.skeleScale.z);
      ellipse(0, 0, 2, 2);
      popMatrix();
      if (!b.hasChildren())
      {
        pushMatrix();
        translate( b.absEndPos.x*this.skeleScale.x, b.absEndPos.y*this.skeleScale.y, b.absEndPos.z*this.skeleScale.z);
        ellipse(0, 0, 10, 10);
        popMatrix();
        stroke(255,0,0); //red 
        line(
          b.absPos.x * this.skeleScale.x,
          b.absPos.y * this.skeleScale.y, 
          b.absPos.z * this.skeleScale.z, 

          b.absEndPos.x * this.skeleScale.x, 
          b.absEndPos.y * this.skeleScale.y, 
          b.absEndPos.z * this.skeleScale.z);
      } //end if children
      
      if (b._parent != null) {
        stroke(255);
        line(b._parent.absPos.x * this.skeleScale.x, 
          b._parent.absPos.y * this.skeleScale.y, 
          b._parent.absPos.z * this.skeleScale.z, 

          b.absPos.x * this.skeleScale.x, 
          b.absPos.y * this.skeleScale.y, 
          b.absPos.z * this.skeleScale.z);
      }

      for ( PVector dupe : b.duplicates) {
        if (b.hasChildren()) {
          
          BvhBone child = b._children.get(0);
          
          line(
          b.absPos.x * this.skeleScale.x,
          b.absPos.y * this.skeleScale.y, 
          b.absPos.z * this.skeleScale.z, 

          child.absEndPos.x * this.skeleScale.x, 
          child.absEndPos.y * this.skeleScale.y, 
          child.absEndPos.z * this.skeleScale.z);
          
          while ( child.hasChildren() ) {
          println(child._name);
          child = child._children.get(0);
          }
          println("newBone");
          
        }//end if loop
      } //end for loop
    }//end for loop
  } //end draw
} //end PBvh class