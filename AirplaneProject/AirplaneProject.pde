// main file, written by Shane Byrd
//

import java.util.PriorityQueue;
import java.util.Queue;
import java.util.*;
import java.io.*;
import java.util.stream.Stream;


// screen size
final int SCREENX=1200;
final int SCREENY=800;

// track where the local screen is relative to global screen coordinates
int XOFFSET=0;
int YOFFSET=0;

// prevent scrolling outside of screen
int MINXOFFSET = 0;
int MAXXOFFSET = 100 * 19 - SCREENX;
int MINYOFFSET = 0;
int MAXYOFFSET = 50 * 2000;

// Define screens
Screen homeScreen;
Screen tableScreen;
Screen graphCreateScreen;
Screen graphShowScreen;
Screen barChartShowScreen;
Screen histogramShowScreen;
Screen filterDataScreen;
Screen piChartShowScreen;
Screen searchScreen;

Screen currentScreen;


//Define screen booleans
boolean OnHomeScreen = true;
boolean OnTableScreen = false;
boolean OnGraphCreateScreen = false;
boolean OnGraphShowScreen = false;
boolean OnbarChartShowScreen = false;
boolean OnFilterDataScreen = false;
boolean OnHistogramShowScreen = false;
boolean OnPiChartShowScreen = false;
boolean OnSearchScreen = false;

//constant UI
StaticRect navBar;
Button homeButton;

// shared UI
TextStore mouseGraphHolder;

// filter global variables
boolean filtersApplied = false;
boolean searchApplied = false;

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
String scatterTypeX;
String scatterTypeY;

// bar chart global variables
Map<String, Float> categoryMap = new HashMap<>();
float minBCval;
float maxBCval;
String yLabelBC;
String titleBC;
int showNumBC;
boolean ascendingBC;
List<Map.Entry<String, Float>> showBCdata;

// pi chart global variables
List<Map.Entry<String, Float>> piFreqData;
String titlePC;
float piTotal;

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
boolean searchOpen = true;
boolean searchActive = false;
float searchBoxX = 300;
float searchBoxY = 11.5;
float searchBoxW = 150;
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

// for use in mapping to other arrays
Integer[] indexValues = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17};
Integer[] monthIndex = {1,2,3,4,5,6,7,8,9,10,11,12};

// for determining which day of year
float[] daysInMonth = {0,31,28,31,30,31,30,31,31,30,31,30,31};

// array determines which data points are visible for table
boolean[] whichValues = {true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true};

// IDlabels for show drop down menu
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

