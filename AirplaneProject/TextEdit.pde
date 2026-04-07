// class for a text input field where you can enter text
// written by Shane Byrd
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


/*
void drawSearchBox() {
  stroke(0);

  if (searchActive) {
    fill(#ffffff);
    stroke(#125ab8);
  } else {
    fill(#f7f7f7);
    stroke(120);
  }

  rect(searchBoxX, searchBoxY, searchBoxW, searchBoxH, 6);

  fill(80);
  textFont(smallFont);
  textAlign(LEFT, CENTER);

  if (searchText.equals("")) {
    text("Search...", searchBoxX + 8, searchBoxY + searchBoxH/2);
  } else {
    text(searchText, searchBoxX + 8, searchBoxY + searchBoxH/2);
  }
*/
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
            //fill(textLabelColor);
            fill(80);
            textFont(buttonFont);
            textAlign(CENTER,CENTER);
            
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