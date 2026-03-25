class BarChart extends Graph {
    color dataColor;
    float gapX;

    BarChart(float x, float y, float w, float h, PFont titleFont, PFont dataFont, color dataColor, float gapX) {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;
        this.gapX = gapX;
    }

    //void draw(String[] labels, float[] values, float minY, float maxY, String yLabel, String titleText) {
    void draw() {

            float extraspace = 1.2;
            float backspace = 0.1;

            // draw background
            fill(255);
            rect(x - w*backspace, y - h*backspace, w*extraspace, h*extraspace);

            // draw title
            fill(0);
            textFont(titleFont);
            textAlign(LEFT,TOP);
            text(titleBC,x,y - h*backspace + 10);

            //draw y label
            fill(150);
            textFont(dataFont);
            textAlign(CENTER, TOP);
            text(yLabelBC, x - (w* backspace/2), y);


            //draw gridlines
            fill(0);
            float yDiv = bestDivider(minBCval, maxBCval);
            textAlign(RIGHT,BOTTOM);
            float j = 0;
            while (true) {
                float yVal = minBCval + yDiv * j;
                if (yVal > maxBCval) {
                    break;
                } 
                float yLoc = y + h - h*((yVal - minBCval)/(maxBCval-minBCval));
                if (Math.abs(yLoc - (y)) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                    stroke(220);
                    line(x, yLoc, x+w, yLoc);
                    stroke(0);
                    line(x, yLoc, x-10, yLoc);

                    text(yVal, x, yLoc);
                }
                j++;
            }
            textAlign(CENTER, TOP);


            // calculate width of each bar
            //float width = (w/categoryMap.size()) - gapX;
            float width = (w/showNumBC) - gapX;
            int i = 0;

            for (Map.Entry<String, Float> entry : showBCdata) { 
                float val = entry.getValue();
                float valX = gapX + (width + gapX) * i;
                float locX = valX + x;
                stroke(0);
                fill(dataColor);
                rect(locX, y+h - h*(val - minBCval)/(maxBCval - minBCval), width, h*(val - minBCval)/(maxBCval - minBCval));
                //draw text
                fill(0);
                text(entry.getKey(), locX + width/2, y+h+5);
                i++;
            }

            /*
            for (Map.Entry<String, Float> entry : categoryMap.entrySet()) {
                float val = entry.getValue();
                float valX = gapX + (width + gapX) * i;
                float locX = valX + x;
                stroke(0);
                fill(dataColor);
                rect(locX, y+h - h*(val - minBCval)/(maxBCval - minBCval), width, h*(val - minBCval)/(maxBCval - minBCval));
                //draw text
                fill(0);
                text(entry.getKey(), locX + width/2, y+h+5);
                i++;
            }
            */
            stroke(0);

            //Vertical line
            line(x,y,x,y+h);

            // horizontal line
            line(x,y+h, x+w,y+h);
    }
}