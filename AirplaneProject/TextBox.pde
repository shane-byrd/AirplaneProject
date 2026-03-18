class TextBox {
    float x;
    float y;
    String textLabel;
    PFont textFont;
    color textColor;

    TextBox(float x, float y, String textLabel, PFont textFont) {
        this.x = x;
        this.y = y;
        this.textLabel = textLabel;
        this.textFont = textFont;
    }
    void draw() {
        fill(textColor);
        textFont(textFont);
        text(textLabel,x,y);
    }
}