import java.util.PriorityQueue;
import java.util.Queue;
import java.util.*;
import java.io.*;

//screen size
final int SCREENX=1200;
final int SCREENY=800;

//track where the local screen is relative to global screen coordinates
int XOFFSET=0;
int YOFFSET=0;

// prevent scrolling outside of screen
int MINXOFFSET = 0;
int MAXXOFFSET = 80 * 20;
int MINYOFFSET = 0;
int MAXYOFFSET = 50 * 2000;

Table table;
VerticalScrollBar vscroll;
HorizontalScrollBar hscroll;
DropDown dropDownMenu;
DropDown showMenu;

PFont smallFont;
PFont mediumFont;
PFont largeFont;

String[] titleData = 
{
  "Date", "Airline", "Flight Number",
  "Dep. Airport", "Dep. City", "Dep. State", "Dep. WAC", 
  "Dest. Airport", "Dest. City", "Dest. State", "Dest. WAC", 
  "STD", "ATD", "STA", "ATA", "Cancelled", "Diverted", "Distance"
};

Integer[] indexValues = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17};

// array determines which data points are visible for table
boolean[] whichValues = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};

//IDlabels for show menu
String[] showMenuLabels = 
{
  "showdate", "showairline", "showFlightNumber",
  "showOA", "showOC", "showOS", "showOW",
  "showDA", "showDC", "showDS", "showDW",
  "showSDT", "showADT", "showSAT", "showAAT",
  "showCancelled", "showDiverted", "showDistance"
};

//map from showmenu ID labels to indexValues
HashMap showLabelToIndex = StringToIntegerMap(showMenuLabels, indexValues);
ArrayList<Flight> flights;

void settings() 
{
  size(SCREENX, SCREENY);
}

