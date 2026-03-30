class PressButton extends Widget
{
    String textLabel;
    color buttonColor;
    
    color sideColor;
    color otherSideColor;
    float xDepth;
    float yDepth;
    int strokeWidth;
    boolean pressed;
    boolean mouseOver;
    PFont buttonFont;
    PressButton(float x, float y, float w, float h, float xDepth, float yDepth, String idLabel, String textLabel, color buttonColor, color sideColor, color otherSideColor, PFont buttonFont)
    {
        super(x,y,w,h,idLabel);
        this.textLabel = textLabel;
        this.buttonColor = buttonColor;
        this.sideColor = sideColor;
        this.otherSideColor = otherSideColor;
        this.buttonFont = buttonFont;
        this.xDepth = xDepth;
        this.yDepth = yDepth;
        this.strokeWidth = 1;
    }

    // for drawing only with primary color
    void draw() {
        if (visible) {
            strokeWeight(strokeWidth);
            if (pressed) {
                stroke(220);
                fill(buttonColor);
                rect(x-xDepth,y+yDepth,w,h);
                fill(220);
                textFont(buttonFont);
                textAlign(CENTER,CENTER);
                text(textLabel, x+ w/2-xDepth, y + h/2 + yDepth);
            }
            else {
                if (mouseOver) {
                    stroke(220);
                    fill(sideColor);
                    quad(x,y, x,y+h, x-xDepth,y+h+yDepth, x-xDepth,y+yDepth);
                    fill(otherSideColor);
                    quad(x,y+h, x+w,y+h, x+w-xDepth,y+h+yDepth, x-xDepth,y+h+yDepth);
                    fill(buttonColor);
                    rect(x,y,w,h);
                    fill(220);
                    textFont(buttonFont);
                    textAlign(CENTER,CENTER);
                    text(textLabel, x+ w/2, y + h/2);
                }
                else {
                    stroke(0);
                    strokeWeight(strokeWidth);
                    fill(sideColor);
                    quad(x,y, x,y+h+1, x-xDepth,y+h+yDepth, x-xDepth,y+yDepth);
                    fill(otherSideColor);
                    quad(x,y+h, x+w,y+h, x+w-xDepth,y+h+yDepth, x-xDepth,y+h+yDepth);
                    fill(buttonColor);
                    rect(x,y,w,h);
                    fill(0);
                    textFont(buttonFont);
                    textAlign(CENTER,CENTER);
                    text(textLabel, x+ w/2, y + h/2);
                }


            }


        }

    noStroke();
    strokeWeight(1);
    }

}