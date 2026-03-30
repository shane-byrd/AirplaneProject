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
    {"bcAirport","Airport >"},
    {"bcCity","City >"},
    {"bcState","State >"}
};
String[][] chooseGraphBarChartData = {
    {"bcdDist","Mean Distance"}, {"bcdDelay","Mean delay time"},
    {"bcdDuration","Mean flight duration"},{"bcdDiverted","% Diverted"},
    {"bcdCancelled","% Cancelled"},{"bcdfreq","Frequency"}
};
String[][] chooseHistoGramX = {
    {"hsgdDuration","Duration"},{"hsgdDistance","Distance"}
    //{"hsgdDate","Date"}
};
String[][] chooseHistoGramXIDD = {
    {"hsgdDelayTime","Delay Time"},{"hsgdTime","Time of Day"}
};
/*
String[][] filterNumOption = {
    {"filNumDistance","Distance"},
    {"filNumYear","Year"}
};
*/
String[][] filterNumOption = {
    {"filNumDistance","Distance"},
    {"filNumYear","Date"}
};

String[][] filterNumOptionIDD = {
    {"filNumDelay","Delay >"},
    {"filNumTime","Time of day >"}
};

String[][] filterNonNumOption = {
    {"filNonAirport","Airport >"},
    {"filNonState","State >"},{"filNonCity","City >"}
};
String[] monthsStringArray = {
    "January","February","March","April",
    "May","June","July","August",
    "September","October","November","December"
};
HashMap monthMap = StringToIntegerMap(monthsStringArray, monthIndex);
Set<String> monthSet = new HashSet<>(Arrays.asList(monthsStringArray));


