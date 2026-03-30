void homeScreenPress() {
    homeScreen.rangeSlider.press();
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnHomeScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnHomeScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = homeScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
}


void tableScreenPress() {
    String[] buttonPressed = tableScreen.getButtonPressed();
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vgraph") {
            OnTableScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    handleFilterPress(buttonPressed[0]);

    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].length() > 3 && buttonPressed[0].substring(0,4).equals("show")) {
            // set the show array
            whichValues[(int) showLabelToIndex.get(buttonPressed[0])] = !whichValues[(int) showLabelToIndex.get(buttonPressed[0])];
            updateScreenHorizontalScrollLimit();
        }
        else if (buttonPressed[0].equals("prevPage")&& currentPage > 0) {
            currentPage--;
            YOFFSET = 0;
            updateVerticalLimit();

        }
        else if (buttonPressed[0].equals("nextPage") && currentPage < totalPages - 1) {
            currentPage++;
            YOFFSET = 0;
            updateVerticalLimit();
        }
        else if (buttonPressed[0].equals("searchOption")) {
            if (!searchOpen) {
                searchOpen = true;
                tableScreen.dropDownMap.get("filterColumn").visible = false;
                //tableScreen.buttonMap.get("clearButton").visible = true;
                tableScreen.buttonMap.get("searchOption").textLabel = "Filters";

            }
            else {
                searchOpen = false;
                tableScreen.dropDownMap.get("filterColumn").visible = true;
                //tableScreen.buttonMap.get("clearButton").visible = false;
                tableScreen.buttonMap.get("searchOption").textLabel = "Search";

            }




        }
        else if (buttonPressed[0].equals("clearButton")) {
                searchText = "";
                selectedColumn = "All";
                applyFilters();
        }
        else if (buttonPressed[0].length() > 7 && buttonPressed[0].substring(0,8).equals("sortData")) { 
            sortFlights(buttonPressed[0]);
                  currentPage = 0;
                  YOFFSET = 0;
                  updatePagination();
                  updateVerticalLimit();
        }
        else {
            if (!searchOpen ) {
                if (buttonPressed[0].equals("all")) selectedColumn = "All";
                if (buttonPressed[0].equals("date")) selectedColumn = "Date";
                if (buttonPressed[0].equals("airline")) selectedColumn = "Airline";
                if (buttonPressed[0].equals("flightNumber")) selectedColumn = "Flight Number";
                if (buttonPressed[0].equals("depAirport")) selectedColumn = "Dep. Airport";
                if (buttonPressed[0].equals("depCity")) selectedColumn = "Dep. City";
                if (buttonPressed[0].equals("depState")) selectedColumn = "Dep. State";
                if (buttonPressed[0].equals("destAirport")) selectedColumn = "Dest. Airport";
                if (buttonPressed[0].equals("destCity")) selectedColumn = "Dest. City";
                if (buttonPressed[0].equals("destState")) selectedColumn = "Dest. State";
                if (buttonPressed[0].equals("distance")) selectedColumn = "Distance";
                if (buttonPressed[0].equals("depTime")) selectedColumn = "Dep Time";
                if (buttonPressed[0].equals("arrTime")) selectedColumn = "Arr Time";
                tableScreen.dropDownMap.get("filterColumn").textLabel = "Filter: " + selectedColumn;
                applyFilters();
            }
        }

        //this index of the drop down menu array for the table screen corresponds to the show menu
        //tableScreen.ddMenus.get(0).colorController = whichValues;
    }
    if (tableScreen.vscroll.cursorOverWidget()) {
        tableScreen.vscroll.click = true;
    }
    if (tableScreen.hscroll.cursorOverWidget()) {
        tableScreen.hscroll.click = true;
    }
}