// flight arrayLists
ArrayList<Flight> flights;              // unchanging
ArrayList<Flight> filteredFlights;      // changes based on filter
ArrayList<Flight> searchFlights;        // changes based on filtering, defaults to empty if no filter applied

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
    smallFont = loadFont("ArialUnicodeMS-14.vlw");
    mediumFont = loadFont("ArialUnicodeMS-24.vlw");
    largeFont = loadFont("ArialUnicodeMS-30.vlw");

    // load flights from file
    flights = readFromFile("flights10k.csv");
    filteredFlights = new ArrayList<Flight>(flights);
    searchFlights = new ArrayList<Flight>();


    homeButton = new Button(10,11.5,120,30,"homeB","Home Screen",
    color(#5a90d6),
    color(0),
    color(0),
    smallFont);

    // mouse location holder for graphs
    mouseGraphHolder = new TextStore(5, SCREENY-25, 300, 20,
    "mouseGraph","X-Value: , Y-Value: ",
    color(#e3bea6),
    smallFont);

    // error message
    currentError = new ErrorMessage(300,200, 400,300,"error",
    "This is a sample error message",
    "ERROR: ",
    smallFont,
    mediumFont,
    40
    );

    //nav bar at top of screen, always visible
    navBar = new StaticRect(0,0,SCREENX, 53, "topBar", color(#fffaed), false);
    navBar.strokeOn = true;

    //initialise and load screens
    homeScreen = new Screen();
    loadHomeScreen();
    tableScreen = new Screen();
    searchScreen = new Screen();
    loadTableScreen();
    loadSearchScreen();
    graphCreateScreen = new Screen();
    loadGraphCreateScreen();
    graphShowScreen = new Screen();
    loadGraphShowScreen();
    barChartShowScreen = new Screen();
    loadBarChartShowScreen();
    filterDataScreen = new Screen();
    loadFilterDataScreen();
    histogramShowScreen = new Screen();
    loadHistogramShowScreen();
    piChartShowScreen = new Screen();
    loadPiChartShowScreen();

    currentScreen = homeScreen;

    // initialise scatterplot data
    scatterPlotXData = new ArrayList<Float>();
    scatterPlotYData = new ArrayList<Float>();
    
    // set page limits for table screen
    updatePagination();
    updateVerticalLimit();

}

void draw() 
{   
    if (OnHomeScreen) {
        // draw coloured rounded squares around buttons
        background(#fcebfb);
        stroke(0);

        fill(#D4FCE4);
        rect(-100,140,980,148,90);

        fill(#bc85ff);
        rect(SCREENX/2 -280,290,980,148,90);

        fill(#f5bf82);
        rect(-100,440,980,148,90);

        fill(#c5edfa);
        rect(SCREENX/2 -280,590,980,148,90);
        noStroke();
    }
    // change background color for different screens
    else if (OnFilterDataScreen) {
        background(#f5d7bf);
    }
    else if (OnSearchScreen) {
        background(#d9ebfc);
    }
    else if (!OnTableScreen) {
        background(#d3bfe3);
    }
    else {
        background(#defadf);

    }
    if (OnSearchScreen) {
        if (searchFlights.size() == 0 && searchApplied == false) {
            fill(120);
            textFont(smallFont);
            textAlign(CENTER,CENTER);
            text("You have not searched anything yet",SCREENX/2,SCREENY/2);
        }
        if (searchFlights.size() == 0 && searchApplied == true) {
            fill(120);
            textFont(smallFont);
            textAlign(CENTER,CENTER);
            text("No entries match your search", SCREENX/2,SCREENY/2);
        }
    }

    // call currents screens draw function
    currentScreen.draw();

    if (OnTableScreen) {
        updatePagination();
        updateVerticalLimit();
        drawPageInfo();

    }
    if (OnSearchScreen) {
        drawSearchBox();
    }

    // draw axis scale controls for scatterplot, histogram and bar chart
    if (currentScreen == graphShowScreen) { 
        drawScatterPlotScaleControls(currentScreen);
    }
    if (currentScreen == histogramShowScreen) { 
        drawHistogramScaleControls(currentScreen);
    }
    if (currentScreen == barChartShowScreen) {
        drawBarChartScaleControls(currentScreen);
    }
    if (errorMessageActive) {
        currentError.draw();
    }


}


void keyPressed() {
    if (!errorMessageActive) {
        if (OnSearchScreen) {
            // deal with search screens various text fields
            if (searchActive)handleTextInputForSearch();
            else if (searchScreen.textEditMap.get("minDist").active) handleNumberInput("minDistance");
            else if (searchScreen.textEditMap.get("maxDist").active) handleNumberInput("maxDistance");
            else if (searchScreen.textEditMap.get("startTime").active) handleTimeInput("startTime");
            else if (searchScreen.textEditMap.get("endTime").active) handleTimeInput("endTime");
        }
        if (currentScreen.hasTextEdit && currentScreen.hasActiveTextField) {
            if (key == BACKSPACE) {
                // remove one character
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
                        // add character if it is alphanumeric or and the length is below max length
                        currentScreen.activeTextField.textLabel += key;
                    }
                }

            }
        }
        // handle scrolling
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
    currentScreen.updateMousePress();

    // update scroll and slider click state
    if (currentScreen.hasHorizontalScroll) {
        currentScreen.hscroll.click = currentScreen.hscroll.cursorOverWidget(); 
    }
    if (currentScreen.hasVerticalScroll) {
        currentScreen.vscroll.click = currentScreen.vscroll.cursorOverWidget(); 
    }
    if (currentScreen.hasRangeSlider) {
        currentScreen.rangeSlider.release();
    }
}

void mouseReleased() {
    if (errorMessageActive) {
        if (currentError.cursorOverWidget()) {
            errorMessageActive = false;
        }

    }
    else {
        if (currentScreen.hasHorizontalScroll) {
            currentScreen.hscroll.click = false; 
        }
        if (currentScreen.hasVerticalScroll) {
            currentScreen.vscroll.click = false;   
        }
        if (currentScreen.hasRangeSlider) {
            currentScreen.rangeSlider.release();
        }
        currentScreen.updateMouseReleased();

        // handle each screens logic
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
        if (OnbarChartShowScreen) {
            barChartShowScreenPress();
        }
        if (OnFilterDataScreen) {
            filterDataScreenPress();
        }
        if (OnHistogramShowScreen) {
            histogramShowScreenPress();
        }
        if (OnPiChartShowScreen) {
            piChartShowScreenPress();
        }
        if (OnSearchScreen) {
            searchScreenPress();
            searchActive = overSearchBox();
        }
    

    }

}
void mouseWheel(MouseEvent event) {
    // change the y or x offset
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
        currentScreen.updateHighlights();

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


void mouseMoved() {
    currentScreen.updateHighlights();
    // update mouse label for bar chart, scatterplot or histogram
    if (currentScreen.hasBarChart) {
        currentScreen.barChart.updateMouse();
    }
    if (currentScreen.hasScatterPlot) {
        currentScreen.scatterPlot.updateMouse(minXsp,maxXsp,minYsp,maxYsp);
    }
    if (currentScreen.hasHistogram) {
        currentScreen.histogram.updateMouse(minValueHistogram,maxValueHistogram,minfreqHistogram,maxfreqHistogram);
    }
}