void loadHomeScreen() {
    homeScreen.staticRects.add(navBar);
    homeScreen.hasTextEdit = true;
    TextEdit te = new TextEdit(400,500,300,120, "teid",
    color(#64da78),
    color(#64da78),
    color(0),
    smallFont,
    144);
    homeScreen.addTextEdit(te);
    RangeSlider rs = new RangeSlider(200,SCREENY/2, 600,50,"rs",
    5,5,
    12,12,
    color(#64da78),
    color(#db4e47),
    color(#2c77c1),
    color(0),
    smallFont
    );
    homeScreen.addButton(filterDataChange);
    homeScreen.hasRangeSlider = true;
    homeScreen.rangeSlider = rs;
    /*
    RangeSlider(
        float x, float y, float w, float h,
        String idLabel,
        float gapX, float gapY,
        float handleW, float handleH,
        color trackColor,
        color selectedTrackColor,
        color handleColor,
        color textColor,
        PFont sliderFont
    )
    */
}
void loadTableScreen() {
    tableScreen.staticRects.add(navBar);
    tableScreen.addButton(filterDataChange);
    tableScreen.hasHorizontalScroll = true;
    tableScreen.hasVerticalScroll = true;
    tableScreen.hasTable = true;

    Button prevPageButton = new Button(
        750, 3, 80, 22, "prevPage", "Previous",
        color(#5a90d6), color(#c25151), color(#000000), smallFont
    );

    Button nextPageButton = new Button(
        835, 3, 80, 22, "nextPage", "Next",
        color(#5a90d6), color(#c25151), color(#000000), smallFont
    );
    tableScreen.addButton(nextPageButton);
    tableScreen.addButton(prevPageButton);
    Button clearButton = new Button(
        792.5, 27, 80, 22, "clearButton", "Clear",
        color(#c25151), color(#c25151), color(#000000), smallFont
    );
    tableScreen.addButton(clearButton);
    clearButton.visible = true;
    Table table = new Table(0,50,tableAmount + 1,18,100,30,2,2,
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
    Button searchOpen = new Button(
        920,11.5,50,30,
        "searchOption", "Search",
    color(#ffe666),
    color(#f7edbc),
    color(#000000),
    smallFont
    );
    tableScreen.addButton(searchOpen);
    DropDown filterColumnMenu = new DropDown(
    975, 11.5, 120, 30, "filterColumn", "Filter: All",
    color(#ffe666),
    color(#000000),
    smallFont,
    3, 6,
    color(#f7edbc),
    color(#ffe600),
    color(#c25151)
    );

    filterColumnMenu.addButton("all", "All");
    filterColumnMenu.addButton("date", "Date");
    filterColumnMenu.addButton("airline", "Airline");
    filterColumnMenu.addButton("flightNumber", "Flight Number");
    filterColumnMenu.addButton("depAirport", "Dep. Airport");
    filterColumnMenu.addButton("depCity", "Dep. City");
    filterColumnMenu.addButton("depState", "Dep. State");
    filterColumnMenu.addButton("destAirport", "Dest. Airport");
    filterColumnMenu.addButton("destCity", "Dest. City");
    filterColumnMenu.addButton("destState", "Dest. State");
    filterColumnMenu.addButton("distance", "Distance");
    filterColumnMenu.addButton("depTime", "Dep Time");
    filterColumnMenu.addButton("arrTime", "Arr Time");

    tableScreen.addDropDownMenu(filterColumnMenu);
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
    graphCreateScreen.addButton(filterDataChange);
    grcMenu.addButton("bcOption","Bar Chart");
    grcMenu.addButton("scOption","Scatter Plot");
    grcMenu.addButton("hOption","Histogram");

    DropDown histogramDataChoose = new DropDown(400,200,250,50,"hsgData","Data",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    

    DropDown hisData = new DropDown(400,200,250,50,"hsdOption","Data",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    for (String[] s : chooseHistoGramX) {
        hisData.addButton(s[0],s[1]);
    }
    int i = 0;
    for (String[] s : chooseHistoGramXIDD) {
        hisData.addInterioDropDown(s[0],s[1]+" >");
        hisData.sIDD.get(i).addButton(s[0]+"Departure",s[1]+": Departure");
        hisData.sIDD.get(i).addButton(s[0]+"Destination",s[1]+": Destination");
        i++;
    }

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

    DropDown bcCat = new DropDown(400,200,250,50,"bcCatOpt","Category",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    i=0;
    for (String[] s : chooseGraphBarChartCat) {
        bcCat.addInterioDropDown(s[0],s[1]);
        bcCat.sIDD.get(i).addButton("bccDep"+s[1],s[1].substring(0,s[1].length()-2)+" (Departure)");
        bcCat.sIDD.get(i).addButton("bccDest"+s[1],s[1].substring(0,s[1].length()-2)+" (Destination)");
        i++;
    }
    bcCat.addButton("bccAirline","Airline");
    

    DropDown bcData = new DropDown(700,200,250,50,"bcDataOpt","Data",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );

    for (String[] s : chooseGraphBarChartData) {
        bcData.addButton(s[0],s[1]);
    }

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
    
    DropDown chooseNumber = new DropDown(100,450,250,50,"bcNum","Choose Show Number",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    chooseNumber.addButton("bcNumfive","5");
    chooseNumber.addButton("bcNumten","10");
    chooseNumber.addButton("bcNumtwentyfive","25");
    chooseNumber.addButton("bcNumtwentyfive","50");
    chooseNumber.addButton("bcNumtwentyfive","60");

    Button bcChooseNumHolder = new Button(100, 380, 250, 50, "bcChooseNumHold", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );

    DropDown bcSort = new DropDown(400,450,250,50,"bcSort","Sort By",
        color(#9657df), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#bc85ff), // background color
        color(#9600df), // top button
        color(#adadae)  // secondary button
        );
    bcSort.addButton("bcSortAsc","Ascending");
    bcSort.addButton("bcSortDesc","Descending");

    Button bcSortHolder = new Button(400, 380, 250, 50, "bcSortHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );

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
    graphCreateScreen.addButton(bcSortHolder);
    graphCreateScreen.addButton(bcChooseNumHolder);
    bcChooseNumHolder.visible = false;
    bcSortHolder.visible = false;
    graphCreateScreen.addDropDownMenu(bcSort);
    bcSort.visible = false;
    graphCreateScreen.addDropDownMenu(chooseNumber);
    chooseNumber.visible = false;
    graphCreateScreen.addDropDownMenu(grcMenu);
    graphCreateScreen.addDropDownMenu(xDDM);
    graphCreateScreen.addDropDownMenu(yDDM);

    graphCreateScreen.addDropDownMenu(bcCat);
    graphCreateScreen.addDropDownMenu(bcData);

    graphCreateScreen.addDropDownMenu(hisData);

    xDDM.visible = false;
    yDDM.visible = false;
    bcCat.visible = false;
    bcData.visible = false;
    hisData.visible = false;



    graphCreateScreen.addButton(loadGraph);
    graphCreateScreen.addButton(graphTypeholder);
    graphFirstHolder.visible = false;
    graphSecondHolder.visible = false;
    graphCreateScreen.addButton(graphFirstHolder);
    graphCreateScreen.addButton(graphSecondHolder);
}
void loadGraphShowScreen() {
    graphShowScreen.staticRects.add(navBar);
    graphShowScreen.addButton(filterDataChange);
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

void loadBarChartShowScreen() {
    barChartShowScreen.addButton(filterDataChange);
    barChartShowScreen.staticRects.add(navBar);
    barChartShowScreen.hasBarChart = true;
    BarChart bc = new BarChart(100,120,900,570, mediumFont, smallFont,color(#9657df), 5);
    barChartShowScreen.barChart = bc; 

    Button backButton = new Button(1100, 57, 50, 50, "backW", "Back",
    color(#9657df), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    barChartShowScreen.addButton(backButton);
}

void loadBarGraphShowScreen() {
    barGraphShowScreen.hasBarGraph = true;
    barGraphShowScreen.staticRects.add(navBar);
    BarGraph barGraph = new BarGraph(60, 100, SCREENX - 140, SCREENY - 170, flights, mediumFont, smallFont);
    barGraphShowScreen.barGraph = barGraph;
}

void loadFilterDataScreen() {
    filterDataScreen.staticRects.add(navBar);
    
    DropDown nonNumFilter = new DropDown(400,150,250,40,"filterNonNum","Filter Non-Numerical Data",
        color(#f5af5f), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#f5bf82), // background color
        color(#e37d30), // top button
        color(#adadae)  // secondary button
    );
    nonNumFilter.visible = false;
    nonNumFilter.addInterioDropDown("filNonMonth","Month >");
    int i=0;
    //filterDataScreen.addDropDownMenu(nonNumFilter);
    for (String month : monthsStringArray) {
        nonNumFilter.sIDD.get(0).addButton("filNonMonth"+i,month);
        i++;
    }
    nonNumFilter.addButton("filNonAirline", "Airline");
    nonNumFilter.addInterioDropDown("filNonCancelled","Cancelled >");
    nonNumFilter.sIDD.get(1).addButton("filNonCancelledTrue","Cancelled: True");
    nonNumFilter.sIDD.get(1).addButton("filNonCancelledFalse","Cancelled: False");

    nonNumFilter.addInterioDropDown("filNonDiverted","Diverted >");
    nonNumFilter.sIDD.get(2).addButton("filNonDivertedTrue","Diverted: True");
    nonNumFilter.sIDD.get(2).addButton("filNonDivertedFalse","Diverted: False");
    i = 3;
    for (String[] strArray : filterNonNumOption) {
        nonNumFilter.addInterioDropDown(strArray[0],strArray[1]);
        nonNumFilter.sIDD.get(i).addButton(strArray[0]+"dest",strArray[1].substring(0,strArray[1].length() - 2)+": Destination");
        nonNumFilter.sIDD.get(i).addButton(strArray[0]+"dep",strArray[1].substring(0,strArray[1].length() - 2)+": Departure");
        i++;

    }
    

    DropDown numFilter = new DropDown(400,150,250,40,"filterNum","Filter Numerical Data",
        color(#f5af5f), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#f5bf82), // background color
        color(#e37d30), // top button
        color(#adadae)  // secondary button
    );
    numFilter.visible = false;
    for (String[] strArr : filterNumOption) {
        numFilter.addButton(strArr[0],strArr[1]);
    }
    i = 0;
    for (String[] strArr : filterNumOptionIDD) {
        numFilter.addInterioDropDown(strArr[0],strArr[1]);
        numFilter.sIDD.get(i).addButton(strArr[0]+"Dep",strArr[1].substring(0,strArr[1].length() - 2)+": Departure");
        numFilter.sIDD.get(i).addButton(strArr[0]+"Dest",strArr[1].substring(0,strArr[1].length() - 2)+": Destination");
        i++;
    }

    DropDown numTypeFilter = new DropDown(700,150,250,40,"typeNumFilter","Choose Filter Type",
        color(#f5af5f), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#f5bf82), // background color
        color(#e37d30), // top button
        color(#adadae)  // secondary button
    );
    numTypeFilter.addButton("nFilTsingleVal","Single Value");
    numTypeFilter.addButton("nFilTgreater","Greater Than");
    numTypeFilter.addButton("nFilTlesser","Less Than");
    numTypeFilter.addButton("nFilTrange","Range");
    numTypeFilter.visible = false;
    DropDown typeDataFilter = new DropDown(100,150,250,40,"typeDataChoose","Choose Type of Data",
        color(#f5af5f), // Button Color
        color(#000000), // text Color
        smallFont,
        3,6,            // xgap, ygap
        color(#f5bf82), // background color
        color(#e37d30), // top button
        color(#adadae)  // secondary button
    );
    typeDataFilter.addButton("TypChNonNum","Non-Numerical Data");
    typeDataFilter.addButton("TypeChNum","Numerical Data");

    Button typeDataFilterHolder = new Button(100, 100, 250, 40, "typeDataFilterHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );

    Button fstTypeHolder = new Button(400, 100, 250, 40, "fstTypeHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    fstTypeHolder.visible = false;

    Button scndTypeHolder = new Button(700, 100, 250, 40, "scndTypeHolder", " ",
    color(#adadae), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    scndTypeHolder.visible = false;
    filterDataScreen.hasTextEdit = true;
    TextEdit valFirst = new TextEdit(100, 500, 180, 40, "valueFirstHolder",
    color(#FFD580),
    color(#a1e6ff),
    color(0),
    mediumFont,
    144);

    TextEdit valSecond = new TextEdit(400, 500, 180, 40, "valueSecondHolder", 
    color(#FFD580),
    color(#a1e6ff),
    color(0),
    mediumFont,
    144);
    valFirst.visible = false;
    valSecond.visible = false;
    filterDataScreen.addTextEdit(valFirst);
    filterDataScreen.addTextEdit(valSecond);

    Button valueFstHolder = new Button(100, 500, 180, 40, "valueFstHolder", " ",
    color(#9adcff), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    valueFstHolder.visible = false;

    Button valueScndHolder = new Button(400, 500, 180, 40, "valueScndHolder", " ",
    color(#9adcff), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    valueScndHolder.visible = false;

    filterDataScreen.addButton(valueFstHolder);
    filterDataScreen.addButton(valueScndHolder);

    filterDataScreen.addDropDownMenu(typeDataFilter);
    filterDataScreen.addDropDownMenu(numTypeFilter);
    filterDataScreen.addDropDownMenu(numFilter);
    filterDataScreen.addDropDownMenu(nonNumFilter);
    filterDataScreen.addButton(typeDataFilterHolder);
    filterDataScreen.addButton(fstTypeHolder);
    filterDataScreen.addButton(scndTypeHolder);

    Button addNewFilter = new Button(SCREENX-100-20,70,100,45,"addFilter", "Add Filter",
    color(#f5af5f), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    Button removeFilter = new Button(SCREENX-100-20,130,100,45,"removeFilter", "Remove Filters",
    color(#f5af5f), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    filterDataScreen.addButton(removeFilter);
    filterDataScreen.addButton(addNewFilter);


    TextBox infoForNumType = new TextBox(100,400,"",
    "InfoNum",
    mediumFont);
    //infoForNumType.visible = false;
    TextBox fstInfo = new TextBox(100,470,"",
    "InfoSmallOne",
    smallFont);
    TextBox scndInfo = new TextBox(400,470,"",
    "InfoSmallTwo",
    smallFont);
    TextBox filterInfo = new TextBox(200,700,"There are no fitlers currently applied, the size of the dataset is "+filteredFlights.size(),
    "filterInfo",
    mediumFont);
    filterDataScreen.addTextBox(filterInfo);
    filterDataScreen.addTextBox(infoForNumType);
    filterDataScreen.addTextBox(fstInfo);
    filterDataScreen.addTextBox(scndInfo);
}

void updateFilterLabel() {
    filterDataScreen.textBoxMap.get("filterInfo");
    if (!filtersApplied) {
        filterDataScreen.textBoxMap.get("filterInfo").textLabel = "There are no filters currently applied, the size of the dataset is "+filteredFlights.size();
    }
    else {
        filterDataScreen.textBoxMap.get("filterInfo").textLabel = "Filters are currently applied, the size of the filtered dataset is "+filteredFlights.size();
    }
}

void loadHistogramShowScreen() {
    histogramShowScreen.staticRects.add(navBar);
    histogramShowScreen.addButton(filterDataChange);
    histogramShowScreen.hasHistogram = true;
    Histogram hs = new Histogram(100,120,900,570, mediumFont, smallFont,color(#f76fda));
    histogramShowScreen.histogram = hs; 

    Button backButton = new Button(1100, 57, 50, 50, "backW", "Back",
    color(#9657df), // Button Color
    color(#adadae), // secondary Button
    color(0),         // text color
    smallFont
    );
    histogramShowScreen.addButton(backButton);


}