//draw function

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
  filteredFlights.clear();

  for (Flight f : flights) {
    boolean matchesSearch = matchesSearchFilter(f);

    if (matchesSearch) {
      filteredFlights.add(f);
    }
  }
    

tableScreen.table.updateDataSize(filteredFlights);
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
  applyFilters();
}

boolean overSearchBox() {
  return mouseX >= searchBoxX && mouseX <= searchBoxX + searchBoxW &&
         mouseY >= searchBoxY && mouseY <= searchBoxY + searchBoxH;
}
