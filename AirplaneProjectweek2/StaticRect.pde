class StaticRect extends Widget {
    color rectColor;
    boolean strokeOn;
    StaticRect(float x, float y, float w, float h, String idLabel, color rectColor, boolean strokeOn) {
        super(x,y,w,h,idLabel);
        this.rectColor = rectColor;
    }
    void draw() {
        if (strokeOn) {
            stroke(0);
        }
        else {
            noStroke();
        }
        fill(rectColor);
        rect(x,y,w,h);
    }
}