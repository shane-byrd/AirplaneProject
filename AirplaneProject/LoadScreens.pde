String[][] chooseGraphScatterPlotX = {
    {"scxDistance","Distance"},
    {"scxDuration","Duration"},{"scxYear","Time (year)"}
};
String[][] chooseGraphScatterPlotInteriorX = {
    {"scxDelay","Delay Time >"},
    {"scxDay","Time (day) >"}
};
String[][] chooseGraphScatterPlotY = {
    {"scyDistance","Distance"},
    {"scyDuration","Duration"},{"scyYear","Time (year)"}
};
String[][] chooseGraphScatterPlotInteriorY = {
    {"scyDelay","Delay Time >"},
    {"scyDay","Time (day) >"}
};
String[][] chooseGraphBarChartCat = {
    {"bcDate","Date"}, {"bcMonth","Month"},
    {"bcSeason","Season"},{"bcAirport","Airport"},
    {"bcAirline","Airline"},{"bcCity","City"},
    {"bcState","State"},
};
String[][] chooseGraphBarChartData = {
    {"bcDist","Mean Distance"}, {"bcDelay","Mean delay time"},
    {"bcDuration","Mean flight duration"},{"bcDiverted","% Diverted"},
    {"bcCancelled","% Cancelled"}
};

void loadHomeScreen() {
    homeScreen.staticRects.add(navBar);
}
void loadTableScreen() {
    tableScreen.staticRects.add(navBar);
    tableScreen.hasHorizontalScroll = true;
    tableScreen.hasVerticalScroll = true;
    tableScreen.hasTable = true;
    Table table = new Table(0,50,flights.size(),18,100,30,2,2,
        color(#D4FCE4),  // background color
        color(#9AD6B1),  // cell color
        color(#2B9453),  // title color
        smallFont);
    tableScreen.table = table;

    tableScreen.minXOffset = 0;
    tableScreen.maxXOffset = 80 * 15;
    tableScreen.minYOffset = 0;
    tableScreen.maxYOffset = 50 * flights.size();

    VerticalScrollBar vscroll = new VerticalScrollBar(0, 0, 20, 80, "vscroll", color(#c25151), color(#f5b8b8), 3, 3);
    HorizontalScrollBar hscroll = new HorizontalScrollBar(0, 0, 80, 20, "hscroll", color(#c25151), color(#f5b8b8), 3, 3);
    tableScreen.hscroll = hscroll;
    tableScreen.vscroll = vscroll;

    DropDown showMenu = new DropDown(
            170,11.5,100,30,"show","Show", 
        color(#5a90d6), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#a8ceff), // background color
        color(#125ab8), // top button
        color(#c25151)  // secondary button
        );
        showMenu.addButton("showdate", "Date");
        showMenu.addButton("showairline", "Airline");
        showMenu.addButton("showFlightNumber", "Flight Number");

        showMenu.addButton("showOA", "Dep. Airport");
        showMenu.addButton("showOC", "Dep. City");
        showMenu.addButton("showOS", "Dep. State");
        showMenu.addButton("showOW", "Dep. WAC");

        showMenu.addButton("showDA", "Dest. Airport");
        showMenu.addButton("showDC", "Dest. City");
        showMenu.addButton("showDS", "Dest. State");
        showMenu.addButton("showDW", "Dest. WAC");
        
        showMenu.addButton("showSDT", "STD");
        showMenu.addButton("showADT", "ATD");
        showMenu.addButton("showSAT", "STA");
        showMenu.addButton("showAAT", "ATA");

        showMenu.addButton("showCancelled", "Cancelled");
        showMenu.addButton("showDiverted", "Diverted");
        showMenu.addButton("showDistance", "Distance");
    showMenu.changingButtonColor = true;
    showMenu.colorController = whichValues;

    // Jasper (Xubo):
    DropDown sortMenu = new DropDown(
        280,11.5,200,30,"sort","Sort", 
    color(#5a90d6), // Button Color
    color(#000000), // text Color
    smallFont,
    3,6,            // xgap, ygap
    color(#a8ceff), // background color
    color(#125ab8), // top button
    color(#c25151)  // secondary button
    );
    sortMenu.addButton("airlineAsc", "Airline Ascending");
    sortMenu.addButton("airlineDesc", "Airline Descending");
    sortMenu.addButton("distanceAsc", "Distance Ascending");
    sortMenu.addButton("distanceDesc", "Distance Descending");
    sortMenu.addButton("depAsc", "Departure Time Ascending");
    sortMenu.addButton("depDesc", "Departure Time Descending");
    sortMenu.addButton("arrAsc", "Arrival Time Ascending");
    sortMenu.addButton("arrDesc", "Arrival Time Descending");
    // Jasper (Xubo)

    tableScreen.addDropDownMenu(showMenu);
    tableScreen.addDropDownMenu(sortMenu);
}
void loadGraphCreateScreen() {
    graphCreateScreen.staticRects.add(navBar);
    DropDown grcMenu = new DropDown(100,200,250,50,"chooseGraph","Choose Graph Type",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );

    grcMenu.addButton("bcOption","Bar Chart");
    grcMenu.addButton("scOption","Scatter Plot");

    DropDown xDDM = new DropDown(400,200,250,50,"scXData","X-axis data",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    for (String[] s : chooseGraphScatterPlotX) {
        xDDM.addButton(s[0],s[1]);
    }
    
    for (String[] s : chooseGraphScatterPlotInteriorX) {
        xDDM.addInterioDropDown(s[0],s[1]);
    }
    xDDM.sIDD.get(0).addButton("scxDepDelay","Departure Delay");
    xDDM.sIDD.get(0).addButton("scxArrDelay","Arrival Delay");
    xDDM.sIDD.get(1).addButton("scxDaySchedDep","Scheduled Departure");
    xDDM.sIDD.get(1).addButton("scxDayActualDep","Actual Departure");
    xDDM.sIDD.get(1).addButton("scxDaySchedArr","Scheduled Arrival");
    xDDM.sIDD.get(1).addButton("scxDayActualArr","Actual Arrival");

    DropDown yDDM = new DropDown(700,200,250,50,"scYData","Y-axis data",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );

    for (String[] s : chooseGraphScatterPlotY) {
        yDDM.addButton(s[0],s[1]);
    }
    for (String[] s : chooseGraphScatterPlotInteriorY) {
        yDDM.addInterioDropDown(s[0],s[1]);
    }
    yDDM.sIDD.get(0).addButton("scyDepDelay","Departure Delay");
    yDDM.sIDD.get(0).addButton("scyArrDelay","Arrival Delay");
    yDDM.sIDD.get(1).addButton("scyDaySchedDep","Scheduled Departure");
    yDDM.sIDD.get(1).addButton("scyDayActualDep","Actual Departure");
    yDDM.sIDD.get(1).addButton("scyDaySchedArr","Scheduled Arrival");
    yDDM.sIDD.get(1).addButton("scyDayActualArr","Actual Arrival");
    
    Button loadGraph = new Button(500,70,100,45,"loadGraph", "Create Graph",
    color(#9657df), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    Button graphTypeholder = new Button(100, 130, 250, 50, "typeGraphHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    Button graphFirstHolder = new Button(400, 130, 250, 50, "fstDataHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    Button graphSecondHolder = new Button(700, 130, 250, 50, "scndDataHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    StaticRect behindR = new StaticRect(90,120,800, 120,
    "behindLabel",
    color(#7c588a),
    true);
    //graphCreateScreen.addStaticRect(behindR);

    graphCreateScreen.addDropDownMenu(grcMenu);
    graphCreateScreen.addDropDownMenu(xDDM);
    graphCreateScreen.addDropDownMenu(yDDM);
    graphCreateScreen.addButton(loadGraph);
    graphCreateScreen.addButton(graphTypeholder);
    graphCreateScreen.addButton(graphFirstHolder);
    graphCreateScreen.addButton(graphSecondHolder);
}
void loadGraphShowScreen() {
    graphShowScreen.staticRects.add(navBar);
    graphShowScreen.hasScatterPlot = true;
    ScatterPlot sp = new ScatterPlot(100,120,900,570, mediumFont, smallFont, 5,color(#FF0000));
    graphShowScreen.scatterPlot = sp; 

    Button backButton = new Button(1100, 57, 50, 50, "backW", "Back",
    color(#9657df), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    graphShowScreen.addButton(backButton);
}

void loadBarGraphShowScreen() {
    barGraphShowScreen.hasBarGraph = true;
    barGraphShowScreen.staticRects.add(navBar);
    BarGraph barGraph = new BarGraph(60, 100, SCREENX - 140, SCREENY - 170, flights, mediumFont, smallFont);
    barGraphShowScreen.barGraph = barGraph;
}