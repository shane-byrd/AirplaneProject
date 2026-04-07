// class for a drop down within a drop down, written by Shane Byrd
//
class InteriorDropDown extends DropDown
{
    InteriorDropDown(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color textLabelColor, PFont buttonFont, float gapY, float gapX, color backgroundColor, color topButtonColor, color secondaryButtonColor)
    {
        super(x, y, w,  h, idLabel, textLabel, buttonColor, textLabelColor, buttonFont, gapY, gapX, backgroundColor, topButtonColor, secondaryButtonColor);
        openW = false;
        buttonAmount = 0;
        selectionButtons = new ArrayList<Button>();
        bottomY = y;
    }
    void addButton(String buttonLabel, String buttonText) {

        Button b = new Button(x+w+2*gapX,bottomY,w,h,buttonLabel,buttonText, buttonColor, secondaryButtonColor, textLabelColor, buttonFont);
        bottomY += h + gapY;
        selectionButtons.add(b);
        buttonAmount++;
    }
    void addInterioDropDown(String buttonLabel, String buttonText) {
        InteriorDropDown i = new InteriorDropDown(x+w+2*gapX, bottomY, w, h, buttonLabel, buttonText, buttonColor, textLabelColor, buttonFont, gapY, gapX, backgroundColor, topButtonColor, secondaryButtonColor);
        bottomY += h + gapY;
        sIDD.add(i);
        buttonAmount++;
    }


    // for drawing with primary color only
    void draw() {
        if (border) {
            stroke(0);
        }
        else {
            noStroke();
        }
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            stroke(0);
            noStroke();
            strokeWeight(strokeWidth);
            rect(x+w+gapX,y-gapY,w+2*gapX,(buttonAmount) * (h + gapY) +2*gapY ,2);

            for (Button b : selectionButtons) {
                b.draw();
            }
            for (InteriorDropDown idd : sIDD) {
                idd.draw();
            }
        }

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
                fill(interiorSideColor);
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
                fill(interiorSideColor);
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
    String whichButtonOver() {
        for (Button b : selectionButtons) {
            if (b.cursorOverWidget()) {
                return b.idLabel;
            }
        }
        return "None";
    }
    boolean overBackGround() {
        return (mouseX > x - gapX &&
        mouseX < x + gapX + w &&
        mouseY > y-gapY &&
        mouseY > bottomY);
    }
}