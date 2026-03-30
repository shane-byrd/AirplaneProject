class HorizontalScrollBar extends Widget
{
    color buttonColor;
    color scrollColor;
    float gapX;
    float gapY;
    float value;
    boolean click;
    HorizontalScrollBar(float x, float y, float w, float h, String idLabel, color buttonColor, color scrollColor, float gapX, float gapY)
    {
        super(x,y,w,h,idLabel);
        value = 0;
        click = false;
        this.buttonColor = buttonColor;
        this.scrollColor = scrollColor;
        this.gapX = gapX;
        this.gapY = gapY;

    }

    void draw() {
        // draw background
        stroke(0);
        fill(scrollColor);
        rect(0, SCREENY - (2 * gapY + h), SCREENX, 2*gapY + h);

        //calculate percentage value (0 - 1)
        float xoffsetSpace = MAXXOFFSET-MINXOFFSET;
        float absoluteValue = XOFFSET-MINXOFFSET;
        if (absoluteValue == 0) {
            value = 0;
        }
        else {
            value = absoluteValue / xoffsetSpace;
        }

        // draw button based on value
        fill(buttonColor);
        rect(gapX + value*(SCREENX - (h + 2*gapX) - gapX - w),SCREENY- h - gapY,w,h);
        x = gapX + value*(SCREENX - (h + 2*gapX) - gapX - w);
        y = SCREENY- h - gapY;
        noStroke();
    }

}
