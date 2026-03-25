class TextEdit extends Widget
{
    String textLabel;
    color buttonColor;
    color textLabelColor;
    color secondaryButtonColor;
    PFont buttonFont;
    boolean active;
    int maxLength;
    TextEdit(float x, float y, float w, float h, String idLabel, color buttonColor, color secondaryButtonColor, color textLabelColor, PFont buttonFont, int maxLength)
    {
        super(x,y,w,h,idLabel);
        active = false;
        textLabel = "";
        this.buttonColor = buttonColor;
        this.textLabelColor = textLabelColor;
        this.buttonFont = buttonFont;
        this.secondaryButtonColor = secondaryButtonColor;
        this.maxLength = maxLength;
    }

    void draw() {
        if (visible) {
                if (active) {
                    
                    int interval = 1000;
                    boolean firstPeriod = (millis()/ interval % 2 == 0);
                    if (firstPeriod) {
                        stroke(#FFFFFF);
                    }
                    else {
                        stroke(#279af2);
                    }
                }
                else {
                    noStroke();

                }
                fill(buttonColor);
                // draw button
                rect(x,y,w,h);

                // draw text
                fill(textLabelColor);
                textFont(buttonFont);
                textAlign(CENTER,CENTER);
                text(textLabel, x+ w/2, y + h/2);

        }


    }


}