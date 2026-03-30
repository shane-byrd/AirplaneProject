class Histogram extends Graph
{
    color dataColor;

    Histogram(float x, float y, float w, float h, PFont titleFont, PFont dataFont, color dataColor)
    {
        super(x,y,w,h,titleFont,dataFont);
        this.dataColor = dataColor;


    }
    void draw(int[] frequencyData, float lowest, float highest, int lowestFrequency, int highestFrequency, String titleText, String yLabel,float intervalWidth,String type) {
        noStroke();
        float backspace = 0.1;
        float extraspace = 1.2;

        //draw background rectangle
        fill(255);
        rect(x - w*backspace,y - h*backspace, extraspace*w, extraspace*h);
        fill(0);

        //draw title
        textAlign(LEFT, TOP);
        textFont(titleFont);
        text(titleText,x,y - h*backspace + 5);
        
        textFont(dataFont);
        //draw xLabel
        textAlign(RIGHT, TOP);
        fill(150);
        text(yLabel, x + w + (w* backspace)-10, y + h+30);

        //draw y label
        fill(150);
        textFont(dataFont);
        textAlign(CENTER, TOP);
        text("Frequency", x - (w* backspace/2), y-24);


        noStroke();
        fill(dataColor);
        float width = (w/frequencyData.length);
        int i = 0;
        stroke(0);

        stroke(220);
        textAlign(CENTER,TOP);
            //draw gridlines
            fill(0);
            float yDiv = bestDivider(lowestFrequency, highestFrequency);
            textAlign(RIGHT,BOTTOM);
            float j = 0;
            while (true) {
                float yVal = lowestFrequency + yDiv * j;
                if (yVal > highestFrequency) {
                    break;
                } 
                //float yLoc = y + h - h*((yVal - minBCval)/(maxBCval-minBCval));
                float yLoc = y + h - h*((yVal - lowestFrequency))/(highestFrequency - lowestFrequency);
                if (Math.abs(yLoc - (y)) > 10 && Math.abs(yLoc - (y+h)) > 10) {
                    stroke(220);
                    line(x, yLoc, x+w, yLoc);
                    stroke(0);
                    line(x, yLoc, x-10, yLoc);
                    

                    text(String.format("%.0f",yVal), x, yLoc);
                }
                j++;
            }

        for (float freq : frequencyData) {
  
            float valX = (width) * i;
            float locX = valX + x;
            if (i%3 == 0 && i != 0) {
                fill(0);
                line(locX,y+h,locX,y+h+10);

                String valueFormat = getCorrectFormat((lowest+intervalWidth*i),hsType);
                text(valueFormat,locX,y+h+15);
            }  
            fill(dataColor);
            rect(locX, y+h - h*(freq - lowestFrequency)/(highestFrequency - lowestFrequency), width, h*(freq - lowestFrequency)/(highestFrequency - lowestFrequency));
            i++;
        }
        fill(0);
        stroke(0);
        // vertical line
        line(x,y,x,y+h);

        // horizontal line
        line(x,y+h, x+w,y+h);

        textFont(dataFont);
        //draw y axis labels
        textAlign(RIGHT, TOP);
        text(lowestFrequency,x-5,y+h);
        text(highestFrequency,x,y-10);


    }

    float getIntervalWidth(float binAmount, float min, float max) {
        float iwS = (w) / binAmount;
        float intervalWidthValue = ((iwS * (max - min)) / w) + min;
        return ((max-min)/binAmount);
        

    }

}