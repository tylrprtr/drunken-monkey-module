void setupGUI(){
  color activeColor = color(0,130,164);
  controlP5 = new ControlP5(this);
  //controlP5.setAutoDraw(false);
  controlP5.setColorActive(activeColor);
  controlP5.setColorBackground(color(170));
  controlP5.setColorForeground(color(50));
  controlP5.setColorCaptionLabel(color(50));
  controlP5.setColorValueLabel(color(255));

  ControlGroup ctrl = controlP5.addGroup("menu",15,25,35);
  ctrl.setColorLabel(color(255));
  ctrl.close();

  sliders = new Slider[10];

  int left = 0;
  int top = 5;
  int len = 300;

  int si = 0;
  int posY = 0;

  sliders[si++] = controlP5.addSlider("rand_atten",0.000,10.000,left,top+posY+0,len,15);
  posY += 20;

  sliders[si++] = controlP5.addSlider("p_gain",0.01,1.00,left,top+posY+0,len,15);
  sliders[si++] = controlP5.addSlider("i_gain",0.01,1.00,left,top+posY+20,len,15);
  sliders[si++] = controlP5.addSlider("d_gain",0.01,1.00,left,top+posY+40,len,15);

  
  
  p_gain=.01;
  i_gain=.01;
  d_gain=.01;
  //mass=.5;

  for (int i = 0; i < si; i++) {
    sliders[i].setGroup(ctrl);
    sliders[i].getCaptionLabel().toUpperCase(true);
    sliders[i].getCaptionLabel().getStyle().padding(4,3,3,3);
    sliders[i].getCaptionLabel().getStyle().marginTop = -4;
    sliders[i].getCaptionLabel().getStyle().marginLeft = 0;
    sliders[i].getCaptionLabel().getStyle().marginRight = -14;
    sliders[i].getCaptionLabel().setColorBackground(0x99ffffff);
  }

}

void drawGUI(){
  controlP5.show();
  controlP5.draw();
  
  control.fill(0);
  control.noStroke();
  control.rect(width-200,0,200,height);
  
  control.pushMatrix();
  control.translate(width-180,height/2);
  control.fill(50);
  control.rect(0,-50,10,100);
  control.fill(255);
  control.rect(0,0,10,-p_cv*100);
  control.text("P",1,70);
  
  control.translate(20,0);
  control.fill(50);
  control.rect(0,-50,10,100);
  control.fill(255);
  control.rect(0,0,10,-i_cv*100);
  control.text("I",3,70);
  
  control.translate(20,0);
  control.fill(50);
  control.rect(0,-50,10,100);
  control.fill(255);
  control.rect(0,0,10,-d_cv*100);
  control.text("D",0,70);
  
  control.translate(20,0);
  control.fill(50);
  control.rect(0,-50,10,100);
  control.fill(255);
  control.rect(0,0,10,accel*10);
  control.text("A",0,70);
  
  control.translate(20,0);
  control.fill(50);
  control.rect(0,-50,10,100);
  control.fill(255);
  control.rect(0,0,10,velo*10);
  control.text("V",0,70);
  
  control.translate(20,0);
  if (target_check == true) control.fill(255);
  else control.fill(50);
  control.ellipse(5,47,6,6);
  control.text("☑",0,70);
  
  control.popMatrix();
  control.noFill();
}