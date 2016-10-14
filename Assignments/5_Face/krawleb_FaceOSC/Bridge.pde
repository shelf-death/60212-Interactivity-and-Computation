// Based on Shiffman's work:
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example
// Series of Particles connected with distance joints
public class Bridge {

  // Bridge properties
  float totalLength;  // How long
  int numPoints;      // How many points

  // Our chain is a list of particles
  public ArrayList<Particle> particles;
  public ArrayList<RevoluteJoint> clawJoints;

  // Chain constructor
  Bridge(float l, int n, float anchorX, float anchorY) {

    totalLength = l;
    numPoints = n;

    particles = new ArrayList();
    clawJoints = new ArrayList();

    float len = totalLength / numPoints;

    // Here is the real work, go through and add particles to the chain itself
    for(int i=0; i < numPoints+1; i++) {
      // Make a new particle
      Particle p = null;
      
      // First and last particles are made with density of zero
      if (i == 0) p = new Particle(anchorX,anchorY+i*len,4,true);
      else p = new Particle(anchorX,anchorY+i*len,4,false);
      particles.add(p);

      // Connect the particles with a distance joint
      if (i > 0) {
         DistanceJointDef djd = new DistanceJointDef();
         Particle previous = particles.get(i-1);
         // Connection between previous particle and this one
         djd.bodyA = previous.body;
         djd.bodyB = p.body;
         // Equilibrium length
         djd.length = box2d.scalarPixelsToWorld(len);
         // These properties affect how springy the joint is 
         djd.frequencyHz = -0.9;
         djd.dampingRatio = 8;
         
         // Make the joint.  Note we aren't storing a reference to the joint ourselves anywhere!
         // We might need to someday, but for now it's ok
         DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
         
         //////////////////////Build Claw Arms///////////////////////////
         if (i == numPoints) {
           Float baseWidth = 80.0;
           Claw c = new Claw(baseWidth,10,p.body.getPosition());
           claws.add(c);
           
           RevoluteJointDef rjd = new RevoluteJointDef();
           
           rjd.bodyA = p.body;
           rjd.bodyB = c.body;
           rjd.localAnchorA.set(new Vec2(0,0));
           rjd.localAnchorB.set(new Vec2(0,1));
           
           //rjd.motorSpeed = 0;
           //rjd.maxMotorTorque = 4000;
           //rjd.enableMotor = false;
           
           RevoluteJoint rj = (RevoluteJoint) box2d.world.createJoint(rjd);
           
           ////////////Left side
           Claw cl1 = new Claw(5,50,c.body.getPosition());
           claws.add(cl1);
           
           //Revolute Joint Definition Left 1
           RevoluteJointDef rjdl1 = new RevoluteJointDef();
           
           rjdl1.bodyA = c.body;
           rjdl1.bodyB = cl1.body;
           rjdl1.localAnchorA.set(new Vec2(-baseWidth/20,0));
           rjdl1.localAnchorB.set(new Vec2(0,50/20));
           
           rjdl1.enableLimit = true;
           rjdl1.lowerAngle = radians (-45);
           rjdl1.upperAngle = radians (45);
           
           rjdl1.motorSpeed = PI/2;
           rjdl1.maxMotorTorque = 12000;
           rjdl1.enableMotor = false;
           
           RevoluteJoint rjl1 = (RevoluteJoint) box2d.world.createJoint(rjdl1);
           
           clawJoints.add(rjl1);
           
           ////////////Left side 2
           Claw cl2 = new Claw(5,30,cl1.body.getPosition());
           claws.add(cl2);
           
           //Revolute Joint Definition Left 2
           RevoluteJointDef rjdl2 = new RevoluteJointDef();
           
           rjdl2.bodyA = cl1.body;
           rjdl2.bodyB = cl2.body;
           rjdl2.localAnchorA.set(new Vec2(0,-2));
           rjdl2.localAnchorB.set(new Vec2(0,-2));
           
           rjdl2.enableLimit = true;
           rjdl2.lowerAngle = radians (-180);
           rjdl2.upperAngle = radians (45);
           
           rjdl2.motorSpeed = PI/2;
           rjdl2.maxMotorTorque = 12000;
           rjdl2.enableMotor = false;
           
           RevoluteJoint rjl2 = (RevoluteJoint) box2d.world.createJoint(rjdl2);
           
           clawJoints.add(rjl2);
           
           ////////////Right side
           Claw cr1 = new Claw(5,50,c.body.getPosition());
           claws.add(cr1);
           
           //Revolute Joint Definition Left 1
           RevoluteJointDef rjdr1 = new RevoluteJointDef();
           
           rjdr1.bodyA = c.body;
           rjdr1.bodyB = cr1.body;
           rjdr1.localAnchorA.set(new Vec2(baseWidth/20,0));
           rjdr1.localAnchorB.set(new Vec2(0,50/20));
           
           rjdr1.enableLimit = true;
           rjdr1.lowerAngle = radians (-45);
           rjdr1.upperAngle = radians (45);
           
           rjdr1.motorSpeed = -PI/2;
           rjdr1.maxMotorTorque = 12000;
           rjdr1.enableMotor = false;
           
           RevoluteJoint rjr1 = (RevoluteJoint) box2d.world.createJoint(rjdr1);
           
           clawJoints.add(rjr1);
           
           //Right Side 2
           Claw cr2 = new Claw(5,30,cr1.body.getPosition());
           claws.add(cr2);
           
           //Revolute Joint Definition right 2
           RevoluteJointDef rjdr2 = new RevoluteJointDef();
           
           rjdr2.bodyA = cr1.body;
           rjdr2.bodyB = cr2.body;
           rjdr2.localAnchorA.set(new Vec2(0,-2));
           rjdr2.localAnchorB.set(new Vec2(0,-2));
           
           rjdr2.enableLimit = true;
           rjdr2.lowerAngle = radians(-45);
           rjdr2.upperAngle = radians(180);
           
           rjdr2.motorSpeed = -PI/2;
           rjdr2.maxMotorTorque = 12000;
           rjdr2.enableMotor = false;
           
           RevoluteJoint rjr2 = (RevoluteJoint) box2d.world.createJoint(rjdr2);
           
           clawJoints.add(rjr2);
           
         }//end numPoints if
      }
    }
  }

  // Draw the bridge
  void display() {
    for (Particle p: particles) {
      p.display();
    }
  }
  
  void toggleClaw(boolean state){
    for (int i = 0; i < clawJoints.size(); i+=2) {
     clawJoints.get(i).enableMotor(!state);
  }
  }

}