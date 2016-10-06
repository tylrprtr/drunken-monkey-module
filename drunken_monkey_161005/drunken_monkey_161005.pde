//PID example

//loading minim libs for sound generation only
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//loading control for GUI only
import controlP5.*;

//load font for GUI
PFont font;

//initialize separate drawing planes
PGraphics graph;
PGraphics control;

//initialize objects required for sound generation
Minim minim;
AudioOutput out;
Oscil wave;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;


//variable initialization (this needs cleanup)
float target_cv=0.0;
float rand_atten=5.0;
float follow_cv=0.0;
float output_cv=0.0;
float p_cv, i_cv, d_cv;
float p_gain=.1, i_gain=.1, d_gain=.1;
float p_diff=0.0, d_rate=0.0, i_damp=0.0;
float i_sum=0;
float p, i, d;

float mass=.5;

float velo=0, accel=0;
float old_accel;

int scale=30;

float old_follow_cv=0.0;
float old_target_cv=0.0;
float slope;
float old_slope=0.0;
float y;
float old_y=0;
int change=1;

float clock_rate;
boolean target_check = false;
boolean check_direction;

int pos=1;

//setup object is run once before the app starts
void setup() {
  //set background
  size(800, 450);
  background(0);
  smooth();
  
  //define random initial target
  target_cv=constrain(random(0.0, rand_atten), 2.0, 8.0);
  old_target_cv=target_cv;

  control = createGraphics(width, height);
  graph = createGraphics(width, height);

  minim = new Minim(this);
  out = minim.getLineOut();
  wave = new Oscil(follow_cv,0.1f, Waves.TRIANGLE);
  wave.patch(out);

  setupGUI();
}

//this object is called every frame
void draw() {
  update_state();

  graph.beginDraw();
  graph.stroke(0);
  graph.line(pos,0,pos,height);

  graph.pushMatrix();
  graph.translate(0, height-10);
  
  graph.stroke(50);
  graph.strokeWeight(1);
  graph.line(pos-1,-old_target_cv*scale,pos,-target_cv*scale);

  graph.stroke(100, 200, 150);
  graph.line(pos-1,-old_follow_cv*scale, pos, -follow_cv*scale);
  
  graph.popMatrix();
  graph.endDraw();
  
  control.beginDraw();
  drawGUI();
  control.endDraw();

  image(graph, 0, 0);
  image(control, 0, 0);

  old_accel=accel*.9;
  old_follow_cv=follow_cv;
  old_target_cv=target_cv;

  pos++;
  if (pos > width-200) pos=0;
  
  
    ////test LFO
  //if (target_cv>=10 || target_cv<=0) change*=-1;
  //if (change>0) target_cv+=.1;
  //else target_cv-=.1;
  
  
}

void keyPressed() {
  if (key == '1') newRandom();
}

void newRandom() {
  old_target_cv=target_cv;
  target_cv=constrain(random(0.0, rand_atten), 2.0, 8.0);
  target_check=false;
  
  if (target_cv > follow_cv) check_direction = true;
    else check_direction = false;
}