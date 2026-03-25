import java.util.PriorityQueue;
import java.util.Queue;
import java.util.*;
import java.io.*;
import processing.event.*;

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
int MAXYOFFSET = 0;

Table table;
VerticalScrollBar vscroll;
HorizontalScrollBar hscroll;
DropDown dropDownMenu;
DropDown showMenu;

Button nextPageButton;
Button prevPageButton;

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

// pagination
int tableAmount = 1000;
int currentPage = 0;
int totalPages = 1;

// remember current sort
String currentSortType = "None";

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
    0, 50, tableAmount + 1, 18, 100, 30, 2, 2,
    color(#D4FCE4),
    color(#9AD6B1),
    color(#2B9453),
    smallFont
  );

  vscroll = new VerticalScrollBar(0, 0, 20, 80, "vscroll", color(#c25151), color(#f5b8b8), 3, 3);
  hscroll = new HorizontalScrollBar(0, 0, 80, 20, "hscroll", color(#c25151), color(#f5b8b8), 3, 3);

  prevPageButton = new Button(
    900, 8, 120, 30, "prevPage", "Previous",
    color(#5a90d6), color(#c25151), color(#000000), smallFont
  );

  nextPageButton = new Button(
    1040, 8, 120, 30, "nextPage", "Next",
    color(#5a90d6), color(#c25151), color(#000000), smallFont
  );

  updatePagination();
  updateVerticalLimit();
}

void draw() 
{
  background(220);

  updatePagination();
  updateVerticalLimit();

  table.draw(titleData, flights, whichValues, currentPage, tableAmount);

  fill(#fffaed);
  rect(0, 0, SCREENX, 53);

  showMenu.draw(whichValues);
  dropDownMenu.draw();

  drawPageInfo();
  prevPageButton.draw(currentPage > 0);
  nextPageButton.draw(currentPage < totalPages - 1);

  hscroll.draw();
  vscroll.draw();
}

void drawPageInfo() {
  fill(#000000);
  textFont(smallFont);
  textAlign(LEFT, CENTER);

  int startRow = 0;
  int endRow = 0;

  if (flights.size() > 0) {
    startRow = currentPage * tableAmount + 1;
    endRow = min((currentPage + 1) * tableAmount, flights.size());
  }

  String pageText = "Rows: " + startRow + " - " + endRow + " / " + flights.size() + "    Page " + (currentPage + 1) + " of " + totalPages;
  text(pageText, 310, 22);
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

  if (prevPageButton.cursorOverWidget() && currentPage > 0) {
    currentPage--;
    YOFFSET = 0;
    updateVerticalLimit();
  }

  if (nextPageButton.cursorOverWidget() && currentPage < totalPages - 1) {
    currentPage++;
    YOFFSET = 0;
    updateVerticalLimit();
  }

  if (dropDownMenu.openW) {
    if (dropDownMenu.whichButtonOver().equals("None")) {
      dropDownMenu.openW = false;
    } else {
      String buttonPressed = dropDownMenu.whichButtonOver();
      currentSortType = buttonPressed;
      sortFlights(currentSortType);
      currentPage = 0;
      YOFFSET = 0;
      updatePagination();
      updateVerticalLimit();
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

void clampScroll() {
  if (XOFFSET < MINXOFFSET) {
    XOFFSET = MINXOFFSET;
  }
  if (XOFFSET > MAXXOFFSET) {
    XOFFSET = MAXXOFFSET;
  }
  if (YOFFSET < MINYOFFSET) {
    YOFFSET = MINYOFFSET;
  }
  if (YOFFSET > MAXYOFFSET) {
    YOFFSET = MAXYOFFSET;
  }
}

void updatePagination() {
  if (flights == null || flights.size() == 0) {
    totalPages = 1;
    currentPage = 0;
    return;
  }

  totalPages = (flights.size() + tableAmount - 1) / tableAmount;

  if (currentPage < 0) {
    currentPage = 0;
  }
  if (currentPage > totalPages - 1) {
    currentPage = totalPages - 1;
  }
}

void updateVerticalLimit() {
  int rowsOnThisPage = min(tableAmount, flights.size() - currentPage * tableAmount);
  if (rowsOnThisPage < 0) {
    rowsOnThisPage = 0;
  }

  float contentHeight = (rowsOnThisPage + 1) * (table.cellH + table.gapY) + table.gapY;
  float visibleHeight = SCREENY - table.y;

  MINYOFFSET = 0;
  MAXYOFFSET = int(max(0, contentHeight - visibleHeight));

  clampScroll();
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