void setup() 
{
  smallFont = loadFont("Baghdad-14.vlw");
  mediumFont = loadFont("Baghdad-24.vlw");
  largeFont = loadFont("Baghdad-30.vlw");

  flights = readFromFile("flights2k2.csv");

  showMenu = new DropDown(
    5, 5, 100, 30, "show", "Show", 
    color(#5a90d6),
    color(#000000),
    smallFont,
    3, 6,
    color(#a8ceff),
    color(#125ab8),
    color(#c25151)
    );

  showMenu.addButton("showdate", "Date");
  showMenu.addButton("showairline", "Airline");
  showMenu.addButton("showFlightNumber", "Flight Number");

  showMenu.addButton("showOA", "Dep. Airport");
  showMenu.addButton("showOC", "Dep. City");
  showMenu.addButton("showOS", "Dep. State");
  showMenu.addButton("showOW", "Dep. WAC");

  showMenu.addButton("showDA", "Dest. Airport");
  showMenu.addButton("showDC", "Dest. City");
  showMenu.addButton("showDS", "Dest. State");
  showMenu.addButton("showDW", "Dest. WAC");

  showMenu.addButton("showSDT", "STD");
  showMenu.addButton("showADT", "ATD");
  showMenu.addButton("showSAT", "STA");
  showMenu.addButton("showAAT", "ATA");

  showMenu.addButton("showCancelled", "Cancelled");
  showMenu.addButton("showDiverted", "Diverted");
  showMenu.addButton("showDistance", "Distance");

  dropDownMenu = new DropDown(
    115, 5, 170, 30, "sort", "Sort",
    color(#5a90d6),
    color(#000000),
    smallFont,
    3, 6,
    color(#a8ceff),
    color(#125ab8),
    color(#c25151)
    );

  dropDownMenu.addButton("airlineAsc", "Airline Ascending");
  dropDownMenu.addButton("airlineDesc", "Airline Descending");
  dropDownMenu.addButton("distanceAsc", "Distance Ascending");
  dropDownMenu.addButton("distanceDesc", "Distance Descending");
  dropDownMenu.addButton("depAsc", "Departure Time Ascending");
  dropDownMenu.addButton("depDesc", "Departure Time Descending");
  dropDownMenu.addButton("arrAsc", "Arrival Time Ascending");
  dropDownMenu.addButton("arrDesc", "Arrival Time Descending");

  table = new Table(
    0, 50, flights.size(), 18, 100, 30, 2, 2,
    color(#D4FCE4),
    color(#9AD6B1),
    color(#2B9453),
    smallFont
    );

  vscroll = new VerticalScrollBar(0, 0, 20, 80, "vscroll", color(#c25151), color(#f5b8b8), 3, 3);
  hscroll = new HorizontalScrollBar(0, 0, 80, 20, "hscroll", color(#c25151), color(#f5b8b8), 3, 3);
}

void draw() 
{
  background(220);

  table.draw(titleData, flights, whichValues);

  fill(#fffaed);
  rect(0, 0, SCREENX, 53);

  showMenu.draw(whichValues);
  dropDownMenu.draw();

  hscroll.draw();
  vscroll.draw();
}

void keyPressed() {
  boolean offsetChange = false;

  if (keyCode == LEFT) {
    XOFFSET -= 5;
    offsetChange = true;
  }
  if (keyCode == RIGHT) {
    XOFFSET += 5;
    offsetChange = true;
  }
  if (keyCode == UP) {
    YOFFSET -= 3;
    offsetChange = true;
  }
  if (keyCode == DOWN) {
    YOFFSET += 3;
    offsetChange = true;
  }

  if (offsetChange) {
    clampScroll();
  }
}

void mousePressed() {
  if (vscroll.cursorOverWidget()) {
    vscroll.click = true;
  }

  if (hscroll.cursorOverWidget()) {
    hscroll.click = true;
  }

  if (dropDownMenu.openW) {
    if (dropDownMenu.whichButtonOver().equals("None")) {
      dropDownMenu.openW = false;
    } else {
      String buttonPressed = dropDownMenu.whichButtonOver();
      sortFlights(buttonPressed);
      dropDownMenu.openW = false;
    }
  } else if (dropDownMenu.cursorOverWidget()) {
    dropDownMenu.openW = true;
  }

  if (showMenu.openW) {
    if (showMenu.whichButtonOver().equals("None")) {
      showMenu.openW = false;
    } else {
      String buttonPressed = showMenu.whichButtonOver();
      whichValues[(int)showLabelToIndex.get(buttonPressed)] = !whichValues[(int)showLabelToIndex.get(buttonPressed)];
    }
  } else if (showMenu.cursorOverWidget()) {
    showMenu.openW = true;
  }
}

void mouseReleased() {
  vscroll.click = false;   
  hscroll.click = false;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (keyPressed && keyCode == SHIFT) {
    XOFFSET += 2 * e;
  } else {
    YOFFSET += 2 * e;
  }
  clampScroll();
}

void mouseDragged() {
  if (vscroll.click) {
    YOFFSET = int(MINYOFFSET + ((mouseY - vscroll.h/2 + vscroll.gapY) / (SCREENY - 2 * vscroll.gapY - vscroll.h)) * (MAXYOFFSET - MINYOFFSET));
    clampScroll();
  }

  if (hscroll.click) {
    XOFFSET = int(MINXOFFSET + ((mouseX - hscroll.gapX) / (SCREENX - (hscroll.h + 2 * hscroll.gapX) - hscroll.gapX - hscroll.w) * (MAXXOFFSET - MINXOFFSET)));
    clampScroll();
  }
}

void sortFlights(String sortType) {
  Collections.sort(flights, new Comparator<Flight>() {
    public int compare(Flight a, Flight b) {

      if (sortType.equals("airlineAsc")) {
        return a.airlineCode.compareToIgnoreCase(b.airlineCode);
      }

      if (sortType.equals("airlineDesc")) {
        return b.airlineCode.compareToIgnoreCase(a.airlineCode);
      }

      if (sortType.equals("distanceAsc")) {
        return a.distance - b.distance;
      }

      if (sortType.equals("distanceDesc")) {
        return b.distance - a.distance;
      }

      if (sortType.equals("depAsc")) {
        return a.depTime - b.depTime;
      }

      if (sortType.equals("depDesc")) {
        return b.depTime - a.depTime;
      }

      if (sortType.equals("arrAsc")) {
        return a.arrTime - b.arrTime;
      }

      if (sortType.equals("arrDesc")) {
        return b.arrTime - a.arrTime;
      }

      return 0;
    }
  });
}
