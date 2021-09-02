class Button {
  float posx, posy;
  float diam;
  PImage statusImage;
  int status;
  int weight = 5;
  int opacity = 150;
  float cdiam = 60;

  Button(float _x, float _y, float _d, int _s) {
    posx = _x;
    posy = _y;
    diam = _d;
    status = _s;
  }

  void buttonDisplay(String _img) {                // laat de button zien, 3 kleuren , paars, oranje of neongroen.
    noStroke();

    if (status == green) {
      fill(green, 200);
      if (_img == "windowbutton.png") {
        img = loadImage("Window1.png");
        imageMode(CENTER);
        image(img, 535.1, 391.8);
      }
    } else if (status == purple) {
      fill(purple, 200);
      if (_img == "windowbutton.png") {
        img = loadImage("Window2.png");
        imageMode(CENTER);
        image(img, 535.1, 391.8);
      }
    } else if (status == orange) {
      fill(orange, 200);
      if (_img == "windowbutton.png") {
        img = loadImage("Window3.png");
        imageMode(CENTER);
        image(img, 535.1, 391.8);
      }
    }
    ellipse(posx, posy, diam, diam)  ;
    img = loadImage(_img);
    imageMode(CENTER);
    image(img, posx, posy);
  }


  void buttonPressed() {
    if ( dist(mouseX, mouseY, door.posx, door.posy) <= door.diam/2) { // DOOR BUTTON ACTIONS
      circle(door);
      if (door.status == green) {
        buttonmatch.stop();
        buttonmatch.play(1, 0.5);
        door.status = purple;
      } else if (door.status == purple) {
        door.status = orange;
      } else if (door.status == orange) {
        door.status = green;
      }
    }

    if ( dist(mouseX, mouseY, toilet.posx, toilet.posy) <= toilet.diam/2) {  // TOILET BUTTON ACTIONS
      circle(toilet);
      if (toilet.status == green) {
        toilet.status = purple;
        noise.stop();
        noise.play(1, 0.5);
      } else if (toilet.status == purple) {
        toilet.status = orange;
      } else if (toilet.status == orange) {
        toilet.status = green;
      }
    }

    if ( dist(mouseX, mouseY, radio.posx, radio.posy) <= radio.diam/2) {      // RADIO BUTTON ACTIONS
      circle(radio);
      if (radio.status == purple) {
        grain.stop();
        grain.play(1, 1);

        radio.status = orange;
      } else if (radio.status == orange) {
        radio.status = green;
      } else if (radio.status == green) {
        radio.status = purple;
      }
    }

    if ( dist(mouseX, mouseY, window.posx, window.posy) <= window.diam/2) {      // WINDOW BUTTON ACTIONS
      circle(window);
      if (window.status == orange) {
        button.stop();
        button.play(1, 0.9);
        window.status = purple;
      } else if (window.status == purple) {
        window.status = green;
      } else if (window.status == green) {
        window.status = orange;
      }
    }
  }
  void circle(Button instance) {
    for (int i = 0; i < 30; i++) {
      noFill();  
      strokeWeight(instance.weight + 0.1);                    
      stroke(instance.status, instance.opacity - i * 5);             
      ellipse(instance.posx, instance.posy, instance.cdiam+ i* 2, instance.cdiam+ i* 2);
    }
  }
}




//on first press, flushes toilet to initiate flooding.
