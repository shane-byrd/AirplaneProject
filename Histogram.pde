
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

        fill(255);
        rect(x - w*backspace,y - h*backspace, extraspace*w, extraspace*h);
        fill(0);

        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*backspace + 5);
        
        textFont(dataFont);
        textAlign(RIGHT, TOP);
        fill(150);
        text(yLabel, x + w + (w* backspace)-10, y + h+30);

        fill(150);
        textFont(dataFont);
        textAlign(CENTER, TOP);
        text("Frequency", x - (w* backspace/2), y-24);

        stroke(220);
        fill(0);
        float yDiv = bestDivider(lowestFrequency, highestFrequency);
        textAlign(RIGHT,BOTTOM);
        float j = 0;
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
                line(x, yLoc, x-10, yLoc);
                text(String.format("%.0f",yVal), x, yLoc);
            }
            j++;
        }

        for (int i = 0; i < frequencyData.length; i++) {
            float binLow = histogramRawMinX + intervalWidth * i;
            float binHigh = binLow + intervalWidth;
            if (binHigh < lowest || binLow > highest) {
                continue;
            }

            float clippedLow = max(binLow, lowest);
            float clippedHigh = min(binHigh, highest);
            float locX = x + w * ((clippedLow - lowest) / xSpan);
            float rectW = max(1, w * ((clippedHigh - clippedLow) / xSpan));
            float freq = constrain(frequencyData[i], lowestFrequency, highestFrequency);
            float rectH = h * ((freq - lowestFrequency) / ySpan);

            fill(dataColor);
            stroke(0);
            rect(locX, y + h - rectH, rectW, rectH);

            if (i % 3 == 0) {
                fill(0);
                line(locX, y+h, locX, y+h+10);
                String valueFormat = getCorrectFormat(binLow, type);
                textAlign(CENTER, TOP);
                text(valueFormat, locX, y+h+15);
            }
        }

        fill(0);
        stroke(0);
        line(x,y,x,y+h);
        line(x,y+h, x+w,y+h);
        textAlign(LEFT,TOP);
        text(getCorrectFormat(lowest, type), x, y+h+20);
        textAlign(RIGHT,TOP);
        text(getCorrectFormat(highest, type), x+w, y+h+20);
    }
}
