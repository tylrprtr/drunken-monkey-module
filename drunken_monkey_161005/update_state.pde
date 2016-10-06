void update_state(){
//accel and velo
//proportional term
  p_diff=(target_cv-follow_cv);
  p_cv=(p_gain*p_diff);
  
  //integral term
  
  
  //derivative term
  d_cv=(d_gain*d_rate);
  
  //find instantaneous acceleration amoune
  //not technically correct, but the effect
  //is nice.
//  accel=old_accel+p_cv-d_cv;
  accel=p_cv-d_cv;
  
  //apply acceleration at each interval
  //but divide by mass to create gravity
  //effect... this isn't working correctly
  //but it works. might change name to "gravity"
//  velo+=accel/mass;
  velo+=accel;

  follow_cv+=velo;
  follow_cv=(constrain(follow_cv,0.0,10.0));
  
  //find derivative amount for next update
  //BEFORE current locations are moved to
  //old locations.
  d_rate=follow_cv-old_follow_cv;
  
  //move current states to
  //old states
  
  wave.setFrequency(map(follow_cv,0,10.0,16.35,16744));
  
  if(check_direction == true && follow_cv >= target_cv) target_check = true;
  if(check_direction == false && follow_cv <= target_cv) target_check = true;
}