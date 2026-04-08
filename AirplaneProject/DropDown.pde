// Class for drop down button, written by Shane Byrd 
//
class DropDown extends Widget
{
    boolean openW;
    ArrayList<Button> selectionButtons;
    ArrayList<InteriorDropDown> sIDD;
    String textLabel;
    color buttonColor;
    color textLabelColor;
    color backgroundColor;
    color topButtonColor;
    color secondaryButtonColor;
    PFont buttonFont;
    float bottomY;
    float gapY;
    float gapX;
    float buttonAmount;
    boolean changingButtonColor;
    boolean[] colorController;
    boolean border;

    boolean pressed;
    boolean mouseOver;
    int strokeWidth;
    float xDepth;
    float yDepth;
    color sideColor;
    color interiorSideColor;

    DropDown(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color textLabelColor, PFont buttonFont, float gapY, float gapX, color backgroundColor, color topButtonColor, color secondaryButtonColor)
    {
        super(x,y,w,h,idLabel);

        //assume colors don't change by default
        changingButtonColor = false;
        openW = false;
        buttonAmount = 0;
        selectionButtons = new ArrayList<Button>();
        sIDD = new ArrayList<InteriorDropDown>();
        this.gapY = gapY;
        this.textLabel = textLabel;
        this.buttonColor = buttonColor;
        this.topButtonColor = topButtonColor;
        this.textLabelColor = textLabelColor;
        this.buttonFont = buttonFont;
        this.backgroundColor = backgroundColor;
        this.gapX = gapX;
        this.secondaryButtonColor = secondaryButtonColor;
        border = false;
        bottomY = y + h + gapY;

        // set side colour to 80% as light by defualt unless overriden
        this.sideColor = color(red(topButtonColor)*.8,green(topButtonColor)*.8,blue(topButtonColor)*.8);
        this.interiorSideColor = color(red(buttonColor)*.8,green(buttonColor)*.8,blue(buttonColor)*.8);
        this.xDepth = 5;
        this.yDepth = 5;
        this.strokeWidth = 1;
        this.pressed = false;
        this.mouseOver = false;

    }
    void addButton(String buttonLabel, String buttonText) {

        Button b = new Button(x,bottomY,w,h,buttonLabel,buttonText, buttonColor, secondaryButtonColor, textLabelColor, buttonFont);
        bottomY += h + gapY;
        selectionButtons.add(b);
        buttonAmount++;
    }
    void addInterioDropDown(String buttonLabel, String buttonText) {
        InteriorDropDown i = new InteriorDropDown(x, bottomY, w, h, buttonLabel, buttonText, buttonColor, textLabelColor, buttonFont, gapY, gapX, backgroundColor, topButtonColor, secondaryButtonColor);
        bottomY += h + gapY;
        sIDD.add(i);
        buttonAmount++;
    }
    void addInterioDropDown(InteriorDropDown idd) {
        bottomY += h + gapY;
        sIDD.add(idd);
        buttonAmount++;
    }

    // for drawing buttons with boolean array determining whether buttons use primary or secondary color
    void draw(boolean[] whichValues) {
        if (border) {
            stroke(0);
        }
        else {
            noStroke();
        }
        if (visible) {
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            stroke(0);
            noStroke();
            strokeWeight(strokeWidth);
            rect(x-gapX-3,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +2*gapY,2 );
            int i = 0;
            for (InteriorDropDown idd : sIDD) {
                idd.draw();
            }
            for (Widget b : selectionButtons) {
                ((Button) b).draw(whichValues[i]);
                i++;
            }
        }
        // draw top button
        strokeWeight(strokeWidth);
        if (pressed) {
            stroke(220);
            fill(topButtonColor);
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
                fill(topButtonColor);
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

        }

    }

    void draw() {
            if (border) {
            stroke(0);
        }
        else {
            noStroke();
        }
        if (visible) {
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            stroke(0);
            noStroke();
            strokeWeight(strokeWidth);
            rect(x-gapX-3,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +2*gapY,2 );

            for (InteriorDropDown idd : sIDD) {
                idd.draw();
            }

            if (changingButtonColor) {
                int i = 0;
                for (Button b : selectionButtons) {
                    b.draw(colorController[i]);
                    i++;
                }
            }
            else {
                for (Button b : selectionButtons) {
                    b.draw();
                }
            }


        }
        strokeWeight(strokeWidth);
        // draw top button
        if (pressed) {
            stroke(220);
            fill(topButtonColor);
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
                fill(topButtonColor);
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
                fill(topButtonColor);
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
    String whichButtonOver() {
        for (Button b : selectionButtons) {
            if (b.cursorOverWidget()) {
                return b.idLabel;
            }
        }
        for (InteriorDropDown idd : sIDD) {
            if (idd.cursorOverWidget()) {
                return idd.idLabel;
            }
        }
        return "None";
    }
    boolean overBackGround() {
        return (mouseX > x - gapX &&
        mouseX < x + gapX + w &&
        mouseY > y-gapY &&
        mouseY < bottomY);
    }

}