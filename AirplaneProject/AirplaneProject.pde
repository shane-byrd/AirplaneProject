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
Screen barChartShowScreen;
Screen barGraphShowScreen;
Screen histogramShowScreen;
Screen filterDataScreen;

Screen currentScreen;


//Define screen booleans
boolean OnHomeScreen = false;
boolean OnTableScreen = true;
boolean OnGraphCreateScreen = false;
boolean OnGraphShowScreen = false;
boolean OnbarChartShowScreen = false;
boolean OnBarGraphShowScreen = false;
boolean OnFilterDataScreen = false;
boolean OnHistogramShowScreen = false;
//constant UI
DropDown visualiseSelect;
StaticRect navBar;

// shared UI
Button filterDataChange;

// filter global variables
boolean filtersApplied = false;

// error global variable
boolean errorMessageActive = false;
ErrorMessage currentError;
    
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

// bar chart global variables
Map<String, Float> categoryMap = new HashMap<>();
float minBCval;
float maxBCval;
String yLabelBC;
String titleBC;
int showNumBC;
boolean ascendingBC;
List<Map.Entry<String, Float>> showBCdata;

// histogram gloval variables
ArrayList<Float> histogramData;
int[] intervalFrequencyData;
float minValueHistogram;
float maxValueHistogram;
int minfreqHistogram;
int maxfreqHistogram;
float histogramBinAmount;
String histogramTitle;
String histogramYLabel;
float intervalWidthHistogram;
String hsType;


// search global variables
boolean searchOpen = false;
boolean searchActive = false;
float searchBoxX = 976;
float searchBoxY = 11.5;
float searchBoxW = 120;
float searchBoxH = 30;
String searchText = "";
String selectedColumn = "All";

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
Integer[] monthIndex = {1,2,3,4,5,6,7,8,9,10,11,12};

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
ArrayList<Flight> filteredFlights;

// pagination
int tableAmount = 1000;
int currentPage = 0;
int totalPages = 1;


void settings() 
{
    size(SCREENX,SCREENY);
}

void setup() 
{
    // load fonts
    /*
    smallFont = loadFont("Baghdad-14.vlw");
    mediumFont = loadFont("Baghdad-24.vlw");
    largeFont = loadFont("Baghdad-30.vlw");
    */
    smallFont = loadFont("ArialUnicodeMS-14.vlw");
    mediumFont = loadFont("ArialUnicodeMS-24.vlw");
    largeFont = loadFont("ArialUnicodeMS-30.vlw");
    // load flights from file
    flights = readFromFile("flights2k2.csv");
    filteredFlights = new ArrayList<Flight>(flights);

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

    filterDataChange = new Button(SCREENX-10-70-20, 11.5, 70, 30, "filterChange", "Filter Data",
    color(#e37d30), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );



    // error message
    currentError = new ErrorMessage(300,200, 400,300,"error",
    "This is a sample error message",
    "ERROR: ",
    smallFont,
    mediumFont,
    40
    );
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
    barChartShowScreen = new Screen();
    loadBarChartShowScreen();
    filterDataScreen = new Screen();
    loadFilterDataScreen();
    histogramShowScreen = new Screen();
    loadHistogramShowScreen();

    currentScreen = tableScreen;

    

    // initialise scatterplot data
    scatterPlotXData = new ArrayList<Float>();
    scatterPlotYData = new ArrayList<Float>();
    
    updatePagination();
    updateVerticalLimit();

}

void draw() 
{
    background(200);
    currentScreen.draw();
    if (OnTableScreen) {
        updatePagination();
        updateVerticalLimit();
        drawPageInfo();
        if (searchOpen) {
            drawSearchBox();
        }
    }

    visualiseSelect.draw();
    if (errorMessageActive) {
        currentError.draw();
    }

}


void keyPressed() {
    if (!errorMessageActive) {

        if (OnTableScreen && searchActive) {
            handleTextInputForSearch();
            return;
        }
        if (currentScreen.hasTextEdit && currentScreen.hasActiveTextField) {
            if (key == BACKSPACE) {
                if (currentScreen.activeTextField.textLabel.length() > 0) {
                    currentScreen.activeTextField.textLabel =
                        currentScreen.activeTextField.textLabel.substring(
                            0,
                            currentScreen.activeTextField.textLabel.length() - 1
                        );
                }
            } else {
                if ((key >= 'A' && key <= 'Z') ||
                    (key >= 'a' && key <= 'z') ||
                    (key >= '0' && key <= '9') ||
                    key == ' ' || key == '/') {
                    if (currentScreen.activeTextField.textLabel.length() < currentScreen.activeTextField.maxLength) {
                        currentScreen.activeTextField.textLabel += key;
                    }
                }

            }
        }

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

  

}

void mousePressed() {
    if (errorMessageActive) {
        if (currentError.cursorOverWidget()) {
            errorMessageActive = false;
        }

    }
    else {
        if (OnHomeScreen) {
            homeScreenPress();
        }
        if (OnTableScreen) {
            tableScreenPress();
            if (searchOpen) searchActive = overSearchBox();
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
        if (OnbarChartShowScreen) {
            barChartShowScreenPress();
        }
        if (OnFilterDataScreen) {
            filterDataScreenPress();
        }
        if (OnHistogramShowScreen) {
            histogramShowScreenPress();
        }
    }

}
void mouseReleased() {
    if (!errorMessageActive) {
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

}
void mouseWheel(MouseEvent event) {
    if (!errorMessageActive) {
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

}
void mouseDragged() {
    if (!errorMessageActive) {
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

}


