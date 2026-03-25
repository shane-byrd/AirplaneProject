class BarChart extends Graph {
    color dataColor;
    float gapX;

    BarChart(float x, float y, float w, float h, PFont titleFont, PFont dataFont, color dataColor, float gapX) {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;
        this.gapX = gapX;
    }

    void draw(String[] labels, float[] values, float minY, float maxY, String yLabel, String titleText) {
        if (labels.length == values.length) {
            float extraspace = 1.2;
            float backspace = 0.1;

            // draw background
            fill(255);
            rect(x - w*backspace, y - h*backspace, w*extraspace, h*extraspace);

            // draw title
            fill(0);
            textFont(titleFont);
            textAlign(LEFT,TOP);
            text(titleText,x,y - h*backspace + 10);

            //draw y label
            fill(150);
            textFont(dataFont);
            textAlign(CENTER, TOP);
            text(yLabel, x - (w* backspace/2), y);


            //draw gridlines
            fill(0);
            float yDiv = bestDivider(minY, maxY);
            textAlign(RIGHT,BOTTOM);
            float j = 0;
            while (true) {
                float yVal = minY + yDiv * j;
                if (yVal > maxY) {
                    break;
                } 
                float yLoc = y + h - h*((yVal - minY)/(maxY-minY));
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
            float width = (w/labels.length) - gapX;
            for (int i = 0; i < labels.length; i ++) {
                float valX = gapX + (width + gapX) * i;
                float locX = valX + x;
                stroke(0);
                fill(dataColor);
                rect(locX, y + h - h*((values[i] - minY)/(maxY - minY)), width, h*((values[i] - minY)/(maxY - minY)));


                //draw text
                fill(0);
                text(labels[i], locX + width/2, y+h+5);
            }
            stroke(0);

            //Vertical line
            line(x,y,x,y+h);

            // horizontal line
            line(x,y+h, x+w,y+h);



            
        }
    }
}