/*
  Shannon Hall
  6/23/21
  This program is just another example of particles moving through a field of forces
  created by noise. Here the forces also change over time.
*/

Force forces[];    // Stores the forces
int rows, cols;    // Stores the number of rows and columns
int i, j, index;   // Used to iterate through the forces
float x, y;        // Stores a position on screen
float xoff, yoff;  // The offsets used for noise 
float xinc, yinc;  // The amounts used to increment through the noise
float max_len;     // The maximum magnitude of a force
ArrayList<Particle> particles;  // Stores all the particles
int num_particles; // The number of particles
float angle;       // The angle of a force

void setup() {
  // Create the canvas
  size(500, 500);

  // Initialize the number of rows and columns
  rows = 60;
  cols = 60;

  // Initialize the parameters for the noise
  xoff = random(10000);
  yoff = random(10000);
  xinc = 0.1;
  yinc = 0.1;
  max_len = height / rows;

  // Create the field of forces
  forces = new Force[rows * cols];
  create_field();

  // Create all the particles at random positions on the screen
  num_particles = 100;
  particles = new ArrayList<Particle>();
  for (i = 0; i < num_particles; i ++) {
    particles.add(new Particle(random(width), random(height)));
  }
}

void draw() {
  // Draw the background
  background(255);

  // Draw the forces
  //for (Force force : forces) {
  //  //force.show();
  //}

  // Loop through every particle and update them
  for (Particle particle : particles) {
    particle.loop_edges();
    particle.apply_nearby_forces(forces, rows * cols);
    particle.update();
    particle.show();
  }

  // Every ten frames, update the flow field
  if (frameCount % 10 == 0) {
    xoff += xinc;
    yoff += yinc;
    create_field();
  }
}

// Creates the flow field using noise
void create_field() {
  // Loop through every force
  for (i = 0; i < rows; i ++) {
    for (j = 0; j < cols; j ++) {
      // Store the index and position on screen
      index = j + i * cols;
      x = map(j, 0, cols, 0, width);
      y = map(i, 0, rows, 0, height);

      // Calculate the angle using noise and create the force
      angle = map(noise(xoff + xinc * j, yoff + yinc * i), 0, 1, 0, 2 * PI);
      forces[index] = new Force(x, y, angle, max_len);
    }
  }
}
