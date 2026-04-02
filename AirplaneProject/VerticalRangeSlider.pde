
class VerticalRangeSlider extends Widget {
    float handleW;
    float handleH;

    color trackColor;
    color selectedTrackColor;
    color handleColor;
    color textColor;

    PFont sliderFont;

    float startValue;
    float endValue;

    boolean draggingStart;
    boolean draggingEnd;

    String displayLabel;
    float minDisplayValue;
    float maxDisplayValue;

    VerticalRangeSlider(
        float x, float y, float w, float h,
        String idLabel,
        float handleW, float handleH,
        color trackColor,
        color selectedTrackColor,
        color handleColor,
        color textColor,
        PFont sliderFont
    ) {
        super(x, y, w, h, idLabel);
        this.handleW = handleW;
        this.handleH = handleH;
        this.trackColor = trackColor;
        this.selectedTrackColor = selectedTrackColor;
        this.handleColor = handleColor;
        this.textColor = textColor;
        this.sliderFont = sliderFont;

        startValue = 0.0;
        endValue = 1.0;
        draggingStart = false;
        draggingEnd = false;
        displayLabel = "Visible";
        minDisplayValue = 0;
        maxDisplayValue = 1;
    }

    void draw() {
        stroke(0);
        float trackX = x + w/2 - 4;
        float trackW = 8;

        float lowerY = getStartHandleY();
        float upperY = getEndHandleY();

        fill(textColor);
        textFont(sliderFont);
        textAlign(LEFT, TOP);
        text(displayLabel + ": " + formatScaleValue(getDisplayStartValue()) + " - " + formatScaleValue(getDisplayEndValue()), x + 55, y + 30, 120, 40);

        fill(trackColor);
        rect(trackX, y, trackW, h, 5);

        fill(selectedTrackColor);
        rect(trackX, upperY + handleH/2, trackW, (lowerY - upperY), 5);

        fill(handleColor);
        rect(x + w/2 - handleW/2, lowerY, handleW, handleH, 6);
        rect(x + w/2 - handleW/2, upperY, handleW, handleH, 6);
        noStroke();
    }

    float getStartHandleY() {
        return y + h - handleH - startValue * (h - handleH);
    }

    float getEndHandleY() {
        return y + h - handleH - endValue * (h - handleH);
    }

    float getDisplayStartValue() {
        return minDisplayValue + startValue * (maxDisplayValue - minDisplayValue);
    }

    float getDisplayEndValue() {
        return minDisplayValue + endValue * (maxDisplayValue - minDisplayValue);
    }

    boolean overStartHandle() {
        float hx = x + w/2 - handleW/2;
        float hy = getStartHandleY();
        return mouseX >= hx && mouseX <= hx + handleW &&
               mouseY >= hy && mouseY <= hy + handleH;
    }

    boolean overEndHandle() {
        float hx = x + w/2 - handleW/2;
        float hy = getEndHandleY();
        return mouseX >= hx && mouseX <= hx + handleW &&
               mouseY >= hy && mouseY <= hy + handleH;
    }

    void press() {
        if (overStartHandle()) {
            draggingStart = true;
        } else if (overEndHandle()) {
            draggingEnd = true;
        }
    }

    void release() {
        draggingStart = false;
        draggingEnd = false;
    }

    boolean isDragging() {
        return draggingStart || draggingEnd;
    }

    void drag() {
        float raw = 1.0 - ((mouseY - y) / (h - handleH));
        raw = constrain(raw, 0, 1);

        if (draggingStart) {
            startValue = min(raw, endValue - 0.01);
            startValue = constrain(startValue, 0, 1);
        }

        if (draggingEnd) {
            endValue = max(raw, startValue + 0.01);
            endValue = constrain(endValue, 0, 1);
        }
    }
}
