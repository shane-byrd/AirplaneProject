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
DropDown filterColumnMenu;
Graph graph;

boolean showGraph = false;

float toggleButtonX = 295;
float toggleButtonY = 5;
float toggleButtonW = 140;
float toggleButtonH = 30;

float searchBoxX = 445;
float searchBoxY = 5;
float searchBoxW = 150;
float searchBoxH = 30;

float clearButtonX = 605;
float clearButtonY = 5;
float clearButtonW = 60;
float clearButtonH = 30;

float minDistanceBoxX = 675;
float minDistanceBoxY = 5;
float minDistanceBoxW = 70;
float minDistanceBoxH = 30;

float maxDistanceBoxX = 755;
float maxDistanceBoxY = 5;
float maxDistanceBoxW = 70;
float maxDistanceBoxH = 30;

float startTimeBoxX = 835;
float startTimeBoxY = 5;
float startTimeBoxW = 80;
float startTimeBoxH = 30;

float endTimeBoxX = 925;
float endTimeBoxY = 5;
float endTimeBoxW = 80;
float endTimeBoxH = 30;

String searchText = "";
String minDistanceText = "";
String maxDistanceText = "";
String startTimeText = "";
String endTimeText = "";

boolean searchActive = false;
boolean minDistanceActive = false;
boolean maxDistanceActive = false;
boolean startTimeActive = false;
boolean endTimeActive = false;

