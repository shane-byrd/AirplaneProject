// functions relating to search box, written by Jasper (Xubo)
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

void applyFilters() {
  // apply filters to searchFlights
  searchFlights.clear();

  for (Flight f : flights) {
    boolean matchesSearch = matchesSearchFilter(f);
    boolean matchesDistance = matchesDistanceFilter(f);
    boolean matchesTime = matchesTimeFilter(f);

    if (matchesSearch && matchesDistance && matchesTime) {
      searchFlights.add(f);
    }
  }
  // set searchFlights to empty is the search result is zero
  if (searchApplied == false ) {
    searchFlights = new ArrayList<Flight>();
  }
  
  // update table to match new size
  tableScreen.table.updateDataSize(searchFlights);
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

void handleTextInputForSearch() {
  if (keyCode == BACKSPACE) {
    if (searchText.length() > 0) {
      searchText = searchText.substring(0, searchText.length() - 1);
    }
  } else if (key != CODED && key != ENTER && key != RETURN) {
    searchText += key;
  }
  ifNoSearch();
  applyFilters();
}

boolean overSearchBox() {
  return mouseX >= searchBoxX && mouseX <= searchBoxX + searchBoxW &&
         mouseY >= searchBoxY && mouseY <= searchBoxY + searchBoxH;
}

void handleNumberInput(String target) {
  if (keyCode == BACKSPACE) {
    if (target.equals("minDistance") && searchScreen.textEditMap.get("minDist").textLabel.length() > 0) {
      searchScreen.textEditMap.get("minDist").textLabel = searchScreen.textEditMap.get("minDist").textLabel.substring(0, searchScreen.textEditMap.get("minDist").textLabel.length() - 1);
    }
    if (target.equals("maxDistance") && searchScreen.textEditMap.get("maxDist").textLabel.length() > 0) {
      searchScreen.textEditMap.get("maxDist").textLabel = searchScreen.textEditMap.get("maxDist").textLabel.substring(0, searchScreen.textEditMap.get("maxDist").textLabel.length() - 1);
    }
  } else if (key >= '0' && key <= '9') {
    if (target.equals("minDistance")) searchScreen.textEditMap.get("minDist").textLabel += key;
    if (target.equals("maxDistance")) searchScreen.textEditMap.get("maxDist").textLabel += key;
  }
  ifNoSearch();
  applyFilters();
}

void handleTimeInput(String target) {
  if (keyCode == BACKSPACE) {
    if (target.equals("startTime") && searchScreen.textEditMap.get("startTime").textLabel.length() > 0) {
      searchScreen.textEditMap.get("startTime").textLabel = searchScreen.textEditMap.get("startTime").textLabel.substring(0, searchScreen.textEditMap.get("startTime").textLabel.length() - 1);
    }
    if (target.equals("endTime") && searchScreen.textEditMap.get("endTime").textLabel.length() > 0) {
      searchScreen.textEditMap.get("endTime").textLabel = searchScreen.textEditMap.get("endTime").textLabel.substring(0, searchScreen.textEditMap.get("endTime").textLabel.length() - 1);
    }
  } else if ((key >= '0' && key <= '9') || key == ':') {
    if (target.equals("startTime") && searchScreen.textEditMap.get("startTime").textLabel.length() < 5) searchScreen.textEditMap.get("startTime").textLabel += key;
    if (target.equals("endTime") && searchScreen.textEditMap.get("endTime").textLabel.length() < 5) searchScreen.textEditMap.get("endTime").textLabel += key;
  }
  ifNoSearch();
  applyFilters();
}


boolean matchesDistanceFilter(Flight f) {
  int minDist = parseIntegerOrDefault(searchScreen.textEditMap.get("minDist").textLabel, -1);
  int maxDist = parseIntegerOrDefault(searchScreen.textEditMap.get("maxDist").textLabel, -1);

  if (minDist != -1 && f.distance < minDist) {
    return false;
  }

  if (maxDist != -1 && f.distance > maxDist) {
    return false;
  }

  return true;
}

boolean matchesTimeFilter(Flight f) {
  int startT = parseTimeOrDefault(searchScreen.textEditMap.get("startTime").textLabel, -1);
  int endT = parseTimeOrDefault(searchScreen.textEditMap.get("endTime").textLabel, -1);

  int dep = f.depTime;

  if (startT != -1 && dep < startT) {
    return false;
  }

  if (endT != -1 && dep > endT) {
    return false;
  }

  return true;
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

void ifNoSearch() {
  if (searchText.equals("") && 
  searchScreen.textEditMap.get("minDist").textLabel.equals("")
  && (searchScreen.textEditMap.get("minDist").textLabel.equals("") 
  ||searchScreen.textEditMap.get("minDist").textLabel.equals(searchScreen.textEditMap.get("minDist").defaultText) )
&& (searchScreen.textEditMap.get("maxDist").textLabel.equals("") 
  ||searchScreen.textEditMap.get("maxDist").textLabel.equals(searchScreen.textEditMap.get("maxDist").defaultText) )
&& (searchScreen.textEditMap.get("startTime").textLabel.equals("") 
  ||searchScreen.textEditMap.get("startTime").textLabel.equals(searchScreen.textEditMap.get("startTime").defaultText) )
&& (searchScreen.textEditMap.get("endTime").textLabel.equals("") 
  ||searchScreen.textEditMap.get("endTime").textLabel.equals(searchScreen.textEditMap.get("endTime").defaultText) )
  ) {
    searchApplied = false;
  }
  else {
    searchApplied = true;
  }
}