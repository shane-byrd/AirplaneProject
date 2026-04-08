// graph to present data points, written by Shane Byrd
//
class ScatterPlot extends Graph {
    float pointRadius;
    color dataColor;

    ScatterPlot(float x, float y, float w, float h, PFont titleFont, PFont dataFont, float pointRadius, color dataColor) {
        super(x,y,w,h,titleFont,dataFont);
        this.pointRadius = pointRadius;
        this.dataColor = dataColor;
    }

    void draw(ArrayList<Float> xData, ArrayList<Float> yData, float xLow, float xHigh, float yLow, float yHigh, String titleText, String xLabel, String yLabel) {
        noStroke();

        // define padding constants
        float backspace = 0.1;
        float extraspace = 1.2;

        // get the correct span (Mingqi's addition)
        float xSpan = safeAxisSpan(xLow, xHigh);
        float ySpan = safeAxisSpan(yLow, yHigh);

        // draw background
        fill(255);
        rect(x - w*backspace,y - h*backspace, extraspace*w, extraspace*h);
        fill(0);

        //draw title
        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*.1 + 5);

        // draw x and y labels
        fill(150);
        textFont(dataFont);
        textAlign(LEFT, TOP);
        text(yLabel, x - (w* backspace)+3, y - 20);
        textAlign(RIGHT, TOP);
        text(xLabel, x + w + (w* backspace)-10, y + h+30);

        // draw horizontal gridlines
        float xDiv = bestDivider(xLow, xHigh);
        int j = 1;
        stroke(220);
        textAlign(CENTER,TOP);
        while (true) {
            float xVal = xLow + xDiv * j;
            if (xVal > xHigh) {
                break;
            }
            float xLoc = x + w*((xVal - xLow))/xSpan;
            if (Math.abs(xLoc - (x)) > 40 && Math.abs(xLoc - (x+w)) > 40) {
                stroke(220);
                line(xLoc,y+h, xLoc, y );
                stroke(0);
                line(xLoc, y+h, xLoc, y+h+10);
                String valueFormat = getCorrectFormat(xVal,scatterTypeX);
                text(valueFormat, xLoc,y+h+13);
            }
            j++;
        }

        // draw vertical gridlines
        float yDiv = bestDivider(yLow, yHigh);
        textAlign(RIGHT,BOTTOM);
        j = 0;
        while (true) {
            float yVal = yLow + yDiv * j;
            if (yVal > yHigh) {
                break;
            }
            float yLoc = y + h - h*((yVal - yLow)/ySpan);
            if (Math.abs(yLoc - y) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                stroke(220);
                line(x, yLoc, x+w, yLoc);
                stroke(0);
                line(x, yLoc, x-10, yLoc);
                String valueFormat = getCorrectFormat(yVal,scatterTypeY);
                text(valueFormat, x, yLoc);
            }
            j++;
        }
        




        ellipseMode(CENTER);
        if (xData.size() == yData.size()) {
            noStroke();
            // limit point amount to 30,000 to prevent lag
            for (int i = 0; i < min(xData.size(),30000); i++) {
                // draw each data point
                float xv = xData.get(i);
                float yv = yData.get(i);
                if (xv < xLow || xv > xHigh || yv < yLow || yv > yHigh) {
                    continue;
                }
                fill(dataColor);
                ellipse(x + w*((xv - xLow))/xSpan, y + h - h*((yv - yLow)/ySpan), pointRadius,pointRadius);
            }

            // draw x and y axis
            fill(0);
            stroke(0);
            line(x,y,x,y+h);
            line(x,y+h, x+w,y+h);

            // draw x axis labels
            textFont(dataFont);
            textAlign(LEFT,TOP);
            text(getCorrectFormat(xLow,scatterTypeX), x, y + h+10);
            text(getCorrectFormat(xHigh,scatterTypeX), x+w, y+h+10);

            //draw y axis labels
            textAlign(RIGHT, TOP);
            text(getCorrectFormat(yLow,scatterTypeY),x,y+h);
            text(getCorrectFormat(yHigh,scatterTypeY),x,y);


        }
    }
    void updateMouse(float xLow, float xHigh, float yLow, float yHigh) {
        // update the mouse label
        if (mouseX > x && mouseX < x + w 
        && mouseY > y && mouseY < y + h) {
            float xVal = xLow + ((mouseX - x)/w) * (xHigh - xLow);
            float yVal = yLow + ((h-(mouseY - y))/h) * (yHigh - yLow);
            mouseGraphHolder.textLabel = "X-value: "+getCorrectFormat(xVal,scatterTypeX)+", Y-value: "+getCorrectFormat(yVal,scatterTypeY);
        }
        else {
            mouseGraphHolder.textLabel = "X-value: , Y-value: ";
        }
    }
}
