
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
        float backspace = 0.1;
        float extraspace = 1.2;
        float xSpan = safeAxisSpan(xLow, xHigh);
        float ySpan = safeAxisSpan(yLow, yHigh);

        fill(255);
        rect(x - w*.1,y - h*.1, 1.2*w, 1.2*h);
        fill(0);

        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*.1 + 5);
        
        fill(150);
        textFont(dataFont);
        textAlign(LEFT, TOP);
        text(yLabel, x - (w* backspace)+3, y - 20);

        textAlign(RIGHT, TOP);
        text(xLabel, x + w + (w* backspace)-10, y + h+30);

        ellipseMode(CENTER);
        if (xData.size() == yData.size()) {
            noStroke();
            for (int i = 0; i < xData.size(); i++) {
                float xv = xData.get(i);
                float yv = yData.get(i);
                if (xv < xLow || xv > xHigh || yv < yLow || yv > yHigh) {
                    continue;
                }
                fill(dataColor);
                ellipse(x + w*((xv - xLow))/xSpan, y + h - h*((yv - yLow)/ySpan), pointRadius,pointRadius);
            }
            fill(0);
            stroke(0);
            line(x,y,x,y+h);
            line(x,y+h, x+w,y+h);

            textFont(dataFont);
            textAlign(LEFT,TOP);
            text(String.format("%.0f",xLow), x, y + h+20);
            text(String.format("%.0f",xHigh), x+w-10, y+h+20);

            textAlign(RIGHT, TOP);
            text(String.format("%.0f",yLow),x - 5,y+h - 5);
            text(String.format("%.0f",yHigh),x - 5,y);

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
                    text(String.format("%.0f",xVal), xLoc,y+h+13);
                }
                j++;
            }

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
                    text(String.format("%.0f",yVal), x, yLoc);
                }
                j++;
            }
        }
    }
}
