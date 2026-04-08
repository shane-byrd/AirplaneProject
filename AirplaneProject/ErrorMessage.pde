// class for displaying an error message, written by Shane Byrd
//
class ErrorMessage extends Widget
{
    String textLabel;
    String titleText;
    PFont textFont;
    PFont titleFont;
    float cross;
    ErrorMessage(float x, float y, float w, float h, String idLabel, String textLabel, String titleText, PFont textFont, PFont titleFont, float cross)
    {
        super(x,y,w,h,idLabel);
        this.titleText = titleText;
        this.textLabel = textLabel;
        this.textFont = textFont;
        this.titleFont = titleFont;
        this.cross = cross;
    }

    // for drawing only with primary color
    void draw() {
        if (visible) {
            int interval = 500;
            boolean firstPeriod = (millis()/ interval % 2 == 0);
            
            // draw button
            fill(#db3737);
            rect(x,y,w,h);
            stroke(0);
            strokeWeight(2);
            rect(x,y,w,h/5);

            if (firstPeriod) {
                stroke(#FFFFFF);
            }
            else {
                stroke(0);
            }


            // draw text
            if (firstPeriod) {
                fill(0);
            }
            else {
                fill(#FFFFFF);
            }
            textFont(textFont);
            textAlign(CENTER,CENTER);
            text(textLabel, x+w/2,y+100);

            textAlign(CENTER,CENTER);
            textFont(titleFont);
            text(titleText, x + w/2 - cross/2, y +h/10);

            // draw x
            fill(#db3737);
            stroke(0);
            strokeWeight(2);
            rect(x+(w-cross)-8,y+8,cross,cross);
            strokeWeight(4);
            line(x+(w-cross) + 4 - 8, y+4 + 8, x+w-4 - 8,y+cross-4 + 8);
            line(x+(w-cross) + 4-8,y+cross-4+8, x+w-4-8, y+4+8);
            strokeWeight(1);
        }
    }
    @Override
    // only return true if its over the cross
    boolean cursorOverWidget() {
        return (mouseX > x+(w-cross) && mouseX < x + w &&
        mouseY > y && mouseY < y + cross);
    }
}