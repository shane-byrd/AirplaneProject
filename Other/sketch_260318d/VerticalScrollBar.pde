class VerticalScrollBar extends Widget
{
    color buttonColor;
    color scrollColor;
    float gapX;
    float gapY;
    float value;
    boolean click;
    VerticalScrollBar(float x, float y, float w, float h, String idLabel, color buttonColor, color scrollColor, float gapX, float gapY)
    {
        super(x,y,w,h,idLabel);
        click = true;
        value = 0;
        this.buttonColor = buttonColor;
        this.scrollColor = scrollColor;
        this.gapX = gapX;
        this.gapY = gapY;

    }

    void draw() {
        // Calculate value
        stroke(0);
        fill(scrollColor);
        rect(SCREENX - (2*gapX + w), 0, 2*gapX + w, SCREENY  );
        float yoffsetSpace = MAXYOFFSET-MINYOFFSET;
        float absoluteValue = YOFFSET-MINYOFFSET;
        if (absoluteValue == 0) {
            value = 0;
        }
        else {
            value = absoluteValue / yoffsetSpace;
        }
        
        // draw button
        fill(buttonColor);
        rect(SCREENX-gapX-w,gapY + value *(SCREENY - 2*gapY - h),w,h);
        x=SCREENX-gapX-w;
        y=gapY + value *(SCREENY - 2*gapY - h);
        //rect(SCREENX-gapX-w,gapY,w,h);
        noStroke();
        
    }

}
