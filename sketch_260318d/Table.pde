class Table {
    float x,y,rows,cols,cellW,cellH,gapX,gapY;
    color backgroundColor, cellColor, titleColor;
    PFont tableFont;

    float w,h;
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

    void draw(String[] titleData, ArrayList<Flight> flights, boolean[] whichValues, int currentPage, int tableAmount) {
        noStroke();

        int[] falseArray = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

        int visibleCount = 0;
        for (boolean visibleCell : whichValues) {
            if (visibleCell) {
                visibleCount++;
            }
        }

        int startIndex = currentPage * tableAmount;
        int endIndex = min(startIndex + tableAmount, flights.size());
        int pageRows = endIndex - startIndex;

        float drawRows = pageRows + 1;
        float nw = (cellW * visibleCount) + (visibleCount + 1) * gapX;
        float nh = (cellH * drawRows) + (drawRows + 1) * gapY;

        fill(backgroundColor);
        rect(x - XOFFSET, y - YOFFSET, nw, nh);

        for (int r = 0; r < int(drawRows); r++) {
            for (int c = 0; c < int(cols); c++) {
                if (whichValues[c]) {
                    float cellX = x + gapX + ((cellW + gapX) * (c - falseArray[c]));
                    float cellY = y + gapY + ((cellH + gapY) * r);

                    if (r != 0) {
                        fill(cellColor);
                        rect(cellX - XOFFSET, cellY - YOFFSET, cellW, cellH);

                        fill(#000000);
                        textFont(tableFont);
                        textAlign(CENTER, CENTER);

                        int flightIndex = startIndex + (r - 1);
                        String outputText = flights.get(flightIndex).valuesInStringFormat[c];

                        text(outputText, cellX + cellW/2 - XOFFSET, cellY + cellH/2 - YOFFSET);
                    }

                    if (r == 0) {
                        fill(titleColor);
                        rect(cellX - XOFFSET, cellY, cellW, cellH);

                        fill(#000000);
                        textFont(tableFont);
                        textAlign(CENTER, CENTER);
                        text(titleData[c], cellX + cellW/2 - XOFFSET, cellY + cellH/2);
                    }
                } 
                else if (r == 0 && whichValues[c] == false) {
                    for (int i = c; i < falseArray.length; i++) {
                        falseArray[i]++;
                    }
                }
            }
        }

        int r = 0;
        for (int c = 0; c < int(cols); c++) {
            float cellX = x + gapX + ((cellW + gapX) * (c - falseArray[c]));
            float cellY = y + gapY + ((cellH + gapY) * r);
            if (whichValues[c]) {
                fill(titleColor);
                rect(cellX - XOFFSET, cellY, cellW, cellH);

                fill(#000000);
                textFont(tableFont);
                textAlign(CENTER, CENTER);
                text(titleData[c], cellX + cellW/2 - XOFFSET, cellY + cellH/2);
            }
        }
    }
}