void graphCreateScreenPress() {

    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (!visualiseOption[0].equals("None") && !visualiseOption[0].equals("Opened")) {
        if (visualiseOption[0].equals("vtable")) {
            OnGraphCreateScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
    }

    String[] buttonPressed = graphCreateScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
    if (isLoadGraphActive()) {
        graphCreateScreen.buttonMap.get("loadGraph").active = true;
    }
    else {
        graphCreateScreen.buttonMap.get("loadGraph").active = false;
    }
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("scOption")) {
            graphCreateScreen.textEditMap.get("histogramBin").visible = false;
            graphCreateScreen.textStoreMap.get("1dataH").visible = true;
            graphCreateScreen.textStoreMap.get("2dataH").visible = true;

            graphCreateScreen.dropDownMap.get("scYData").visible = true;
            graphCreateScreen.dropDownMap.get("scXData").visible = true;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = false;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = false;


            graphCreateScreen.textStoreMap.get("gTypeH").textLabel = buttonPressed[1];
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = "";
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = "";


            graphCreateScreen.dropDownMap.get("hsdOption").visible = false;
            graphCreateScreen.dropDownMap.get("bcNum").visible = false;
            graphCreateScreen.dropDownMap.get("piCatOpt").visible = false;

            graphCreateScreen.textStoreMap.get("bcNumH").textLabel = "";
            graphCreateScreen.textStoreMap.get("bcNumH").visible = false;

            graphCreateScreen.dropDownMap.get("bcSort").visible = false;


            graphCreateScreen.textStoreMap.get("bcSortH").visible = false;
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = "";
        }
        //
        if (buttonPressed[0].equals("bcOption")) {
            graphCreateScreen.textEditMap.get("histogramBin").visible = false;
            graphCreateScreen.textStoreMap.get("1dataH").visible = true;
            graphCreateScreen.textStoreMap.get("2dataH").visible = true;

            graphCreateScreen.dropDownMap.get("scYData").visible = false;
            graphCreateScreen.dropDownMap.get("scXData").visible = false;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = true;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = true;


            graphCreateScreen.textStoreMap.get("gTypeH").textLabel = buttonPressed[1];
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = "";
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = "";

            graphCreateScreen.dropDownMap.get("hsdOption").visible = false;

            graphCreateScreen.dropDownMap.get("bcNum").visible = false;

            graphCreateScreen.dropDownMap.get("piCatOpt").visible = false;
            graphCreateScreen.textStoreMap.get("bcNumH").textLabel = "";
            graphCreateScreen.textStoreMap.get("bcNumH").visible = false;

            graphCreateScreen.dropDownMap.get("bcSort").visible = false;


            graphCreateScreen.textStoreMap.get("bcSortH").visible = false;
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = "";

        }
        if (buttonPressed[0].equals("hOption")) {

            graphCreateScreen.textEditMap.get("histogramBin").visible = true;
            graphCreateScreen.textStoreMap.get("1dataH").visible = true;
            graphCreateScreen.textStoreMap.get("2dataH").visible = false;

            graphCreateScreen.dropDownMap.get("hsdOption").visible = true;
            graphCreateScreen.dropDownMap.get("scYData").visible = false;
            graphCreateScreen.dropDownMap.get("scXData").visible = false;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = false;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = false;


            graphCreateScreen.textStoreMap.get("gTypeH").textLabel = buttonPressed[1];
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = "";
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = "his";
            graphCreateScreen.dropDownMap.get("piCatOpt").visible = false;
            graphCreateScreen.dropDownMap.get("bcNum").visible = false;
            graphCreateScreen.textStoreMap.get("bcNumH").textLabel = "";
            graphCreateScreen.textStoreMap.get("bcNumH").visible = false;
            graphCreateScreen.dropDownMap.get("bcSort").visible = false;
            graphCreateScreen.textStoreMap.get("bcSortH").visible = false;
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = "";

        }
        if (buttonPressed[0].equals("piOption")) {
            graphCreateScreen.textEditMap.get("histogramBin").visible = false;
            graphCreateScreen.textStoreMap.get("1dataH").visible = true;
            graphCreateScreen.textStoreMap.get("2dataH").visible = false;

            graphCreateScreen.dropDownMap.get("scYData").visible = false;
            graphCreateScreen.dropDownMap.get("scXData").visible = false;
            graphCreateScreen.dropDownMap.get("piCatOpt").visible = true;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = false;


            graphCreateScreen.textStoreMap.get("gTypeH").textLabel = buttonPressed[1];
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = "";
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = "piC";

            graphCreateScreen.dropDownMap.get("hsdOption").visible = false;

            graphCreateScreen.dropDownMap.get("bcNum").visible = false;


            graphCreateScreen.textStoreMap.get("bcNumH").textLabel = "";
            graphCreateScreen.textStoreMap.get("bcNumH").visible = false;

            graphCreateScreen.dropDownMap.get("bcSort").visible = false;


            graphCreateScreen.textStoreMap.get("bcSortH").visible = false;
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = "";
        }
        //
        if (buttonPressed[0].substring(0,3).equals("scx")) {

            graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("scy")) {

            graphCreateScreen.textStoreMap.get("2dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,4).equals("hsgd")) {

            graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("bcc")) {
            if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Bar Chart")) {
                graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
                if (!graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
                    && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")) {
                    graphCreateScreen.dropDownMap.get("bcNum").visible = true;
                    graphCreateScreen.dropDownMap.get("bcSort").visible = true;
                    graphCreateScreen.textStoreMap.get("bcNumH").visible = true;

                    graphCreateScreen.textStoreMap.get("bcSortH").visible = true;


                }
            }
            else if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Pi Chart")) {
                
                graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
            }


        }
        if (buttonPressed[0].length() > 5 && buttonPressed[0].substring(0,6).equals("bcSort")) {
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].length() > 4 && buttonPressed[0].substring(0,5).equals("bcNum")) {
            graphCreateScreen.textStoreMap.get("bcNumH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("bcd")) {
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = buttonPressed[1];
            if (!graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")
                && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")) {
                graphCreateScreen.dropDownMap.get("bcNum").visible = true;
                graphCreateScreen.textStoreMap.get("bcNumH").visible = true;
                graphCreateScreen.dropDownMap.get("bcSort").visible = true;
                graphCreateScreen.textStoreMap.get("bcSortH").visible = true;
            }
        }
        if (buttonPressed[0].equals("loadGraph")) {
            if (!graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("")
                && !graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
                && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")) {

                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Bar Chart")
                    && !graphCreateScreen.textStoreMap.get("bcNumH").textLabel.equals("")
                    && !graphCreateScreen.textStoreMap.get("bcSortH").textLabel.equals("")) {

                    // change screen and load bar chart with correct data
                    showNumBC = int(graphCreateScreen.textStoreMap.get("bcNumH").textLabel);
                    if (graphCreateScreen.textStoreMap.get("bcSortH").textLabel.equals("Ascending")) {
                        ascendingBC = true;
                    }
                    else {
                        ascendingBC = false;
                    }
                    loadBarChartData(graphCreateScreen.textStoreMap.get("1dataH").textLabel, graphCreateScreen.textStoreMap.get("2dataH").textLabel);
                    

                    OnGraphCreateScreen = false;
                    OnbarChartShowScreen = true;
                    currentScreen = barChartShowScreen;
                }
                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Pi Chart")) {
                    loadPiChartData(graphCreateScreen.textStoreMap.get("1dataH").textLabel);
                    OnGraphCreateScreen = false;
                    OnPiChartShowScreen = true;
                    currentScreen = piChartShowScreen;

                }

                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Scatter Plot")) {
                    // change screen and load scatter plot with correct data
                    loadScatterPlotData(graphCreateScreen.textStoreMap.get("1dataH").textLabel, graphCreateScreen.textStoreMap.get("2dataH").textLabel);
                    OnGraphCreateScreen = false;
                    OnGraphShowScreen = true;
                    currentScreen = graphShowScreen;
                }
                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Histogram")) {
                    // change screen and load histogram with correct data
                    loadHistogramData(graphCreateScreen.textStoreMap.get("1dataH").textLabel,graphCreateScreen.textEditMap.get("histogramBin").textLabel);
                    OnGraphCreateScreen = false;
                    OnHistogramShowScreen = true;
                    currentScreen = histogramShowScreen;
                }

            }
        }
    }
    
}


