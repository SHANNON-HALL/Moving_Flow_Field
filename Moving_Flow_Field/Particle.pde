class Particle {
  PVector pos;  // The position
  PVector vel;  // The velocity
  PVector acc;  // The acceleration
  float m;      // The mass
  float r, R;   // The visual radius of the particle, and the radius at which it is affected by forces 

  // Creates a particle at the given position
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    r = 5;
    R = r * 3;
    m = PI * r * r;
  }

  // Draws the particle as a circle at its position
  void show() {
    noStroke();
    fill(0, 255, 0);
    circle(pos.x, pos.y, r);

    // Draw the larger radius
    //fill(255, 0, 0, 50);
    //circle(pos.x, pos.y, R);
  }

  // Updates the particle using its velocity and acceleration
  void update() {
    vel.add(acc);
    pos.add(vel);

    // Limit the acceleration and velocity
    acc.limit(5);
    vel.limit(5);
  }

  // Applies the given force to the particle
  void apply_force(PVector force) {
    acc.add(force.copy().mult(1 / m));
  }

  // Makes the particle loop from one side of the screen to the opposite
  void loop_edges() {
    if (pos.x > width + r) pos.x = 0 - r;
    if (pos.x < -r) pos.x =  width + r;
    if (pos.y > height + r) pos.y = 0 - r;
    if (pos.y < -r) pos.y =  height + r;
  }

  // Applies the nearby forces to the particle
  void apply_nearby_forces(Force forces[], int num_forces) {
    int i;
    float distance;

    for (i = 0; i < num_forces; i ++) {
      distance = dist(pos.x, pos.y, forces[i].start_pos.x, forces[i].start_pos.y);
      if (distance < R) apply_force(forces[i].comp);
    }
  }
}
