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

        bottomY = y + h + gapY;
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
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            rect(x-gapX,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +gapY );
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
        fill(topButtonColor);
        rect(x,y,w,h);

        // draw text
        fill(textLabelColor);
        textFont(buttonFont);
        textAlign(CENTER,CENTER);
        text(textLabel, x+ w/2, y + h/2);


    }

    void draw() {
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            rect(x-gapX,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +gapY );

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
        // draw button
        fill(topButtonColor);
        rect(x,y,w,h);

        // draw text
        fill(textLabelColor);
        textFont(buttonFont);
        textAlign(CENTER,CENTER);
        text(textLabel, x+ w/2, y + h/2);


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
        mouseY > bottomY);
    }

}