void graphShowScreenPress() {
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnGraphShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = graphShowScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
}

void barChartShowScreenPress() {
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnbarChartShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnbarChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = barChartShowScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnbarChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
}

void filterDataScreenPress() {
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnFilterDataScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnFilterDataScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = filterDataScreen.getButtonPressed();
    if (ifFilterActive()) {
        filterDataScreen.buttonMap.get("addFilter").active = true;
    }
    else {
        filterDataScreen.buttonMap.get("addFilter").active = false;
    }
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("TypChNonNum")) {
            clearAllFilterOptions();
            filterDataScreen.textStoreMap.get("FTypeH").textLabel = buttonPressed[1];
            filterDataScreen.textStoreMap.get("1TypeH").visible = true;
            filterDataScreen.dropDownMap.get("filterNonNum").visible = true;

        }
        if (buttonPressed[0].equals("TypeChNum")) {
            clearAllFilterOptions();
            filterDataScreen.textStoreMap.get("FTypeH").textLabel = buttonPressed[1];
            
            filterDataScreen.textStoreMap.get("1TypeH").visible = true;
            filterDataScreen.dropDownMap.get("filterNum").visible = true;

        }
        if (buttonPressed[0].length() > 5 && buttonPressed[0].substring(0,6).equals("filNon")) {
                filterDataScreen.textStoreMap.get("1TypeH").textLabel = buttonPressed[1];
            if ((buttonPressed[0].length() > 10 && buttonPressed[0].substring(0,11).equals("filNonMonth"))
                || buttonPressed[0].length() > 13 && buttonPressed[0].substring(0,14).equals("filNonDiverted")
                || buttonPressed[0].length() > 14 && buttonPressed[0].substring(0,15).equals("filNonCancelled")
            ) {

                filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
                filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
                filterDataScreen.textEditMap.get("valueFirstHolder").visible = false;
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
                filterDataScreen.textEditMap.get("valueFirstHolder").textLabel = "";
                filterDataScreen.textEditMap.get("valueSecondHolder").textLabel = "";
                setFilterText1("");
                setFilterText2("");

            }
            else {
                //filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Insert Info Here: ";
                filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
                setFilterText1("Insert Info: ");
            }

        }
        if (buttonPressed[0].length() > 5 && buttonPressed[0].substring(0,6).equals("filNum")) {
            filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
            filterDataScreen.textStoreMap.get("1TypeH").textLabel = buttonPressed[1];
            filterDataScreen.dropDownMap.get("typeNumFilter").visible = true;
            filterDataScreen.textStoreMap.get("2TypeH").visible = true;
            // set all the next values to empty or invisible;
            filterDataScreen.textStoreMap.get("2TypeH").textLabel = "";
            filterDataScreen.textEditMap.get("valueFirstHolder").visible = false;
            filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
            filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
            filterDataScreen.textEditMap.get("valueFirstHolder").textLabel = "";
            filterDataScreen.textEditMap.get("valueSecondHolder").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
                setFilterText1("");
                setFilterText2("");

        }
        if (buttonPressed[0].length() > 3 && buttonPressed[0].substring(0,4).equals("nFil")) {
            filterDataScreen.textStoreMap.get("2TypeH").textLabel = buttonPressed[1];
            
            if (filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Time of day: Departure") || filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Time of day: Destination")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "Enter in format hhmm";
            }
            if (filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Delay: Departure") || filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Delay: Destination")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In minutes: ";
            }
            if (filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Distance")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In miles: ";
            }
            if (filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("Date")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In format DD/MM/YYYY: ";
            }
            //filterDataScreen.textStoreMap.get("1valH").visible = true;
            filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
            filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
            if (buttonPressed[0].equals("nFilTsingleVal")) {
                //filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Equals: ";
                setFilterText1("Equals: ");
            }
            if (buttonPressed[0].equals("nFilTgreater")) {
                //filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Greater Than: ";
                setFilterText1("Greater Than: ");
            }
            if (buttonPressed[0].equals("nFilTlesser")) {
                //filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Less Than: ";
                setFilterText1("Less Than: ");
            }
            if (buttonPressed[0].equals("nFilTrange")) {
                //filterDataScreen.buttonMap.get("valueScndHolder").visible = true;
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = true;
                setFilterText1("Greater Than: ");
                setFilterText2("Less Than: ");
                //filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "Greater Than: ";
                //filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Less Than: ";
            }
            else {
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
            }
        }
        if (buttonPressed[0].equals("addFilter")) {

            if (filterDataScreen.dropDownMap.get("filterNonNum").visible == true) {
                if (monthSet.contains(filterDataScreen.textStoreMap.get("1TypeH").textLabel)
                    || filterDataScreen.textStoreMap.get("1TypeH").textLabel.length() > 7 && filterDataScreen.textStoreMap.get("1TypeH").textLabel.substring(0,8).equals("Diverted")
                    || filterDataScreen.textStoreMap.get("1TypeH").textLabel.length() > 8 && filterDataScreen.textStoreMap.get("1TypeH").textLabel.substring(0,9).equals("Cancelled")
                
                ) {
                    filterDataNonNumerical(filterDataScreen.textStoreMap.get("1TypeH").textLabel, filterDataScreen.textStoreMap.get("1TypeH").textLabel);
                    if (errorMessageActive) {
                        clearAllFilterOptions();
                    }
                    else {
                        // if succesful
                        filterDataScreen.buttonMap.get("removeFilter").active = true;
                    }
                }
                else {
                    //if (!filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel.equals("")) {
                        filterDataNonNumerical(filterDataScreen.textStoreMap.get("1TypeH").textLabel, filterDataScreen.textEditMap.get("valueFirstHolder").textLabel);
                        if (errorMessageActive) {
                            clearAllFilterOptions();
                        }
                        else {
                            // if succesful
                            filterDataScreen.buttonMap.get("removeFilter").active = true;
                        }
                    //}
                }
            }
            else if (filterDataScreen.dropDownMap.get("filterNum").visible == true) {
                if (!filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("")
                    && !filterDataScreen.textStoreMap.get("2TypeH").textLabel.equals("")
                    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("")
                ) {
                    
                    if (filterDataScreen.textStoreMap.get("2TypeH").textLabel.equals("Range")) {
                        if (!filterDataScreen.textEditMap.get("valueSecondHolder").textLabel.equals("")) {
                            //apply filter, reset screen
                            filterDataNumerical(filterDataScreen.textStoreMap.get("1TypeH").textLabel,
                            filterDataScreen.textStoreMap.get("2TypeH").textLabel,
                            filterDataScreen.textEditMap.get("valueFirstHolder").textLabel,
                            filterDataScreen.textEditMap.get("valueSecondHolder").textLabel);
                            if (errorMessageActive) {
                                clearAllFilterOptions();
                            }
                            else {
                                // if succesful
                                filterDataScreen.buttonMap.get("removeFilter").active = true;
                            }
                        }
                    }
                    else {
                        //apply filter, reset screen
                        filterDataNumerical(filterDataScreen.textStoreMap.get("1TypeH").textLabel,
                        filterDataScreen.textStoreMap.get("2TypeH").textLabel,
                        filterDataScreen.textEditMap.get("valueFirstHolder").textLabel);

                        if (errorMessageActive) {
                            clearAllFilterOptions();
                        }
                        else {
                            // if succesful
                            filterDataScreen.buttonMap.get("removeFilter").active = true;
                        }
                    }
                }
            }
        }
        if (buttonPressed[0].equals("removeFilter")) {
            //set filtered flights to flights
            resetFilteredFlights();
            tableScreen.table.updateDataSize(filteredFlights);
            filtersApplied = false;
            updateFilterLabel();
            clearAllFilterOptions();
            filterDataScreen.buttonMap.get("removeFilter").active = false;
            filterDataScreen.buttonMap.get("addFilter").active = false;

        }
    }
}

