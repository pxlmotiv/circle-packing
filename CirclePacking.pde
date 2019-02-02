float c, initialArea;
int n, l;
ArrayList<Circle> shapes;

void setup() {
  size(960, 960);
  c = 1.001;
  l = 10000;
  initialArea = 81000;
  //Fills 85.65% of 960x960 window
  shapes = new ArrayList<Circle>();
}

void draw() {
  // 1. Choose Shape for Area Ai (Ai < A1(Area of first shape) < A(Area of window))
  // 2. Find linear dimensions of Area Ai
  // 3. Place Shape of Area Ai at a random position within Area A(window). 
  // 4. Test if it overlaps any previously placed shape or boundary (trial)
  //    4-1. If it does, choose another position.
  //    4-2. If it doesn't, place the shape and increment i
  // 5. Repeat
  
  float totalAreafilled = 0;
  
  background(0);

  for (int i = 1; i <= l; i++) {
    float a = returnDesiredArea(i, c);
    Circle c = new Circle(a);
    PVector p = returnValidPosition(c);
    totalAreafilled += a;
    c.position = p;
    shapes.add(c);
  }

  for (int i = 0; i < l; i++) {
    shapes.get(i).draw();
  }
  
  println("Fill: " + (totalAreafilled/(width*height)) * 100 + "%");
  
  noLoop();
}

float returnDesiredArea(int i, float c) {
  return (initialArea) * pow(i, -c);
}

PVector returnValidPosition(Circle c) {
  boolean isValid = false;
  PVector p = new PVector(0, 0);

  while (!isValid) {
    p = new PVector(random(width), random(height));
    isValid = p.x - c.radius > 0 && p.x + c.radius < width && p.y - c.radius > 0 && p.y + c.radius < height && !isOverlappingWithShapes(p, c.radius);
  }

  return p;
}

boolean isOverlappingWithShapes(PVector p, float r) {
  boolean isOverlapping = false;

  for (Circle shape : shapes) {
    isOverlapping = shape.isOverlappingWith(p, r);
    if (isOverlapping) break;
  }

  return isOverlapping;
}

void mouseClicked() {
  shapes = new ArrayList<Circle>();
  loop();
}