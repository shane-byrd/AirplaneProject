import java.util.PriorityQueue;
import java.util.Queue;
import java.util.*;
import java.io.*;

// screen size
final int SCREENX=1200;
final int SCREENY=800;

// track where the local screen is relative to global screen coordinates
int XOFFSET=0;
int YOFFSET=0;

// prevent scrolling outside of screen
int MINXOFFSET = 0;
int MAXXOFFSET = 80 * 20;
int MINYOFFSET = 0;
int MAXYOFFSET = 50 * 2000;

// Define screens
Screen homeScreen;
Screen tableScreen;
Screen graphCreateScreen;
Screen graphShowScreen;
Screen barGraphShowScreen;

Screen currentScreen;


//Define screen booleans
boolean OnHomeScreen = true;
boolean OnTableScreen = false;
boolean OnGraphCreateScreen = false;
boolean OnGraphShowScreen = false;
boolean OnBarGraphShowScreen = false;

//constant UI
DropDown visualiseSelect;
StaticRect navBar;
    
// scatterPlot global variables
ArrayList<Float> scatterPlotXData;
ArrayList<Float> scatterPlotYData;
String spXlabel;
String spYlabel;
String spTitle;
float minXsp;
float maxXsp;
float minYsp;
float maxYsp;
boolean GRAPH_ACTIVE = false;

// fonts
PFont smallFont;
PFont mediumFont;
PFont largeFont;

// title of each column for table data
String[] titleData = 
    {
        "Date", "Airline", "Flight Number",
        "Dep. Airport", "Dep. City", "Dep. State", "Dep. WAC", 
        "Dest. Airport", "Dest. City", "Dest. State", "Dest. WAC", 
        "STD", "ATD", "STA", "ATA", "Cancelled", "Diverted", "Distance"
    };
Integer[] indexValues = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17};

// for determining which day of year
float[] daysInMonth = {0,31,28,31,30,31,30,31,31,30,31,30,31};

// array determines which data points are visible for table
boolean[] whichValues = {true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true};

//IDlabels for show menu
String[] showMenuLabels = 
    {
        "showdate","showairline","showFlightNumber",
        "showOA","showOC", "showOS","showOW",
        "showDA","showDC", "showDS","showDW",
        "showSDT","showADT","showSAT","showAAT",
        "showCancelled", "showDiverted", "showDistance"
    };

//map from showmenu ID labels to indexValues
HashMap showLabelToIndex = StringToIntegerMap(showMenuLabels, indexValues);
ArrayList<Flight> flights;

void settings() 
{
    size(SCREENX,SCREENY);
}

void setup() 
{
    // load fonts
    smallFont = loadFont("Baghdad-14.vlw");
    mediumFont = loadFont("Baghdad-24.vlw");
    largeFont = loadFont("Baghdad-30.vlw");

    // load flights from file
    flights = readFromFile("flights10k.csv");

    // select visualisation button is always visible
    visualiseSelect = new DropDown(10,11.5,150,30,"whichV","Pick Visualisation", 
        color(#5a90d6), // Button Color
        color(#000000), // text Color
        smallFont,        // Font Type
        3,6,              // xgap, ygap
        color(#a8ceff), // background color
        color(#125ab8), // top button
        color(#c25151)  // secondary button
        );
    visualiseSelect.addButton("vtable","Table");
    visualiseSelect.addButton("vgraph","Graph");

    //nav bar is alwats visible
    navBar = new StaticRect(0,0,SCREENX, 53, "topBar", color(#fffaed), false);

    //initialise and load screens
    homeScreen = new Screen();
    loadHomeScreen();
    tableScreen = new Screen();
    loadTableScreen();
    graphCreateScreen = new Screen();
    loadGraphCreateScreen();
    graphShowScreen = new Screen();
    loadGraphShowScreen();
    barGraphShowScreen = new Screen();
    loadBarGraphShowScreen();

    currentScreen = homeScreen;

    

    // initialise scatterplot data
    scatterPlotXData = new ArrayList<Float>();
    scatterPlotYData = new ArrayList<Float>();
    


}

void draw() 
{
    background(200);
    currentScreen.draw();
    visualiseSelect.draw();
}


void keyPressed() {
    boolean offsetChange = false;
    if (currentScreen.hasVerticalScroll) {
        if (keyCode == UP) {
            YOFFSET-=3;
            offsetChange = true;
        }
        if (keyCode == DOWN) {
            YOFFSET+=3;
            offsetChange = true;
        }
    }
    if (currentScreen.hasHorizontalScroll) {
        if(keyCode==LEFT) {
            XOFFSET-=5;
            offsetChange = true;
        }
        if (keyCode == RIGHT) {
            XOFFSET+=5;
            offsetChange = true;
        }
    }
    if (offsetChange) {
        clampScroll();
    }
  

}

void mousePressed() {
    if (OnHomeScreen) {
        homeScreenPress();
    }
    if (OnTableScreen) {
        tableScreenPress();
    }
    if (OnGraphCreateScreen) {
        graphCreateScreenPress();
    }
    if (OnGraphShowScreen) {
        graphShowScreenPress();
    }
    if (OnBarGraphShowScreen) {
        graphShowScreenPress();
    }
}
void mouseReleased() {
    if (currentScreen.hasHorizontalScroll) {
        currentScreen.hscroll.click = false; 
    }
    if (currentScreen.hasVerticalScroll) {
        currentScreen.vscroll.click = false;   
    }
    if (currentScreen.hasRangeSlider) {
        currentScreen.rangeSlider.release();
    }
}
void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    if (currentScreen.hasHorizontalScroll) {
        if (keyPressed && keyCode == SHIFT) {
            XOFFSET += 2*e;
        }
    }
    if (currentScreen.hasVerticalScroll) {
        if (!keyPressed) {
            YOFFSET+= 2*e;
        }
    }
    clampScroll();
}
void mouseDragged() {
    if (currentScreen.hasRangeSlider) {
        currentScreen.rangeSlider.drag();
    }
    if (currentScreen.hasVerticalScroll) {
        if (currentScreen.vscroll.click ){
        // calculate new Y offset based off of mouse position
            YOFFSET = int(MINYOFFSET + ((mouseY-currentScreen.vscroll.h/2 + currentScreen.vscroll.gapY)/(SCREENY - 2*currentScreen.vscroll.gapY - currentScreen.vscroll.h))*(MAXYOFFSET-MINYOFFSET));
            clampScroll();
        }
    }
    if (currentScreen.hasHorizontalScroll) {
        if (currentScreen.hscroll.click) {
        // calculate new X offset based off of mouse position
            XOFFSET = int(MINXOFFSET + ((mouseX - currentScreen.hscroll.gapX)/(SCREENX - (currentScreen.hscroll.h + 2*currentScreen.hscroll.gapX) - currentScreen.hscroll.gapX - currentScreen.hscroll.w)*(MAXXOFFSET-MINXOFFSET)));
            clampScroll();
        }
    }
}