void clearAllFilterOptions() {
    filterDataScreen.textStoreMap.get("1TypeH").visible = false;
    filterDataScreen.textStoreMap.get("2TypeH").visible = false;
    filterDataScreen.dropDownMap.get("filterNonNum").visible = false;
    filterDataScreen.dropDownMap.get("filterNum").visible = false;
    filterDataScreen.dropDownMap.get("typeNumFilter").visible = false;
    filterDataScreen.textStoreMap.get("2TypeH").textLabel = "";
    filterDataScreen.textStoreMap.get("1TypeH").textLabel = "";
    filterDataScreen.textEditMap.get("valueFirstHolder").visible = false;
    filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
    filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
    filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
    filterDataScreen.textEditMap.get("valueFirstHolder").textLabel = "";
    filterDataScreen.textEditMap.get("valueSecondHolder").textLabel = "";
    filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
    filterDataScreen.textStoreMap.get("FTypeH").textLabel="";
    setFilterText1("");
    setFilterText2("");
}

void handleFilterPress(String buttonPressed) {
    if (buttonPressed.equals("filterChange")) {
        OnHomeScreen = false;
        OnTableScreen = false;
        OnGraphCreateScreen = false;
        OnGraphShowScreen = false;
        OnbarChartShowScreen = false;
        OnBarGraphShowScreen = false;
        OnFilterDataScreen = true;
        currentScreen = filterDataScreen;
    }
}

