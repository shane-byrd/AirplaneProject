class ScatterPlot extends Graph
{
    float pointRadius;
    color dataColor;

    ScatterPlot(float x, float y, float w, float h, PFont titleFont, PFont dataFont, float pointRadius, color dataColor)
    {
        super(x,y,w,h,titleFont,dataFont);
        this.pointRadius = pointRadius;
        this.dataColor = dataColor;


    }
    void draw(ArrayList<Float> xData, ArrayList<Float> yData, float xLow, float xHigh, float yLow, float yHigh, String titleText, String xLabel, String yLabel) {
        noStroke();
        float backspace = 0.1;
        float extraspace = 1.2;

        //draw background rectangle
        fill(255);
        rect(x - w*.1,y - h*.1, 1.2*w, 1.2*h);
        fill(0);

        //draw title
        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*.1 + 5);
        
        //draw yLabel
        fill(150);
        textFont(dataFont);
        textAlign(LEFT, TOP);
        text(yLabel, x - (w* backspace)+3, y - 20);

        //draw xLabel
        textAlign(RIGHT, TOP);
        text(xLabel, x + w + (w* backspace)-10, y + h+30);

        ellipseMode(CENTER);
        if (xData.size() == yData.size()) {
            noStroke();
            for (int i = 0; i < xData.size(); i++) {
                fill(dataColor);
                ellipse(x + w*((xData.get(i) - xLow))/(xHigh-xLow), y + h - h*((yData.get(i) - yLow)/(yHigh-yLow)), pointRadius,pointRadius);
            }
            fill(0);
            stroke(0);
            // vertical line
            line(x,y,x,y+h);

            // horizontal line
            line(x,y+h, x+w,y+h);

            textFont(dataFont);
            textAlign(LEFT,TOP);

            // draw x axis labels
            text(String.format("%.0f",xLow), x, y + h+20);
            text(String.format("%.0f",xHigh), x+w, y+h);

            //draw y axis labels
            textAlign(RIGHT, TOP);
            text(String.format("%.0f",yLow),x,y+h);
            text(String.format("%.0f",yHigh),x,y);

            float xDiv = bestDivider(xLow, xHigh);
            //draw gridlines
            int j = 1;
            stroke(220);
            textAlign(CENTER,TOP);
            // draw x gridlines
            while (true) {
                float xVal = xLow + xDiv * j;
                if (xVal > xHigh) {
                    break;
                } 
                float xLoc = x + w*((xVal - xLow))/(xHigh-xLow);
                if (Math.abs(xLoc - (x)) > 40 && Math.abs(xLoc - (x+w)) > 40) {
                    stroke(220);
                    line(xLoc,y+h, xLoc, y );

                    // draw graduations
                    stroke(0);
                    line(xLoc, y+h, xLoc, y+h+10);

                    text(String.format("%.0f",xVal), xLoc,y+h+13);
                }
                
                j++;
            }
            //draw y gridlines
            float yDiv = bestDivider(yLow, yHigh);
            textAlign(RIGHT,BOTTOM);
            j = 0;
            while (true) {
                float yVal = yLow + yDiv * j;
                if (yVal > yHigh) {
                    break;
                } 
                float yLoc = y + h - h*((yVal - yLow)/(yHigh-yLow));
                if (Math.abs(yLoc - (y)) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                    stroke(220);
                    line(x, yLoc, x+w, yLoc);

                    // draw gruduations
                    stroke(0);
                    line(x, yLoc, x-10, yLoc);

                    //draw label value
                    text(String.format("%.0f",yVal), x, yLoc);
                }


                j++;
            }
        }
    }
}