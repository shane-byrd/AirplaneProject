// abstract class for scatterplot, histogram and bar chart, written by Shane Byrd
abstract class Graph
{
    float x,y,w,h;
    PFont titleFont, dataFont;
    Graph(float x, float y, float w, float h, PFont titleFont, PFont dataFont)
    {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.titleFont = titleFont;
        this.dataFont = dataFont;

    }
}