String selectedColumn = "All";

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
ArrayList<Flight> filteredFlights;

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
  filteredFlights = new ArrayList<Flight>(flights);

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

  filterColumnMenu = new DropDown(
    1015, 5, 170, 30, "filterColumn", "Filter: All",
    color(#5a90d6),
    color(#000000),
    smallFont,
    3, 6,
    color(#a8ceff),
    color(#125ab8),
    color(#c25151)
    );

  filterColumnMenu.addButton("all", "All");
  filterColumnMenu.addButton("date", "Date");
  filterColumnMenu.addButton("airline", "Airline");
  filterColumnMenu.addButton("flightNumber", "Flight Number");
  filterColumnMenu.addButton("depAirport", "Dep. Airport");
  filterColumnMenu.addButton("depCity", "Dep. City");
  filterColumnMenu.addButton("depState", "Dep. State");
  filterColumnMenu.addButton("destAirport", "Dest. Airport");
  filterColumnMenu.addButton("destCity", "Dest. City");
  filterColumnMenu.addButton("destState", "Dest. State");
  filterColumnMenu.addButton("distance", "Distance");
  filterColumnMenu.addButton("depTime", "Dep Time");
  filterColumnMenu.addButton("arrTime", "Arr Time");

  table = new Table(
    0, 50, filteredFlights.size() + 1, 18, 100, 30, 2, 2,
    color(#D4FCE4),
    color(#9AD6B1),
    color(#2B9453),
    smallFont
    );

  vscroll = new VerticalScrollBar(0, 0, 20, 80, "vscroll", color(#c25151), color(#f5b8b8), 3, 3);
  hscroll = new HorizontalScrollBar(0, 0, 80, 20, "hscroll", color(#c25151), color(#f5b8b8), 3, 3);

  graph = new Graph(60, 100, SCREENX - 140, SCREENY - 170, filteredFlights, mediumFont, smallFont);
}

void draw() 
{
  background(220);

  if (showGraph) {
    graph.draw();
  } else {
    table.rows = filteredFlights.size() + 1;
    table.h = (table.cellH * table.rows) + (table.rows + 1) * table.gapY;
    table.draw(titleData, filteredFlights, whichValues);
  }

  fill(#fffaed);
  rect(0, 0, SCREENX, 53);

  filterColumnMenu.textLabel = "Filter: " + selectedColumn;

  showMenu.draw(whichValues);
  dropDownMenu.draw();
  filterColumnMenu.draw();
  drawToggleButton();
  drawSearchBox();
  drawInputBox(minDistanceBoxX, minDistanceBoxY, minDistanceBoxW, minDistanceBoxH, minDistanceText, "Min D", minDistanceActive);
  drawInputBox(maxDistanceBoxX, maxDistanceBoxY, maxDistanceBoxW, maxDistanceBoxH, maxDistanceText, "Max D", maxDistanceActive);
  drawInputBox(startTimeBoxX, startTimeBoxY, startTimeBoxW, startTimeBoxH, startTimeText, "Start", startTimeActive);
  drawInputBox(endTimeBoxX, endTimeBoxY, endTimeBoxW, endTimeBoxH, endTimeText, "End", endTimeActive);
  drawClearButton();

  if (!showGraph) {
    hscroll.draw();
    vscroll.draw();
  }

  fill(0);
  textFont(smallFont);
  textAlign(LEFT, CENTER);
  text("Results: " + filteredFlights.size(), 1015, 42);
}

void drawToggleButton() {
  if (overToggleButton()) {
    fill(#7fb3ff);
  } else {
    fill(#5a90d6);
  }

  stroke(0);
  rect(toggleButtonX, toggleButtonY, toggleButtonW, toggleButtonH, 6);

  fill(0);
  textFont(smallFont);
  textAlign(CENTER, CENTER);

  if (showGraph) {
    text("Show Table", toggleButtonX + toggleButtonW/2, toggleButtonY + toggleButtonH/2);
  } else {
    text("Show Graph", toggleButtonX + toggleButtonW/2, toggleButtonY + toggleButtonH/2);
  }

  noStroke();
}

void drawSearchBox() {
  stroke(0);

  if (searchActive) {
    fill(#ffffff);
    stroke(#125ab8);
  } else {
    fill(#f7f7f7);
    stroke(120);
  }

  rect(searchBoxX, searchBoxY, searchBoxW, searchBoxH, 6);

  fill(80);
  textFont(smallFont);
  textAlign(LEFT, CENTER);

  if (searchText.equals("")) {
    text("Search...", searchBoxX + 8, searchBoxY + searchBoxH/2);
  } else {
    text(searchText, searchBoxX + 8, searchBoxY + searchBoxH/2);
  }

  noStroke();
}

void drawInputBox(float x, float y, float w, float h, String value, String placeholder, boolean active) {
  stroke(0);

  if (active) {
    fill(#ffffff);
    stroke(#125ab8);
  } else {
    fill(#f7f7f7);
    stroke(120);
  }

  rect(x, y, w, h, 6);

  fill(80);
  textFont(smallFont);
  textAlign(LEFT, CENTER);

  if (value.equals("")) {
    text(placeholder, x + 6, y + h/2);
  } else {
    text(value, x + 6, y + h/2);
  }

  noStroke();
}

void drawClearButton() {
  if (overClearButton()) {
    fill(#f29d9d);
  } else {
    fill(#c25151);
  }

  stroke(0);
  rect(clearButtonX, clearButtonY, clearButtonW, clearButtonH, 6);

  fill(255);
  textFont(smallFont);
  textAlign(CENTER, CENTER);
  text("Clear", clearButtonX + clearButtonW/2, clearButtonY + clearButtonH/2);

  noStroke();
}

boolean overToggleButton() {
  return mouseX >= toggleButtonX && mouseX <= toggleButtonX + toggleButtonW &&
         mouseY >= toggleButtonY && mouseY <= toggleButtonY + toggleButtonH;
}

boolean overSearchBox() {
  return mouseX >= searchBoxX && mouseX <= searchBoxX + searchBoxW &&
         mouseY >= searchBoxY && mouseY <= searchBoxY + searchBoxH;
}

boolean overClearButton() {
  return mouseX >= clearButtonX && mouseX <= clearButtonX + clearButtonW &&
         mouseY >= clearButtonY && mouseY <= clearButtonY + clearButtonH;
}

boolean overMinDistanceBox() {
  return mouseX >= minDistanceBoxX && mouseX <= minDistanceBoxX + minDistanceBoxW &&
         mouseY >= minDistanceBoxY && mouseY <= minDistanceBoxY + minDistanceBoxH;
}

boolean overMaxDistanceBox() {
  return mouseX >= maxDistanceBoxX && mouseX <= maxDistanceBoxX + maxDistanceBoxW &&
         mouseY >= maxDistanceBoxY && mouseY <= maxDistanceBoxY + maxDistanceBoxH;
}

boolean overStartTimeBox() {
  return mouseX >= startTimeBoxX && mouseX <= startTimeBoxX + startTimeBoxW &&
         mouseY >= startTimeBoxY && mouseY <= startTimeBoxY + startTimeBoxH;
}

boolean overEndTimeBox() {
  return mouseX >= endTimeBoxX && mouseX <= endTimeBoxX + endTimeBoxW &&
         mouseY >= endTimeBoxY && mouseY <= endTimeBoxY + endTimeBoxH;
}

void keyPressed() {
  if (searchActive) {
    handleTextInputForSearch();
    return;
  }

  if (minDistanceActive) {
    handleNumberInput("minDistance");
    return;
  }

  if (maxDistanceActive) {
    handleNumberInput("maxDistance");
    return;
  }

  if (startTimeActive) {
    handleTimeInput("startTime");
    return;
  }

  if (endTimeActive) {
    handleTimeInput("endTime");
    return;
  }

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

void handleTextInputForSearch() {
  if (keyCode == BACKSPACE) {
    if (searchText.length() > 0) {
      searchText = searchText.substring(0, searchText.length() - 1);
    }
  } else if (key != CODED && key != ENTER && key != RETURN) {
    searchText += key;
  }
  applyFilters();
}

void handleNumberInput(String target) {
  if (keyCode == BACKSPACE) {
    if (target.equals("minDistance") && minDistanceText.length() > 0) {
      minDistanceText = minDistanceText.substring(0, minDistanceText.length() - 1);
    }
    if (target.equals("maxDistance") && maxDistanceText.length() > 0) {
      maxDistanceText = maxDistanceText.substring(0, maxDistanceText.length() - 1);
    }
  } else if (key >= '0' && key <= '9') {
    if (target.equals("minDistance")) minDistanceText += key;
    if (target.equals("maxDistance")) maxDistanceText += key;
  }
  applyFilters();
}

void handleTimeInput(String target) {
  if (keyCode == BACKSPACE) {
    if (target.equals("startTime") && startTimeText.length() > 0) {
      startTimeText = startTimeText.substring(0, startTimeText.length() - 1);
    }
    if (target.equals("endTime") && endTimeText.length() > 0) {
      endTimeText = endTimeText.substring(0, endTimeText.length() - 1);
    }
  } else if ((key >= '0' && key <= '9') || key == ':') {
    if (target.equals("startTime") && startTimeText.length() < 5) startTimeText += key;
    if (target.equals("endTime") && endTimeText.length() < 5) endTimeText += key;
  }
  applyFilters();
}

void mousePressed() {
  searchActive = overSearchBox();
  minDistanceActive = overMinDistanceBox();
  maxDistanceActive = overMaxDistanceBox();
  startTimeActive = overStartTimeBox();
  endTimeActive = overEndTimeBox();

  if (overClearButton()) {
    searchText = "";
    minDistanceText = "";
    maxDistanceText = "";
    startTimeText = "";
    endTimeText = "";
    selectedColumn = "All";
    applyFilters();
    return;
  }

  if (overToggleButton()) {
    showGraph = !showGraph;
    return;
  }

  if (!showGraph && vscroll.cursorOverWidget()) {
    vscroll.click = true;
  }

  if (!showGraph && hscroll.cursorOverWidget()) {
    hscroll.click = true;
  }

  if (dropDownMenu.openW) {
    String overButton = dropDownMenu.whichButtonOver();
    if (overButton.equals("None")) {
      dropDownMenu.openW = false;
    } else {
      sortFlights(overButton);
      applyFilters();
      dropDownMenu.openW = false;
      return;
    }
  } else if (dropDownMenu.cursorOverWidget()) {
    dropDownMenu.openW = true;
    return;
  }

  if (showMenu.openW) {
    String overButton = showMenu.whichButtonOver();
    if (overButton.equals("None")) {
      showMenu.openW = false;
    } else {
      whichValues[(int)showLabelToIndex.get(overButton)] = !whichValues[(int)showLabelToIndex.get(overButton)];
      showMenu.openW = false;
      return;
    }
  } else if (showMenu.cursorOverWidget()) {
    showMenu.openW = true;
    return;
  }

  if (filterColumnMenu.openW) {
    String overButton = filterColumnMenu.whichButtonOver();
    if (overButton.equals("None")) {
      filterColumnMenu.openW = false;
    } else {
      if (overButton.equals("all")) selectedColumn = "All";
      if (overButton.equals("date")) selectedColumn = "Date";
      if (overButton.equals("airline")) selectedColumn = "Airline";
      if (overButton.equals("flightNumber")) selectedColumn = "Flight Number";
      if (overButton.equals("depAirport")) selectedColumn = "Dep. Airport";
      if (overButton.equals("depCity")) selectedColumn = "Dep. City";
      if (overButton.equals("depState")) selectedColumn = "Dep. State";
      if (overButton.equals("destAirport")) selectedColumn = "Dest. Airport";
      if (overButton.equals("destCity")) selectedColumn = "Dest. City";
      if (overButton.equals("destState")) selectedColumn = "Dest. State";
      if (overButton.equals("distance")) selectedColumn = "Distance";
      if (overButton.equals("depTime")) selectedColumn = "Dep Time";
      if (overButton.equals("arrTime")) selectedColumn = "Arr Time";

      applyFilters();
      filterColumnMenu.openW = false;
      return;
    }
  } else if (filterColumnMenu.cursorOverWidget()) {
    filterColumnMenu.openW = true;
    return;
  }
}

void mouseReleased() {
  vscroll.click = false;   
  hscroll.click = false;
}

void mouseWheel(MouseEvent event) {
  if (showGraph) {
    return;
  }

  float e = event.getCount();
  if (keyPressed && keyCode == SHIFT) {
    XOFFSET += 2 * e;
  } else {
    YOFFSET += 2 * e;
  }
  clampScroll();
}

void mouseDragged() {
  if (showGraph) {
    return;
  }

  if (vscroll.click) {
    YOFFSET = int(MINYOFFSET + ((mouseY - vscroll.h/2 + vscroll.gapY) / (SCREENY - 2 * vscroll.gapY - vscroll.h)) * (MAXYOFFSET - MINYOFFSET));
    clampScroll();
  }

  if (hscroll.click) {
    XOFFSET = int(MINXOFFSET + ((mouseX - hscroll.gapX) / (SCREENX - (hscroll.h + 2 * hscroll.gapX) - hscroll.gapX - hscroll.w) * (MAXXOFFSET - MINXOFFSET)));
    clampScroll();
  }
}

void applyFilters() {
  filteredFlights.clear();

  for (Flight f : flights) {
    boolean matchesSearch = matchesSearchFilter(f);
    boolean matchesDistance = matchesDistanceFilter(f);
    boolean matchesTime = matchesTimeFilter(f);

    if (matchesSearch && matchesDistance && matchesTime) {
      filteredFlights.add(f);
    }
  }

  graph.updateData(filteredFlights);
  table.rows = filteredFlights.size() + 1;
  table.h = (table.cellH * table.rows) + (table.rows + 1) * table.gapY;

  XOFFSET = 0;
  YOFFSET = 0;
}

boolean matchesSearchFilter(Flight f) {
  String query = searchText.trim().toLowerCase();

  if (query.equals("")) {
    return true;
  }

  if (selectedColumn.equals("All")) {
    for (int i = 0; i < f.valuesInStringFormat.length; i++) {
      if (f.valuesInStringFormat[i] != null && f.valuesInStringFormat[i].toLowerCase().indexOf(query) != -1) {
        return true;
      }
    }
    return false;
  }

  String value = getColumnValue(f, selectedColumn).toLowerCase();
  return value.indexOf(query) != -1;
}

boolean matchesDistanceFilter(Flight f) {
  int minDist = parseIntegerOrDefault(minDistanceText, -1);
  int maxDist = parseIntegerOrDefault(maxDistanceText, -1);

  if (minDist != -1 && f.distance < minDist) {
    return false;
  }

  if (maxDist != -1 && f.distance > maxDist) {
    return false;
  }

  return true;
}

boolean matchesTimeFilter(Flight f) {
  int startT = parseTimeOrDefault(startTimeText, -1);
  int endT = parseTimeOrDefault(endTimeText, -1);

  int dep = f.depTime;

  if (startT != -1 && dep < startT) {
    return false;
  }

  if (endT != -1 && dep > endT) {
    return false;
  }

  return true;
}

String getColumnValue(Flight f, String column) {
  if (column.equals("Date")) return f.valuesInStringFormat[0];
  if (column.equals("Airline")) return f.valuesInStringFormat[1];
  if (column.equals("Flight Number")) return f.valuesInStringFormat[2];
  if (column.equals("Dep. Airport")) return f.valuesInStringFormat[3];
  if (column.equals("Dep. City")) return f.valuesInStringFormat[4];
  if (column.equals("Dep. State")) return f.valuesInStringFormat[5];
  if (column.equals("Dest. Airport")) return f.valuesInStringFormat[7];
  if (column.equals("Dest. City")) return f.valuesInStringFormat[8];
  if (column.equals("Dest. State")) return f.valuesInStringFormat[9];
  if (column.equals("Distance")) return f.valuesInStringFormat[17];
  if (column.equals("Dep Time")) return f.valuesInStringFormat[12];
  if (column.equals("Arr Time")) return f.valuesInStringFormat[14];
  return "";
}

int parseIntegerOrDefault(String s, int defaultValue) {
  s = trim(s);
  if (s.equals("")) return defaultValue;

  try {
    return Integer.parseInt(s);
  } 
  catch(Exception e) {
    return defaultValue;
  }
}

int parseTimeOrDefault(String s, int defaultValue) {
  s = trim(s);
  if (s.equals("")) return defaultValue;

  try {
    if (s.indexOf(":") != -1) {
      String[] parts = split(s, ':');
      if (parts.length == 2) {
        int hour = Integer.parseInt(parts[0]);
        int minute = Integer.parseInt(parts[1]);
        return hour * 100 + minute;
      }
    } else {
      return Integer.parseInt(s);
    }
  } 
  catch(Exception e) {
    return defaultValue;
  }

  return defaultValue;
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

class Button extends Widget
{
  String textLabel;
  color buttonColor;
  color textLabelColor;
  color secondaryButtonColor;
  PFont buttonFont;

  Button(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color secondaryButtonColor, color textLabelColor, PFont buttonFont)
  {
    super(x, y, w, h, idLabel);
    this.textLabel = textLabel;
    this.buttonColor = buttonColor;
    this.textLabelColor = textLabelColor;
    this.buttonFont = buttonFont;
    this.secondaryButtonColor = secondaryButtonColor;
  }

  void draw() {
    fill(buttonColor);
    rect(x, y, w, h);

    fill(textLabelColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(textLabel, x + w/2, y + h/2);
  }

  void draw(boolean whichColor) {
    if (whichColor) {
      fill(buttonColor);
    } else {
      fill(secondaryButtonColor);
    }

    rect(x, y, w, h);

    fill(textLabelColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(textLabel, x + w/2, y + h/2);
  }
}

class DropDown extends Widget
{
  boolean openW;
  ArrayList<Button> selectionButtons;
  String textLabel;
  color buttonColor;
  color textLabelColor;
  color backgroundColor;
  color topButtonColor;
  color secondaryButtonColor;
  PFont buttonFont;
  float bottomY;
  float gapY;
  float gapX;
  float buttonAmount;

  DropDown(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color textLabelColor, PFont buttonFont, float gapY, float gapX, color backgroundColor, color topButtonColor, color secondaryButtonColor)
  {
    super(x, y, w, h, idLabel);
    openW = false;
    buttonAmount = 0;
    selectionButtons = new ArrayList<Button>();
    this.gapY = gapY;
    this.textLabel = textLabel;
    this.buttonColor = buttonColor;
    this.topButtonColor = topButtonColor;
    this.textLabelColor = textLabelColor;
    this.buttonFont = buttonFont;
    this.backgroundColor = backgroundColor;
    this.gapX = gapX;
    this.secondaryButtonColor = secondaryButtonColor;

    bottomY = y + h + gapY;
  }

  void addButton(String buttonLabel, String buttonText) {
    Button b = new Button(x, bottomY, w, h, buttonLabel, buttonText, buttonColor, secondaryButtonColor, textLabelColor, buttonFont);
    bottomY += h + gapY;
    selectionButtons.add(b);
    buttonAmount++;
  }

  void draw(boolean[] whichValues) {
    if (openW == true) {
      fill(backgroundColor);
      rect(x-gapX, y-gapY, w+2*gapX, (buttonAmount +1 ) * (h + gapY) + gapY );
      int i = 0;
      for (Button b : selectionButtons) {
        b.draw(whichValues[i]);
        i++;
      }
    }

    fill(topButtonColor);
    rect(x, y, w, h);

    fill(textLabelColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(textLabel, x + w/2, y + h/2);
  }

  void draw() {
    if (openW == true) {
      fill(backgroundColor);
      rect(x-gapX, y-gapY, w+2*gapX, (buttonAmount +1 ) * (h + gapY) + gapY );

      for (Button b : selectionButtons) {
        b.draw();
      }
    }

    fill(topButtonColor);
    rect(x, y, w, h);

    fill(textLabelColor);
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    text(textLabel, x + w/2, y + h/2);
  }

  String whichButtonOver() {
    for (Button b : selectionButtons) {
      if (b.cursorOverWidget()) {
        return b.idLabel;
      }
    }
    return "None";
  }
}

class Flight {
  int flightYear;
  int flightMonth;
  int flightDay;

  String airlineCode;
  int flightNumber;

  String originAirport;
  String originCity;
  String originState;
  int originWac;

  String destAirport;
  String destCity;
  String destState;
  int destWac;

  int scheduledDepTime;
  int depTime;
  int scheduledArrTime;
  int arrTime;

  boolean cancelled;
  boolean diverted;

  int distance;
  String[] valuesInStringFormat = new String[18];

  Flight(String[] row) {
    flightMonth = safeInt(row[0].substring(0,2));
    flightDay = safeInt(row[0].substring(3,5));
    flightYear = safeInt(row[0].substring(6,10));

    airlineCode = row[1];
    flightNumber = safeInt(row[2]);

    originAirport = row[3];
    originCity = row[4].substring(1);
    originState = row[6];
    originWac = safeInt(row[7]);

    destAirport = row[8];
    destCity = row[9].substring(1);
    destState = row[11];
    destWac = safeInt(row[12]);

    scheduledDepTime = safeInt(row[13]);
    depTime = safeInt(row[14]);
    scheduledArrTime = safeInt(row[15]);
    arrTime = safeInt(row[16]);

    cancelled = safeInt(row[17]) == 1;
    diverted = safeInt(row[18]) == 1;

    distance = safeInt(row[19]);

    valuesInStringFormat[0] = this.getDateRegular();
    valuesInStringFormat[1] = airlineCode;
    valuesInStringFormat[2] = String.valueOf(flightNumber);
    valuesInStringFormat[3] = originAirport;
    valuesInStringFormat[4] = originCity;
    valuesInStringFormat[5] = originState;
    valuesInStringFormat[6] = String.valueOf(originWac);
    valuesInStringFormat[7] = destAirport;
    valuesInStringFormat[8] = destCity;
    valuesInStringFormat[9] = destState;
    valuesInStringFormat[10] = String.valueOf(destWac);
    valuesInStringFormat[11] = convertTime24(scheduledDepTime);
    valuesInStringFormat[12] = convertTime24(depTime);
    valuesInStringFormat[13] = convertTime24(scheduledArrTime);
    valuesInStringFormat[14] = convertTime24(arrTime);
    valuesInStringFormat[15] = convertBoolToString(cancelled);
    valuesInStringFormat[16] = convertBoolToString(diverted);
    valuesInStringFormat[17] = String.valueOf(distance);
  }

  String getDateAmerican() {
    return flightMonth + "/" + flightDay + "/" + flightYear;
  }

  String getDateRegular() {
    return flightDay + "/" + flightMonth + "/" + flightYear;
  }
}

class Graph {
  float x;
  float y;
  float w;
  float h;

  ArrayList<Flight> flights;
  PFont titleFont;
  PFont labelFont;

  String[] airportLabels;
  int[] airportCounts;
  int barCount;

  Graph(float x, float y, float w, float h, ArrayList<Flight> flights, PFont titleFont, PFont labelFont) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.titleFont = titleFont;
    this.labelFont = labelFont;
    updateData(flights);
  }

  void updateData(ArrayList<Flight> flights) {
    this.flights = flights;

    HashMap<String, Integer> airportMap = new HashMap<String, Integer>();

    for (int i = 0; i < flights.size(); i++) {
      Flight f = flights.get(i);

      if (f.originAirport != null && !f.originAirport.equals("")) {
        if (airportMap.containsKey(f.originAirport)) {
          airportMap.put(f.originAirport, airportMap.get(f.originAirport) + 1);
        } else {
          airportMap.put(f.originAirport, 1);
        }
      }
    }

    ArrayList<Map.Entry<String, Integer>> entries = new ArrayList<Map.Entry<String, Integer>>(airportMap.entrySet());

    Collections.sort(entries, new Comparator<Map.Entry<String, Integer>>() {
      public int compare(Map.Entry<String, Integer> a, Map.Entry<String, Integer> b) {
        return b.getValue() - a.getValue();
      }
    });

    int limit = min(10, entries.size());
    barCount = limit;

    airportLabels = new String[limit];
    airportCounts = new int[limit];

    for (int i = 0; i < limit; i++) {
      airportLabels[i] = entries.get(i).getKey();
      airportCounts[i] = entries.get(i).getValue();
    }
  }

  void draw() {
    fill(245);
    stroke(180);
    rect(x, y, w, h);

    fill(0);
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    text("Top 10 Origin Airports by Number of Flights", x + w/2, y + 25);

    if (barCount == 0) {
      textFont(labelFont);
      text("No airport data available", x + w/2, y + h/2);
      return;
    }

    float leftMargin = 70;
    float rightMargin = 30;
    float topMargin = 60;
    float bottomMargin = 80;

    float chartX = x + leftMargin;
    float chartY = y + topMargin;
    float chartW = w - leftMargin - rightMargin;
    float chartH = h - topMargin - bottomMargin;

    int maxCount = 0;
    for (int i = 0; i < barCount; i++) {
      if (airportCounts[i] > maxCount) {
        maxCount = airportCounts[i];
      }
    }

    stroke(0);
    line(chartX, chartY + chartH, chartX + chartW, chartY + chartH);
    line(chartX, chartY, chartX, chartY + chartH);

    int steps = 5;
    for (int i = 0; i <= steps; i++) {
      float yy = chartY + chartH - (chartH * i / steps);
      int value = round(maxCount * i / (float)steps);

      stroke(210);
      line(chartX, yy, chartX + chartW, yy);

      fill(0);
      textFont(labelFont);
      textAlign(RIGHT, CENTER);
      text(value, chartX - 8, yy);
    }

    float gap = 20;
    float totalGap = gap * (barCount + 1);
    float barW = (chartW - totalGap) / barCount;

    for (int i = 0; i < barCount; i++) {
      float currentBarW = barW;
      if (currentBarW < 20) {
        currentBarW = 20;
      }

      float barX = chartX + gap + i * (barW + gap);
      float barH = map(airportCounts[i], 0, maxCount, 0, chartH - 20);
      float barY = chartY + chartH - barH;

      fill(#5a90d6);
      stroke(0);
      rect(barX, barY, currentBarW, barH);

      fill(0);
      textFont(labelFont);
      textAlign(CENTER, BOTTOM);
      text(airportCounts[i], barX + currentBarW/2, barY - 4);

      textAlign(CENTER, TOP);
      text(airportLabels[i], barX + currentBarW/2, chartY + chartH + 8);
    }

    noStroke();
  }
}

class HorizontalScrollBar extends Widget
{
  color buttonColor;
  color scrollColor;
  float gapX;
  float gapY;
  float value;
  boolean click;

  HorizontalScrollBar(float x, float y, float w, float h, String idLabel, color buttonColor, color scrollColor, float gapX, float gapY)
  {
    super(x, y, w, h, idLabel);
    value = 0;
    click = false;
    this.buttonColor = buttonColor;
    this.scrollColor = scrollColor;
    this.gapX = gapX;
    this.gapY = gapY;
  }

  void draw() {
    stroke(0);
    fill(scrollColor);
    rect(0, SCREENY - (2 * gapY + h), SCREENX, 2*gapY + h);

    float xoffsetSpace = MAXXOFFSET - MINXOFFSET;
    float absoluteValue = XOFFSET - MINXOFFSET;
    if (absoluteValue == 0) {
      value = 0;
    } else {
      value = absoluteValue / xoffsetSpace;
    }

    fill(buttonColor);
    rect(gapX + value * (SCREENX - (h + 2*gapX) - gapX - w), SCREENY - h - gapY, w, h);
    x = gapX + value * (SCREENX - (h + 2*gapX) - gapX - w);
    y = SCREENY - h - gapY;
    noStroke();
  }
}

ArrayList<Flight> readFromFile(String filename) 
{
  ArrayList<Flight> flights = new ArrayList<Flight>();
  String[] lines = loadStrings(filename);
  for (int i = 1; i < lines.length; i++) 
  {
    String[] dataPoints = split(lines[i], ",");
    Flight f = new Flight(dataPoints);
    flights.add(f);
  }
  return flights;
}

class Table {
  float x, y, rows, cols, cellW, cellH, gapX, gapY;
  color backgroundColor, cellColor, titleColor;
  PFont tableFont;

  float w, h;

  Table(float x, float y, float rows, float cols, float cellW, float cellH, float gapX, float gapY, color backgroundColor, color cellColor, color titleColor, PFont tableFont) {
    this.x = x;
    this.y = y;
    this.rows = rows;
    this.cols = cols;
    this.cellW = cellW;
    this.cellH = cellH;
    this.gapX = gapX;
    this.gapY = gapY;
    this.backgroundColor = backgroundColor;
    this.cellColor = cellColor;
    this.titleColor = titleColor;
    this.tableFont = tableFont;
    w = (this.cellW * this.cols) + (this.cols + 1) * this.gapX;
    h = (this.cellH * this.rows) + (this.rows + 1) * this.gapY;
  }

  void draw(String[] titleData, ArrayList<Flight> flights, boolean[] whichValues) {
    noStroke();

    int[] falseArray = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    int visibleCount = 0;
    for (boolean visibleCell : whichValues) {
      if (visibleCell) {
        visibleCount ++;
      }
    }

    float nw = (cellW * visibleCount) + (visibleCount + 1) * gapX;
    fill(backgroundColor);
    rect(x - XOFFSET, y - YOFFSET, nw, h);

    for (int r = 0; r < int(rows); r++) {
      for (int c = 0; c < int(cols); c++) {
        if (whichValues[c] == true) {
          float cellX = x + gapX + ((cellW + gapX) * (c - falseArray[c]));
          float cellY = y + gapY + ((cellH + gapY) * (r));
          if (r != 0) {
            if (r - 1 < flights.size()) {
              fill(cellColor);
              rect(cellX - XOFFSET, cellY - YOFFSET, cellW, cellH);

              fill(#000000);
              textFont(tableFont);
              textAlign(CENTER, CENTER);
              String outputText = flights.get(r-1).valuesInStringFormat[c];
              text(outputText, cellX + cellW/2 - XOFFSET, cellY + cellH/2 - YOFFSET);
            }
          }

          if (r == 0) {
            fill(titleColor);
            rect(cellX - XOFFSET, cellY, cellW, cellH);

            fill(#000000);
            textFont(tableFont);
            textAlign(CENTER, CENTER);
            text(titleData[c], cellX + cellW/2 - XOFFSET, cellY + cellH/2);
          }
        } else if (r == 0 && whichValues[c] == false) {
          for (int i = c; i < falseArray.length; i++) {
            falseArray[i]++;
          }
        }
      }
    }
  }
}

int safeInt(String s) {
  if (s == null || s.equals("")) {
    return 0;
  }
  return int(s);
}

String convertTime24(int inputTime) {
  int hour = inputTime / 100;
  int minutes = inputTime - (hour * 100);
  if (minutes < 10) {
    return String.valueOf(hour) + ":0" + String.valueOf(minutes);
  } else {
    return String.valueOf(hour) + ":" + String.valueOf(minutes);
  }
}

String convertBoolToString(boolean value) {
  if (value) {
    return "True";
  } else {
    return "False";
  }
}

HashMap StringToIntegerMap(String[] keys, Integer[] values) {
  int keysSize = keys.length;
  int valuesSize = values.length;
  if (keysSize != valuesSize) {
    println("error: string array does not match integer array in size");
    return new HashMap();
  }
  if (keysSize == 0 ) {
    return new HashMap();
  }
  HashMap<String, Integer> m = new HashMap<String, Integer>();
  for (int i = 0; i < keysSize; i ++) {
    m.put(keys[i], values[i]);
  }
  return m;
}

void clampScroll() {
  if (XOFFSET > MAXXOFFSET ) {
    XOFFSET = MAXXOFFSET;
  }
  if (XOFFSET < MINXOFFSET) {
    XOFFSET = MINXOFFSET;
  }
  if (YOFFSET > MAXYOFFSET ) {
    YOFFSET = MAXYOFFSET;
  }
  if (YOFFSET < MINYOFFSET) {
    YOFFSET = MINYOFFSET;
  }
}

class VerticalScrollBar extends Widget
{
  color buttonColor;
  color scrollColor;
  float gapX;
  float gapY;
  float value;
  boolean click;

  VerticalScrollBar(float x, float y, float w, float h, String idLabel, color buttonColor, color scrollColor, float gapX, float gapY)
  {
    super(x, y, w, h, idLabel);
    click = false;
    value = 0;
    this.buttonColor = buttonColor;
    this.scrollColor = scrollColor;
    this.gapX = gapX;
    this.gapY = gapY;
  }

  void draw() {
    stroke(0);
    fill(scrollColor);
    rect(SCREENX - (2*gapX + w), 0, 2*gapX + w, SCREENY);
    float yoffsetSpace = MAXYOFFSET - MINYOFFSET;
    float absoluteValue = YOFFSET - MINYOFFSET;
    if (absoluteValue == 0) {
      value = 0;
    } else {
      value = absoluteValue / yoffsetSpace;
    }

    fill(buttonColor);
    rect(SCREENX - gapX - w, gapY + value * (SCREENY - 2*gapY - h), w, h);
    x = SCREENX - gapX - w;
    y = gapY + value * (SCREENY - 2*gapY - h);
    noStroke();
  }
}

abstract class Widget
{
  float x, y, w, h;
  String idLabel;

  Widget(float x, float y, float w, float h, String idLabel)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.idLabel = idLabel;
  }

  boolean cursorOverWidget() {
    return (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h);
  }

  abstract void draw();
}
