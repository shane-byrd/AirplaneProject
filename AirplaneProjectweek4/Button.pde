class Button extends Widget
{
    String textLabel;
    color buttonColor;
    color textLabelColor;
    color secondaryButtonColor;
    PFont buttonFont;

    boolean pressed;
    boolean mouseOver;
    boolean active;
    int strokeWidth;
    float xDepth;
    float yDepth;
    color sideColor;
    color secondarySideColor;
    Button(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color secondaryButtonColor, color textLabelColor, PFont buttonFont)
    {
        super(x,y,w,h,idLabel);
        this.textLabel = textLabel;
        this.buttonColor = buttonColor;
        this.textLabelColor = textLabelColor;
        this.buttonFont = buttonFont;
        this.secondaryButtonColor = secondaryButtonColor;

        this.sideColor = color(red(buttonColor)*.8,green(buttonColor)*.8,blue(buttonColor)*.8);
        this.secondarySideColor = color(red(secondaryButtonColor)*.8,green(secondaryButtonColor)*.8,blue(secondaryButtonColor)*.8);

        this.xDepth = 4;
        this.yDepth = 4;
        this.strokeWidth = 1;
        this.pressed = false;
        this.mouseOver = false;
        this.active = true;
    }

    // for drawing only with primary color
    void draw() {
        if (visible) {
            strokeWeight(strokeWidth);
            if (!active) {

                stroke(0);
                fill(color(#adadae));
                rect(x-xDepth,y+yDepth,w,h);
                fill(220);
                textFont(buttonFont);
                textAlign(CENTER,CENTER);
                text(textLabel, x+ w/2-xDepth, y + h/2 + yDepth);
            }
            else if (pressed) {
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
                    noStroke();
                    strokeWeight(strokeWidth);
                    fill(sideColor);
                    quad(x,y, x,y+h+1, x-xDepth,y+h+yDepth, x-xDepth,y+yDepth);
                    quad(x,y+h, x+w,y+h, x+w-xDepth,y+h+yDepth, x-xDepth,y+h+yDepth);
                    fill(buttonColor);
                    rect(x,y,w,h);
                    fill(0);
                    textFont(buttonFont);
                    textAlign(CENTER,CENTER);
                    text(textLabel, x+ w/2, y + h/2);
                }
            }
            noStroke();
            /*
            // draw button
            fill(buttonColor);
            rect(x,y,w,h,6);

            // draw text
            fill(textLabelColor);
            textFont(buttonFont);
            textAlign(CENTER,CENTER);
            text(textLabel, x+ w/2, y + h/2);
            */
        }


    }

    // for drawing with secondary color option
    void draw(boolean whichColor) {
        if (visible) {
        color colorToUse;
        color sideColorToUse;
        // draw button
        if (whichColor) {
            colorToUse = buttonColor;
            sideColorToUse = sideColor;
        }
        else {

            colorToUse = secondaryButtonColor;
            sideColorToUse = secondarySideColor;
        }
        
            strokeWeight(strokeWidth);
            if (pressed) {
                stroke(220);
                fill(colorToUse);
                rect(x-xDepth,y+yDepth,w,h);
                fill(220);
                textFont(buttonFont);
                textAlign(CENTER,CENTER);
                text(textLabel, x+ w/2-xDepth, y + h/2 + yDepth);
            }
            else {
                if (mouseOver) {
                    stroke(220);
                    fill(sideColorToUse);
                    quad(x,y, x,y+h, x-xDepth,y+h+yDepth, x-xDepth,y+yDepth);
                    quad(x,y+h, x+w,y+h, x+w-xDepth,y+h+yDepth, x-xDepth,y+h+yDepth);
                    fill(colorToUse);
                    rect(x,y,w,h);
                    fill(220);
                    textFont(buttonFont);
                    textAlign(CENTER,CENTER);
                    text(textLabel, x+ w/2, y + h/2);
                }
                else {
                    stroke(0);
                    noStroke();
                    strokeWeight(strokeWidth);
                    fill(sideColorToUse);
                    quad(x,y, x,y+h+1, x-xDepth,y+h+yDepth, x-xDepth,y+yDepth);
                    quad(x,y+h, x+w,y+h, x+w-xDepth,y+h+yDepth, x-xDepth,y+h+yDepth);
                    fill(colorToUse);
                    rect(x,y,w,h);
                    fill(0);
                    textFont(buttonFont);
                    textAlign(CENTER,CENTER);
                    text(textLabel, x+ w/2, y + h/2);
                }
            }
            noStroke();
        }
    }
}