class SearchBox {

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

  void draw(PFont font) {
    drawSearchBox(font);
    drawInputBox(minDistanceBoxX, minDistanceBoxY, minDistanceBoxW, minDistanceBoxH, minDistanceText, "Min D", minDistanceActive, font);
    drawInputBox(maxDistanceBoxX, maxDistanceBoxY, maxDistanceBoxW, maxDistanceBoxH, maxDistanceText, "Max D", maxDistanceActive, font);
    drawInputBox(startTimeBoxX, startTimeBoxY, startTimeBoxW, startTimeBoxH, startTimeText, "Start", startTimeActive, font);
    drawInputBox(endTimeBoxX, endTimeBoxY, endTimeBoxW, endTimeBoxH, endTimeText, "End", endTimeActive, font);
    drawClearButton(font);
  }

  void drawSearchBox(PFont font) {
    stroke(0);

    if (searchActive) {
      fill(255);
      stroke(#125ab8);
    } else {
      fill(245);
      stroke(120);
    }

    rect(searchBoxX, searchBoxY, searchBoxW, searchBoxH, 6);

    fill(0);
    textFont(font);
    textAlign(LEFT, CENTER);

    if (searchText.equals("")) {
      text("Search...", searchBoxX + 8, searchBoxY + searchBoxH/2);
    } else {
      text(searchText, searchBoxX + 8, searchBoxY + searchBoxH/2);
    }
  }

  void drawInputBox(float x, float y, float w, float h, String value, String placeholder, boolean active, PFont font) {
    stroke(0);

    if (active) {
      fill(255);
      stroke(#125ab8);
    } else {
      fill(245);
      stroke(120);
    }

    rect(x, y, w, h, 6);

    fill(0);
    textFont(font);
    textAlign(LEFT, CENTER);

    if (value.equals("")) {
      text(placeholder, x + 6, y + h/2);
    } else {
      text(value, x + 6, y + h/2);
    }
  }

  void drawClearButton(PFont font) {
    fill(#c25151);
    rect(clearButtonX, clearButtonY, clearButtonW, clearButtonH, 6);

    fill(255);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("Clear", clearButtonX + clearButtonW/2, clearButtonY + clearButtonH/2);
  }

  void handleMousePressed() {
    searchActive = over(searchBoxX, searchBoxY, searchBoxW, searchBoxH);
    minDistanceActive = over(minDistanceBoxX, minDistanceBoxY, minDistanceBoxW, minDistanceBoxH);
    maxDistanceActive = over(maxDistanceBoxX, maxDistanceBoxY, maxDistanceBoxW, maxDistanceBoxH);
    startTimeActive = over(startTimeBoxX, startTimeBoxY, startTimeBoxW, startTimeBoxH);
    endTimeActive = over(endTimeBoxX, endTimeBoxY, endTimeBoxW, endTimeBoxH);
  }

  void handleKeyPressed() {
    if (searchActive) {
      if (keyCode == BACKSPACE && searchText.length() > 0) {
        searchText = searchText.substring(0, searchText.length()-1);
      } else if (key != CODED) {
        searchText += key;
      }
    }
  }

  boolean over(float x, float y, float w, float h) {
    return mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h;
  }

  void applyFilters(ArrayList<Flight> flights, ArrayList<Flight> filteredFlights) {
    filteredFlights.clear();

    for (Flight f : flights) {
      if (matchesSearch(f)) {
        filteredFlights.add(f);
      }
    }
  }

  boolean matchesSearch(Flight f) {
    String query = searchText.toLowerCase();

    if (query.equals("")) return true;

    for (String s : f.valuesInStringFormat) {
      if (s != null && s.toLowerCase().contains(query)) {
        return true;
      }
    }
    return false;
  }
}
