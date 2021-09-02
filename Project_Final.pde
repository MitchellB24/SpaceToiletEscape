import processing.sound.*;
String introText [];
Animation animation1;
SoundFile music, flush, alarm, start, buttonmatch, noise, button, grain, water;
Button door, toilet, radio, window;

// above are declared all initializers or import processes.
PImage img;
int time;
float waterY;
boolean win;
boolean messageVisible;
int green = #5DFF9C;
int purple = #C085E8;
int orange = #FFC77E;
int state = -5;
PFont font;

//above are declared all public variables.

void setup() {

  size(1600, 800);       
  background(0);

  introText = new String [7];
  introText[0] = "The following is best experienced with headphones.\n (Click to continue)";
  introText[1] = "You are a traveller in an age of space exploration...";
  introText[2] = "Zooming through space in a luxury craft...";
  introText[3] = "But after a floating around with a glorious view...";
  introText[4] = "Your toilet malfunctions and the room starts to fill up with water!!";
  introText[5] = "You have escaped! \n You win! \n but what now...?";
  introText[6] = "You failed to escape and are dumped in space \n quite relaxing actually \n but what now..?";

  animation1= new Animation("water", 7);

  font = loadFont("OpenSans-Regular-32.vlw");
  door = new Button(1434, 544.6, 40, green);
  toilet = new Button(189.3, 504.5, 60, orange);
  radio = new Button(821.5, 591.2, 60, purple);
  window = new Button(308, 594.3, 60, green);

  water = new SoundFile(this, "water.wav");
  music = new SoundFile(this, "music.wav");
  flush = new SoundFile(this, "flush.mp3");
  alarm = new SoundFile(this, "alarm.wav");
  start = new SoundFile(this, "start.mp3");
  buttonmatch = new SoundFile(this, "buttonmatch.mp3");
  noise = new SoundFile(this, "aliennoise1.mp3");
  button = new SoundFile(this, "button.mp3");
  grain = new SoundFile(this, "grain.mp3");

  intro();
}   

void draw() {
  if (state == 1) {  
    display();
    animation1.display(205, 712);
    water();
    winCheck();
  } else if (state == 2) {
    win();
    reset();
  } else if (state == 3) {
    lose();
    reset();
  }    
}

void mousePressed() {
  if (state == 3) {
    state = -2;
  } else if (state == 2) {
    state = -2;
  } else  if (state == 0 ) {
    state = 1;
    messageVisible = true;
    start.play();
    water.loop();
    music.loop(1, -0.2);
  } else if (state == -1 ) {
    state = 0;
    intro();
  } else if (state == -2 ) {
    state = -1;
    intro();
  } else if (state == -3 ) {
    state = -2;
    intro();
  } else if (state == -4 ) {
    state = -3;
    intro();
  } else if (state == -5 ) {
    state = -4;
    intro();
  }

  if (mouseX > width/2 -400 && mouseX < width/2 + 400 && mouseY > height/2 - 100 && mouseY < height/2 + 100 ) {
    messageVisible = false;
  }
  door.buttonPressed();
  toilet.buttonPressed();
  window.buttonPressed();
  radio.buttonPressed();
}

void display() {
  img = loadImage("achtergrond.png");
  imageMode(CORNER);
  image(img, 0, 0);   
  displayColorOrder(green, purple, green, orange); 
  door.buttonDisplay("doorbutton.png");
  toilet.buttonDisplay("toiletbutton.png");
  radio.buttonDisplay("radiobutton.png");
  window.buttonDisplay("windowbutton.png");

  if (messageVisible == true) {
    stroke(255);
    strokeWeight(6);
    fill(0);
    rectMode(CENTER);
    rect(width/2, height/2, 800, 200, 7);
    textFont(font, 36);  
    fill(255);
    textAlign(CENTER, CENTER);
    text(" Quick! Escape! \n You are going to drown! \n match the colors with the buttons to escape!", width/2, height/2);
    textFont(font, 14);
    text("(Click to dissmiss)", width/2, height/2 + 80);
  }
}

void winCheck() {
  if (toilet.status == green && window.status == purple && radio.status == green && door.status == orange) {  // nog gelijk zetten aan de win order van kleuren
    state = 2;
  } else if (-height > waterY) {
    state = 3;
  }
}

void win() {
  img = loadImage("win.png");
  imageMode(CORNER);
  image(img, 0, 0);   
  textFont(font, 36); 
  fill(255);
  text(introText[5], width/2, height/2);
  win = true;
}

void lose() {
  img = loadImage("youlose.png");
  imageMode(CORNER);
  image(img, 0, 0);   
  textFont(font, 36); 
  fill(255);
  text(introText[6], width/2, height/2);
}

void reset() {
  music.stop();
  water.stop();
  door.status = green;
  window.status = orange;
  radio.status = purple;
  toilet.status = green;
  waterY = 0;
  time = 0;
}

void intro() {
  if (state == -5) {
    drawText(introText[0]);
  } else if (state == -4) {
    drawText(introText[1]);
  } else if (state == -3) {
    drawText(introText[2]);
  } else if (state == -2) {
    drawText(introText[3]);
  } else if (state == -1) {
    drawText(introText[4]);
    flush.play(0.5, 0.4);
    flush.play(1, 0.6);
    flush.play(1.5, 0.7);
    flush.play(2, 0.5);
    alarm.play(1, 0.5);
  }

  if (state == 0) {
    background(0);
    img = loadImage("titlescreen.png");
    imageMode(CENTER);
    image(img, width/2, height/2);
  }
}

void drawText(String text) {
  background(0);
  textFont(font, 36);  
  fill(255 );
  textAlign(CENTER, CENTER);
  text(text, width/2, height/2);
}

void water() {
  if (win == false) {
    time++;
  }
  if (  waterY < height) {      // everytime a time is 4 more a Y is added to rise the water according to the 60 seconds
    waterY -= 3.5;
  }

  println("time is:"+time+"");
  println("waterY is"+waterY+"");
  noStroke();
  fill(#90DBFF, 60 );
  rectMode(CORNER);
  rect(0, height, width, waterY);
}

void displayColorOrder(int color1, int color2, int color3, int color4) {                                 ////////// show order of color that is required to win
  noStroke();
  fill(color1);                    // green
  ellipse(710, 121, 10, 10);  
  fill(color2);                    // purple
  ellipse(753.3, 121, 10, 10);
  fill(color3);                    // green
  ellipse(796.6, 121, 10, 10);
  fill(color4);                    // orange
  ellipse(840, 121, 10, 10);
}
