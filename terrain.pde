int cols, rows;
int scl = 60;
int w = 1600;
int h = 1600;

float [][] map;
float decal_y = 0;
float decal_x = 0;

void setup () {
  size(600, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  map = new float[cols][rows];

  float yoff = 0;
  for (int y=0; y<rows-1; y++) {
    float xoff = 0;
    for (int x=0; x<cols; x++) {
      map[x][y] = map(noise(xoff, yoff), 0, 1, -50, 50);
      xoff += random(-0.1, 0.3);
    }
    yoff += 0.5;
  }
}

void draw() {
  stroke(255); 
  background(255);
 
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  decal_y -= 0.01;
  decal_x -= 0.005;

  float yoff = decal_y;
  for (int y=0; y<rows-1; y++) {
    float xoff = decal_x;
    for (int x=0; x<cols; x++) {
      map[x][y] = map(noise(xoff, yoff), 0, 1, -50, 50);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  for (int y=0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) {
      vertex(x*scl, y*scl, map[x][y]);
      vertex(x*scl, (y+1) * scl, map[x][y+1]);
      fill(abs(map[x][y+1] * 2), abs(map[x][y+1]) * 2, 155);
    }
    endShape();
  }
}