// class to draw text (useful for avoiding overlap)
// written By Shane Byrd
class TextBox {
    float x;
    float y;
    String textLabel;
    String idLabel;
    PFont textFont;
    color textColor;
    boolean visible;

    TextBox(float x, float y, String textLabel, String idLabel, PFont textFont) {
        this.x = x;
        this.y = y;
        this.textLabel = textLabel;
        this.textFont = textFont;
        this.idLabel = idLabel;
        visible = true;
    }
    void draw() {
        if (visible) {
            textAlign(LEFT,TOP);
            fill(textColor);
            textFont(textFont);
            text(textLabel,x,y);
        }
    }
}