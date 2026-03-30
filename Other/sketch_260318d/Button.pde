class Button extends Widget
{
    String textLabel;
    color buttonColor;
    color textLabelColor;
    color secondaryButtonColor;
    PFont buttonFont;
    Button(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color secondaryButtonColor, color textLabelColor, PFont buttonFont)
    {
        super(x,y,w,h,idLabel);
        this.textLabel = textLabel;
        this.buttonColor = buttonColor;
        this.textLabelColor = textLabelColor;
        this.buttonFont = buttonFont;
        this.secondaryButtonColor = secondaryButtonColor;
    }

    // for drawing only with primary color
    void draw() {

        // draw button
        fill(buttonColor);
        rect(x,y,w,h);

        // draw text
        fill(textLabelColor);
        textFont(buttonFont);
        textAlign(CENTER,CENTER);
        text(textLabel, x+ w/2, y + h/2);
    }

    // for drawing with secondary color option
    void draw(boolean whichColor) {

        // draw button
        if (whichColor) {
            fill(buttonColor);
        }
        else {
            fill(secondaryButtonColor);
        }
        
        rect(x,y,w,h);

        // draw text
        fill(textLabelColor);
        textFont(buttonFont);
        textAlign(CENTER,CENTER);
        text(textLabel, x+ w/2, y + h/2);
    }
}
