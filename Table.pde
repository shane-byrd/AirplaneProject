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

    void draw(String[] titleData, ArrayList<Flight> flights, boolean[] whichValues) {
        // which values is an array of booleans saying which data points are to be shown
        noStroke();

        int falseCount = 0;
        int[] falseArray = 
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
        // calculate how wide the table is
        int visibleCount = 0;
        for (boolean visibleCell : whichValues) {
            if (visibleCell) {
                visibleCount ++;
            }
        } 
        //draw background table
        float nw = (cellW * visibleCount) + (visibleCount + 1) * gapX;
        fill(backgroundColor);
        rect(x-XOFFSET,y-YOFFSET,nw,h);

        // draw individual cells
        for (int r = 0; r < int(rows); r++) {
            for (int c = 0; c < int(cols); c++) {
                if (whichValues[c] == true) {
                    // calculate location of cell
                    float cellX = x + gapX + ((cellW + gapX) * (c - falseArray[c]));
                    float cellY = y + gapY + ((cellH + gapY) * (r));
                    if (r != 0) {
                        // draw cell
                        fill(cellColor);
                        rect(cellX - XOFFSET, cellY - YOFFSET, cellW, cellH);

                        // draw text
                        fill(#000000);
                        textFont(tableFont);
                        textAlign(CENTER,CENTER);
                        String outputText;
                        outputText = flights.get(r-1).valuesInStringFormat[c];


                        text(outputText, cellX + cellW/2 - XOFFSET, cellY + cellH/2 - YOFFSET);
                    }
                    // put title in different color
                    if (r == 0) {
                        fill(titleColor);
                        rect(cellX-XOFFSET, cellY, cellW, cellH);
                        // place title text

                        fill(#000000);
                        textFont(tableFont);
                        textAlign(CENTER,CENTER);
                        text(titleData[c], cellX + cellW/2 -XOFFSET, cellY + cellH/2);
                    }

                }
                // if a column is not visible, add offset for future columns
                else if (r == 0 && whichValues[c] == false) {
                    for (int i = c; i < falseArray.length; i++) {
                        falseArray[i]++;
                    }
                }

                
                
            }
        }
        // to ensure top row is always visible
        int r = 0;
        for (int c = 0; c < int(cols); c ++) {
            float cellX = x + gapX + ((cellW + gapX) * (c - falseArray[c]));
            float cellY = y + gapY + ((cellH + gapY) * (r));
            if (whichValues[c]) {
                fill(titleColor);
                rect(cellX-XOFFSET, cellY, cellW, cellH);
                // place title text

                fill(#000000);
                textFont(tableFont);
                textAlign(CENTER,CENTER);
                text(titleData[c], cellX + cellW/2 -XOFFSET, cellY + cellH/2);
            }
        }
    }
}