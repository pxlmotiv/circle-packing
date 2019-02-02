class Circle {
  PVector position;
  float radius, area;

  Circle(float a) {
    position = new PVector(0, 0);
    area = a;
    radius = buildCircleofArea(a);
  }

  private float buildCircleofArea(float a) {
    return sqrt(a / PI);
  }

  boolean isOverlappingWith(PVector position, float radius) {
    return (dist(position.x, position.y, this.position.x, this.position.y) < (radius + this.radius));
  }

  void draw() {
    pushStyle();
    strokeWeight(1);
    stroke(220);
    noFill();
    ellipseMode(RADIUS);
    ellipse(position.x, position.y, radius, radius);
    popStyle();
  }
}