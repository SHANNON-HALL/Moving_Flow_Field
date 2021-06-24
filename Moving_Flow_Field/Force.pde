class Force {
  PVector start_pos;  // The starting position of the force
  PVector end_pos;    // The ending position of the force
  PVector comp;       // The components of the force
  float len;          // The length of the force

  // Creates a force given its starting position, angle, and maximum length
  Force(float x0, float y0, float angle, float max_len) {
    start_pos = new PVector(x0, y0);
    comp = new PVector(cos(angle), sin(angle));
    comp.mult(max_len);
    end_pos = start_pos.copy().add(comp);
    len = comp.mag();
  }

  // Draws the force as a line with a circle marking its starting position
  void show() {
    stroke(0);
    line(start_pos.x, start_pos.y, end_pos.x, end_pos.y);
    noStroke();
    fill(255, 0, 0);
    circle(start_pos.x, start_pos.y, len / 10);
  }
}
