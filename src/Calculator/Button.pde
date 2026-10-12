class Button {
  // Memeber Variables
  float x, y, w, h;
  color c1, c2;
  char val;
  boolean hover;

  //Constructor
  Button(float x, float y, char val) {
    this.x = x;
    this.y = y;
    w = 20;
    h = 20;
    c1 = color(60);
    c2 = color(177);
    this.val = val;
    hover = false;
  }

  // Member Methoods
  void display () {
    if(hover == true) {
      fill(c2);
    }else {
      fill(c1);
    }
    rectMode(CENTER);
    rect(x, y, w, h);
    textSize(20);
    textAlign(CENTER);
    fill(255);
    text(val, x, y+7);
  }
  void mouseOver(float tempX, float tempY) {
    if (tempX > x-w/2 && tempX < x+w/2 && tempY > y-h/2 && tempY < y+h/2) {
      hover = true;
    }else {
      hover = false;
    }
  }
}
