// represents the proportions of a data type (eg airlines) using Pi Chart
//
class PiChart extends Graph {
    color dataColor;
    float r;
    color[] colorArray;
    PiChart(float x, float y, float w, float h, float r, PFont titleFont, PFont dataFont, color[] colorArray) {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;
        this.colorArray = colorArray;
        this.r = r;
    }

    void draw() {
        
        float startAngle = 0;
        int order = 0;
        fill(245);
        stroke(0);
        rect(x, y, w, h);

        fill(0);
        textAlign(LEFT,TOP);
        textFont(titleFont);
        text(titlePC, x+5,y+5);
        textFont(dataFont);


        for (Map.Entry<String, Float> entry : piFreqData) {
            float val = entry.getValue();
            float angle = map(val, 0, piTotal, 0, TWO_PI);
            if ((val/piTotal)*100.0f < 1.5) {
                // draw greyed out segment when the percentage becomes too low

                float left = 100 - map(startAngle, 0, TWO_PI, 0, 100);
                fill(200);
                arc((x+(w/2)), (y+(h/2)), r, r, startAngle, TWO_PI);
                float midAngle = startAngle + (TWO_PI - startAngle)/2;
                float tr = r / 2;
                float otr = r / 2;
                tr *= 1.1;

                float tx = x+(w/2) + cos(midAngle) * tr;
                float ty = y+(h/2) + sin(midAngle) * tr;
                float otx = x+(w/2) + cos(midAngle) * otr;
                float oty = y+(h/2) + sin(midAngle) * otr;

                // draw line to text
                fill(0);
                line(tx,ty, otx, oty);
                textAlign(LEFT, BOTTOM);
                fill(0);
                text("Other: "+String.format("%.2f",left)+"%", tx, ty);

                return;

            }
            fill(colorArray[order]);

            // draw segment
            arc((x+(w/2)), (y+(h/2)), r, r, startAngle, startAngle + angle);

            // calculate angle to display label at
            float midAngle = startAngle + angle / 2;

            // change text align depending on what part of the circle it is at
            if (midAngle > HALF_PI && midAngle < PI+QUARTER_PI) {
                textAlign(RIGHT, CENTER);
            }
            if (midAngle < HALF_PI) {
                textAlign(LEFT, CENTER);
            }
            if (midAngle > PI+HALF_PI) {
                textAlign(LEFT, BOTTOM);
            }

            // draw line from segment to label
            float tr = r / 2;
            float otr = tr;
            tr *= 1.1;
            float tx = x+(w/2) + cos(midAngle) * tr;
            float ty = y+(h/2) + sin(midAngle) * tr;
            float otx = x+(w/2) + cos(midAngle) * otr;
            float oty = y+(h/2) + sin(midAngle) * otr;
            line(tx,ty, otx, oty);

            // draw label
            fill(0);
            text(entry.getKey()+String.format(" %.2f",(val/piTotal)*100.0)+"%", tx, ty);

            // increase the start angle by the abngle
            startAngle += angle;

            // modulo the order so that the color loops
            order ++;
            order %= colorArray.length;
        }
        
    }
}