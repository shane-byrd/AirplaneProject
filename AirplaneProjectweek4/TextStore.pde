class TextStore extends Widget
{
    String textLabel;
    color buttonColor;
    PFont buttonFont;
    String buttonIdStore;
    TextStore(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, PFont buttonFont)
    {
        super(x,y,w,h,idLabel);
        this.textLabel = textLabel;
        this.buttonColor = buttonColor;
        this.buttonFont = buttonFont;
        this.buttonIdStore = "";
    }

    // for drawing only with primary color
    void draw() {
        if (visible) {
            stroke(0);

            // draw button
            fill(buttonColor);
            rect(x,y,w,h,6);

            // draw text
            fill(0);
            textFont(buttonFont);
            textAlign(CENTER,CENTER);
            text(textLabel, x+ w/2, y + h/2);
            noStroke();
        }
    }
}