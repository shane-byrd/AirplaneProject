class DropDown extends Widget
{
    boolean openW;
    ArrayList<Button> selectionButtons;
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
    DropDown(float x, float y, float w, float h, String idLabel, String textLabel, color buttonColor, color textLabelColor, PFont buttonFont, float gapY, float gapX, color backgroundColor, color topButtonColor, color secondaryButtonColor)
    {
        super(x,y,w,h,idLabel);
        openW = false;
        buttonAmount = 0;
        selectionButtons = new ArrayList<Button>();
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

    // for drawing buttons with boolean array determining whether buttons use primary or secondary color
    void draw(boolean[] whichValues) {
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            rect(x-gapX,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +gapY );
            int i = 0;
            for (Button b : selectionButtons) {
                b.draw(whichValues[i]);
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

    // for drawing with primary color only
    void draw() {
        // draw buttons if open
        if (openW == true) {
            // draw background
            fill(backgroundColor);
            rect(x-gapX,y-gapY,w+2*gapX,(buttonAmount +1 ) * (h + gapY) +gapY );

            for (Button b : selectionButtons) {
                b.draw();
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
                println(b.idLabel);
                return b.idLabel;
            }
        }
        return "None";
    }

}