// functions to split table screen into screens, written by Tommy (Zhihan)
void drawPageInfo() {
  
  textFont(smallFont);
  textAlign(LEFT, TOP);

  int startRow = 0;
  int endRow = 0;

  if (filteredFlights.size() > 0) {
    startRow = currentPage * tableAmount + 1;
    endRow = min((currentPage + 1) * tableAmount, filteredFlights.size());
  }
  fill(#a8ceff);
  stroke(0);
    rect(463,11.5,280,30,6);
    fill(#000000);
  String pageText = startRow + " - " + endRow + " / " + filteredFlights.size() + "    Page " + (currentPage + 1) + " of " + totalPages;
  text(pageText, 467, 20);
  noStroke();
}

void updatePagination() {
  if (filteredFlights == null || filteredFlights.size() == 0) {
    totalPages = 1;
    currentPage = 0;
    return;
  }

  totalPages = (filteredFlights.size() + tableAmount - 1) / tableAmount;

  if (currentPage < 0) {
    currentPage = 0;
  }
  if (currentPage > totalPages - 1) {
    currentPage = totalPages - 1;
  }
}

void updateVerticalLimit() {
  int rowsOnThisPage = min(tableAmount, filteredFlights.size() - currentPage * tableAmount);
  if (rowsOnThisPage < 0) {
    rowsOnThisPage = 0;
  }

  float contentHeight = (rowsOnThisPage + 2) * (tableScreen.table.cellH + tableScreen.table.gapY) + tableScreen.table.gapY;
  float visibleHeight = SCREENY - tableScreen.table.y;

  MINYOFFSET = 0;
  MAXYOFFSET = int(max(0, contentHeight - visibleHeight));

  clampScroll();
}


