
class BarChart extends Graph {
    color dataColor;
    float gapX;

    BarChart(float x, float y, float w, float h, PFont titleFont, PFont dataFont, color dataColor, float gapX) {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;
        this.gapX = gapX;
    }

    void draw() {
        float extraspace = 1.2;
        float backspace = 0.1;
        float ySpan = safeAxisSpan(minBCval, maxBCval);

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
        textAlign(LEFT, TOP);
        text(yLabelBC, x - (w* backspace), y-20);

        fill(0);
        float yDiv = bestDivider(minBCval, maxBCval);
        textAlign(RIGHT,BOTTOM);
        float j = 0;
        if (yDiv > 0.0) {
        while (true) {
            float yVal = minBCval + yDiv * j;
            if (yVal > maxBCval) {
                break;
            }
            float yLoc = y + h - h*((yVal - minBCval)/ySpan);
            if (Math.abs(yLoc - y) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                stroke(220);
                line(x, yLoc, x+w, yLoc);
                stroke(0);
                line(x, yLoc, x-10, yLoc);
                text(String.format("%.0f", yVal), x, yLoc);
            }
            j++;
        }
        }
        else {
                textAlign(CENTER,CENTER);
                fill(0);
                text("There is no data to show",x+w/2,y+h/2);
        }

        textAlign(CENTER, TOP);

        if (showBCdata == null || showBCdata.size() == 0) {
            stroke(0);
            line(x,y,x,y+h);
            line(x,y+h, x+w,y+h);
            return;
        }

        int startIndex = constrain(barChartVisibleStartIndex, 0, max(showBCdata.size() - 1, 0));
        int endIndex = constrain(barChartVisibleEndIndexExclusive, startIndex + 1, showBCdata.size());
        int visibleCount = max(1, endIndex - startIndex);
        float width = (w / visibleCount) - gapX;

        int localIndex = 0;
        for (int i = startIndex; i < endIndex; i++) {
            Map.Entry<String, Float> entry = showBCdata.get(i);
            float val = constrain(entry.getValue(), minBCval, maxBCval);
            float valX = gapX + (width + gapX) * localIndex;
            float locX = valX + x;
            float rectH = h*(val - minBCval)/ySpan;
            stroke(0);
            fill(dataColor);
            rect(locX, y+h - rectH, width, rectH);
            fill(0);
            text(entry.getKey(), locX + width/2, y+h+5);
            localIndex++;
        }

        stroke(0);
        line(x,y,x,y+h);
        line(x,y+h, x+w,y+h);
    }
}
