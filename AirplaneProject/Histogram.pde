// code for displaying a frequency graph, written by Shane Byrd
//
class Histogram extends Graph {
    color dataColor;

    Histogram(float x, float y, float w, float h, PFont titleFont, PFont dataFont, color dataColor) {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;
    }

    float getIntervalWidth(float binAmount, float lowest, float highest) {
        return (highest - lowest) / binAmount;
    }

    void draw(int[] frequencyData, float lowest, float highest, int lowestFrequency, int highestFrequency, String titleText, String yLabel, float intervalWidth, String type) {
        noStroke();
        float backspace = 0.1;
        float extraspace = 1.2;
        float xSpan = safeAxisSpan(lowest, highest);
        float ySpan = safeAxisSpan(lowestFrequency, highestFrequency);

        // draw background
        fill(255);
        rect(x - w*backspace,y - h*backspace, extraspace*w, extraspace*h);
        fill(0);

        // draw title
        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*backspace + 5);
        
        // draw ylabel
        textFont(dataFont);
        textAlign(RIGHT, TOP);
        fill(150);
        text(yLabel, x + w + (w* backspace)-10, y + h+30);

        // draw frequency label
        fill(150);
        textFont(dataFont);
        textAlign(CENTER, TOP);
        text("Frequency", x - (w* backspace/2), y-24);

        // draw horizontal gridlines
        stroke(220);
        fill(0);
        float yDiv = bestDivider(lowestFrequency, highestFrequency);
        textAlign(RIGHT,BOTTOM);
        float j = 0;
        if (yDiv > 0.0) {
        while (true) {
            float yVal = lowestFrequency + yDiv * j;
            if (yVal > highestFrequency) {
                break;
            }
            float yLoc = y + h - h*((yVal - lowestFrequency)/ySpan);
            if (Math.abs(yLoc - y) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                stroke(220);
                line(x, yLoc, x+w, yLoc);
                stroke(0);

                // draw grid labels
                line(x, yLoc, x-10, yLoc);
                text(String.format("%.0f",yVal), x, yLoc);
            }
            j++;
        }
        }
        else {
                textAlign(CENTER,CENTER);
                fill(0);
                text("There is no data to show",x+w/2,y+h/2);
        }

        // draw each bar
        for (int i = 0; i < frequencyData.length; i++) {
            float binLow = histogramRawMinX + intervalWidth * i;
            float binHigh = binLow + intervalWidth;
            if (binHigh < lowest || binLow > highest) {
                continue;
            }
            // mingqi additions
            float clippedLow = max(binLow, lowest);
            float clippedHigh = min(binHigh, highest);
            float locX = x + w * ((clippedLow - lowest) / xSpan);
            float rectW = max(1, w * ((clippedHigh - clippedLow) / xSpan));
            float freq = constrain(frequencyData[i], lowestFrequency, highestFrequency);
            float rectH = h * ((freq - lowestFrequency) / ySpan);
            // end of mingqi additions

            fill(dataColor);
            stroke(0);
            rect(locX, y + h - rectH, rectW, rectH);

            // only draw value every 3 ticks
            if (i % 4 == 0) {
                fill(0);
                line(locX, y+h, locX, y+h+10);
                String valueFormat = getCorrectFormat(binLow, hsType);
                textAlign(CENTER, TOP);
                text(valueFormat, locX, y+h+15);
            }
        }

        fill(0);
        stroke(0);
        // draw x and y axis
        line(x,y,x,y+h);
        line(x,y+h, x+w,y+h);

        // draw lowest value
        textAlign(LEFT,TOP);
        text(getCorrectFormat(lowest, hsType), x, y+h+30);

        // draw highest value
        textAlign(RIGHT,TOP);
        text(getCorrectFormat(highest, hsType), x+w-70, y+h+30);
    }
    void updateMouse(float lowest, float highest, float lowestFrequency, float highestFrequency) {
        // update mouse Label
        if (mouseX > x && mouseX < x + w 
        && mouseY > y && mouseY < y + h) {
            float xVal = lowest + ((mouseX - x)/w) * (highest - lowest);
            float yVal = lowestFrequency + ((h-(mouseY - y))/h) * (highestFrequency - lowestFrequency);
            mouseGraphHolder.textLabel = "X-value: "+getCorrectFormat(xVal,hsType)+", Y-value: "+getCorrectFormat(yVal,hsType);
        }
        else {
            mouseGraphHolder.textLabel = "X-value: , Y-value: ";
        }
    }
}
