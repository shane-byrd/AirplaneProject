// class for a text input field where you can enter text
// written by Jasper (Xubo)
class TextEdit extends Widget
{
    String textLabel;
    String defaultText;
    color buttonColor;
    color textLabelColor;
    color secondaryButtonColor;
    PFont buttonFont;
    boolean active;
    int maxLength;
    TextEdit(float x, float y, float w, float h, String idLabel, color buttonColor, color secondaryButtonColor, color textLabelColor, PFont buttonFont, int maxLength, String defaultText)
    {
        super(x,y,w,h,idLabel);
        active = false;
        textLabel = "";
        this.buttonColor = buttonColor;
        this.textLabelColor = textLabelColor;
        this.buttonFont = buttonFont;
        this.secondaryButtonColor = secondaryButtonColor;
        this.maxLength = maxLength;
        this.defaultText = defaultText;
    }


    void draw() {
        if (visible) {

            if (active) {
                fill(#ffffff);
                stroke(#125ab8);
            } else {
                fill(#f7f7f7);
                stroke(120);
            }

            // draw button
            rect(x,y,w,h,6);

            // draw text
            fill(80);
            textFont(buttonFont);
            textAlign(CENTER,CENTER);
            
            // if there is no text, draw the defualt text
            if (textLabel.equals("")) {
                text(defaultText, x+ w/2, y + h/2);
            }
            else {
                text(textLabel, x+ w/2, y + h/2);
            }
        }
        noStroke();
    }
    
}