void histogramShowScreenPress() {
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnHistogramShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnHistogramShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = histogramShowScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnHistogramShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }

}

void setFilterText1(String inputText) {
    filterDataScreen.textEditMap.get("valueFirstHolder").defaultText = inputText;
}

void setFilterText2(String inputText) {
    filterDataScreen.textEditMap.get("valueSecondHolder").defaultText = inputText;

}

boolean ifFilterActive() {
    return 
    (!filterDataScreen.textStoreMap.get("FTypeH").textLabel.equals(""))
    &&
    (
    (filterDataScreen.textStoreMap.get("FTypeH").textLabel.equals("Numerical Data")
    && !filterDataScreen.textStoreMap.get("2TypeH").textLabel.equals("Range")
    && !filterDataScreen.textStoreMap.get("2TypeH").textLabel.equals("")
    && !filterDataScreen.textStoreMap.get("1TypeH").textLabel.equals("")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("Less Than: ")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("Greater Than: ")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("Equals: ")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals(""))
    ||
    (filterDataScreen.textStoreMap.get("FTypeH").textLabel.equals("Numerical Data")
    && filterDataScreen.textStoreMap.get("2TypeH").textLabel.equals("Range")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("Greater Than: ")
    && !filterDataScreen.textEditMap.get("valueSecondHolder").textLabel.equals("Less Than: ")
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("")
    && !filterDataScreen.textEditMap.get("valueSecondHolder").textLabel.equals("")
    )
    ||
    (filterDataScreen.textStoreMap.get("FTypeH").textLabel.equals("Non-Numerical Data")
    && isNonNumericalNoTextEdit()
    )
    || 
    ((filterDataScreen.textStoreMap.get("FTypeH").textLabel.equals("Non-Numerical Data")
    && !isNonNumericalNoTextEdit()
    && !filterDataScreen.textEditMap.get("valueFirstHolder").textLabel.equals("")))
    
    );
}
boolean isNonNumericalNoTextEdit() {
    return
    (monthSet.contains(filterDataScreen.textStoreMap.get("1TypeH").textLabel)
    || filterDataScreen.textStoreMap.get("1TypeH").textLabel.length() > 7 && filterDataScreen.textStoreMap.get("1TypeH").textLabel.substring(0,8).equals("Diverted")
    || filterDataScreen.textStoreMap.get("1TypeH").textLabel.length() > 8 && filterDataScreen.textStoreMap.get("1TypeH").textLabel.substring(0,9).equals("Cancelled")
    );
}

boolean isLoadGraphActive() {
    return 
    (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Scatter Plot")
    && !graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
    && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals(""))
    ||
    (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Histogram")
    && !graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
    && !graphCreateScreen.textEditMap.get("histogramBin").textLabel.equals("")
    && safeInt(graphCreateScreen.textEditMap.get("histogramBin").textLabel) != 0
    && safeInt(graphCreateScreen.textEditMap.get("histogramBin").textLabel) <= 100)
    ||
    (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Bar Chart")
    && !graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
    && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")
    && !graphCreateScreen.textStoreMap.get("bcSortH").textLabel.equals("")
    && !graphCreateScreen.textStoreMap.get("bcNumH").textLabel.equals(""))
    ||
    (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Pi Chart")
    && !graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals(""));
}

void piChartShowScreenPress() {
    String[] visualiseOption = handleDropDownArray(visualiseSelect);
    if (visualiseOption[0] != "None" && visualiseOption[0] != "Opened") {
        if (visualiseOption[0] == "vtable") {
            OnPiChartShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnPiChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = piChartShowScreen.getButtonPressed();
    handleFilterPress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnPiChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }   
}