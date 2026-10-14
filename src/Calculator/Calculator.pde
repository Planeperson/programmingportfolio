// Enda Tong| Sept 14 2026| Calculator
/*#00B782
 #00B845
 #00AEB8
 #00B807
 #0074B8
 */
String displayVal;
float l, r, result;
char op;
boolean newEntry;
boolean left;
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
void setup() {
  size(180, 190);
  displayVal = "0.0";
  l = 0.0;
  r= 0.0;
  result = 0.0;
  op = ' ';
  newEntry = true;
  left = true;
  numButtons [0] = new Button(60, 170, '0');
  numButtons [1] = new Button(30, 140, '1');
  numButtons [2] = new Button(60, 140, '2');
  numButtons [3] = new Button(90, 140, '3');
  numButtons [4] = new Button(30, 110, '4');
  numButtons [5] = new Button(60, 110, '5');
  numButtons [6] = new Button(90, 110, '6');
  numButtons [7] = new Button(30, 80, '7');
  numButtons [8] = new Button(60, 80, '8');
  numButtons [9] = new Button(90, 80, '9');
  opButtons [0] = new Button (30, 170, '±');
  opButtons [1] = new Button (90, 170, '.');
  opButtons [2] = new Button (120, 170, '=');
  opButtons [3] = new Button (120, 140, '+');
  opButtons [4] = new Button (120, 110, '-');
  opButtons [5] = new Button (120, 80, 'x');
  opButtons [6] = new Button (120, 50, '÷');
  opButtons [7] = new Button (90, 50, '%');
  opButtons [8] = new Button (60, 50, 'C');
  opButtons [9] = new Button (30, 50, '⌫');
  opButtons [10] =  new Button (150, 20, '√');
  opButtons [11] =  new Button (150, 50, '^');
}

void draw() {
  background(200);
  updateDisplay();
  //display and update hover state for number buttons
  for (int i = 0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  // display and update hover state for operater buttons
  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}


void updateDisplay() {
  // Background shape
  rectMode(CENTER);
  rect (75, 20, 110, 20);
  // overlay text
  fill(0);
  textAlign(RIGHT);
  text(displayVal, width-60, 27.5);
}

void mouseReleased () {
  // Update Display with button clicked by user
  //loop through numButtons
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      String digit = str(numButtons[i].val);

      if (newEntry||displayVal.equals("0.0")) {
        displayVal = digit;
        newEntry = false;
      } else {
        displayVal += digit;
      }
      if (left) {
        l = float(displayVal);
      } else {
        r = float(displayVal);
      }
    }
  }
  //loop thorugh opButtons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover == true) {
      char clicked = opButtons[i].val;

      if (clicked == '=') {
        performCalc();
      } else if (clicked =='C') {
        displayVal = "0.0";
        l = 0.0;
        r= 0.0;
        result = 0.0;
        op = ' ';
        newEntry = true;
        left = true;
      } else if (clicked == '√') {
        //square root in the display
        if (left == true) {
          l = sqrt(l);
          displayVal = str(l);
        } else {
          r = sqrt(r);
          displayVal = str(r);
        }
      } else if (clicked == '^') {
        //square of the value in the display
        if (left == true) {
          l = sq(l);
          displayVal = str(l);
        } else {
          r = sq(r);
          displayVal = str(r);
        }
      } else if (clicked == '.') {
        if (!displayVal.contains(".")) {
          if (left == true) {
            displayVal += ".";
            l = float(displayVal);
          } else {
            displayVal += ".";
            r = float(displayVal);
          }
        }
      } else if (clicked == '+' || clicked == '-'||clicked == 'x' || clicked == '÷') {
        op = clicked;
        left = false;
        newEntry = true;
        displayVal = str(op);
      } else if (clicked == '±') {
        if (!displayVal.equals("0.0") && !displayVal.equals("0")) {
          if (displayVal.startsWith("-")) {
            displayVal = displayVal.substring(1);
          } else {
            displayVal = "-" + displayVal;
          }
          if (left) {
            l = float(displayVal);
          } else {
            r = float(displayVal);
          }
        }
      } else if (clicked == '⌫') {
        if (displayVal.length() > 1) {
          displayVal = displayVal.substring(0, displayVal.length() - 1);
          if (displayVal.equals("-")) {
            displayVal = "0.0";
          }
        } else {
          displayVal = "0.0";
        }

        if (left) {
          l = float(displayVal);
        } else {
          r = float(displayVal);
        }
      } else if (clicked == '%') {
        float val = float(displayVal) / 100.0;
        displayVal = str(val);
        if (left) {
          l = val;
        } else {
          r = val;
        }
      }
    }
    printState();
  }
}
void printState() {
  println(
    "l:" +l+
    " | r:" + r +
    " | result:" + result+
    " | left:" + left +
    " | op:" + op +
    " | display:" + displayVal
    );
}

void performCalc() {
  if (op =='+') {
    result = l+r;
  } else if (op  == '-') {
    result = l - r;
  } else if ( op == '÷') {
    if ( r == 0 ) {
      displayVal = "ERROR";
    }
    result = l/r;
  } else if (op == 'x') {
    result = l*r;
  } else {
    return;
  }
  displayVal = str(result);
  l = result;
  r = 0.0;
  left = true;
  newEntry = true;
}

void keyPressed() {
  if (key == '1') {
    println("you hit 1"+keyCode);
    handleEvent('1', true);
  }  else if (key == '2' || keycod == 99) {
    println("you hit 2"+keyCode);
    handleEvent('2', true);
  }
}

void handleEvent(char val, boolean isNum) {
  if (isNum == true) {
    // stuff that happens
     String digit = str(val);

      if (newEntry||displayVal.equals("0.0")) {
        displayVal = digit;
        newEntry = false;
      } else {
        displayVal += digit;
      }
      if (left) {
        l = float(displayVal);
      } else {
        r = float(displayVal);
      }
    
  } else {
    //other stuff that happens
  }
}
