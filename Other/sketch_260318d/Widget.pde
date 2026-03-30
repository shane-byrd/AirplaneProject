abstract class Widget
{
    float x, y, w, h;
    String idLabel;
    Widget(float x, float y, float w, float h, String idLabel)
    {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.idLabel = idLabel;
    }
    boolean cursorOverWidget() {
        return (mouseX > x && mouseX < x + w &&
        mouseY > y && mouseY < y + h);
    }

    abstract void draw();
}
