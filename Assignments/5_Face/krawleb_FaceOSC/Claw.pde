// A Claw Arm
public class Claw {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  Vec2 pos;

  // Constructor
  Claw(float w_, float h_, Vec2 pos_) {
    w = w_;
    h = h_;
    pos = pos_;
    // Add the box to the box2d world
    makeBody(new Vec2(pos.x, pos.y), w, h);
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0);
    //stroke(0);
    rect(0, 0, w, h);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 20;
    fd.friction = 8.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    //bd.position.set(box2d.coordPixelsToWorld(center));
    bd.position.set(pos);

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }//end MakeBody method
}//end claw class