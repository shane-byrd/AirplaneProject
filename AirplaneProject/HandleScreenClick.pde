// code to respond to press on Screen, written by Shane Byrd
//
void homeScreenPress() {
    String[] buttonPressed = homeScreen.getButtonPressed();

    // change screens depending on which button was pressed
    if (buttonPressed[0].equals("tabView")) {
        OnHomeScreen = false;
        OnTableScreen = true;
        currentScreen = tableScreen;
        changeTableTable(currentScreen);
        currentScreen.updateHighlights();
    }
    if (buttonPressed[0].equals("grView")) {
        OnHomeScreen = false;
        OnGraphCreateScreen = true;
        currentScreen = graphCreateScreen;
        currentScreen.updateHighlights();
    }
    if (buttonPressed[0].equals("filView")) {
        OnHomeScreen = false;
        OnFilterDataScreen = true;
        currentScreen = filterDataScreen;
        currentScreen.updateHighlights();
    }
    if (buttonPressed[0].equals("searchView")) {
        OnHomeScreen = false;
        OnSearchScreen = true;
        currentScreen = searchScreen;
        changeTableSearch(currentScreen);
        currentScreen.updateHighlights();
    }
}


void tableScreenPress() {
    String[] buttonPressed = tableScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);

    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].length() > 3 && buttonPressed[0].substring(0,4).equals("show")) {
            // set the show array
            whichValues[(int) showLabelToIndex.get(buttonPressed[0])] = !whichValues[(int) showLabelToIndex.get(buttonPressed[0])];
            updateScreenHorizontalScrollLimit();
        }
        else if (buttonPressed[0].equals("prevPage")&& currentPage > 0) {
            // move to previous page
            currentPage--;
            YOFFSET = 0;
            updateVerticalLimit();

        }
        else if (buttonPressed[0].equals("nextPage") && currentPage < totalPages - 1) {
            // move to next page
            currentPage++;
            YOFFSET = 0;
            updateVerticalLimit();
        }

        else if (buttonPressed[0].equals("clearButton")) {
            // set all columns to visible
            for (int i = 0; i < whichValues.length; i ++) {
                whichValues[i] = true;
            }
            updateScreenHorizontalScrollLimit();
        }
        else if (buttonPressed[0].equals("removeButton")) {
            // set all columns to invisible
            for (int i = 0; i < whichValues.length; i ++) {
                whichValues[i] = false;
            }
            updateScreenHorizontalScrollLimit();

        }
        else if (buttonPressed[0].length() > 7 && buttonPressed[0].substring(0,8).equals("sortData")) { 
            // sort the flights
            sortFlights(buttonPressed[0]);
            currentPage = 0;
            YOFFSET = 0;
            updatePagination();
            updateVerticalLimit();
        }
    }
    if (tableScreen.vscroll.cursorOverWidget()) {
        tableScreen.vscroll.click = true;
    }
    if (tableScreen.hscroll.cursorOverWidget()) {
        tableScreen.hscroll.click = true;
    }
}


void graphCreateScreenPress() {
    String[] buttonPressed = graphCreateScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (isLoadGraphActive()) {
        graphCreateScreen.buttonMap.get("loadGraph").active = true;
    }
    else {
        graphCreateScreen.buttonMap.get("loadGraph").active = false;
    }
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        // reset most options depending on which of the first graph type drop down menu option is selected
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
        if (buttonPressed[0].substring(0,3).equals("scx")) {
            // set the text store 1 to the scatter plot x data
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("scy")) {
            // set the text store 2 to the scatter plot y data
            graphCreateScreen.textStoreMap.get("2dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,4).equals("hsgd")) {
            // set text store 1 to the histogram data
            graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("bcc")) {
            if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Bar Chart")) {
                // set text store 1 to bar chart data if on bar chart
                graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
                if (!graphCreateScreen.textStoreMap.get("1dataH").textLabel.equals("")
                    && !graphCreateScreen.textStoreMap.get("2dataH").textLabel.equals("")) {
                        // set the other sort and number options to visible
                    graphCreateScreen.dropDownMap.get("bcNum").visible = true;
                    graphCreateScreen.dropDownMap.get("bcSort").visible = true;
                    graphCreateScreen.textStoreMap.get("bcNumH").visible = true;
                    graphCreateScreen.textStoreMap.get("bcSortH").visible = true;


                }
            }
            else if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Pi Chart")) {
                // set text store 1 to pi chart data type if on pi chart option
                graphCreateScreen.textStoreMap.get("1dataH").textLabel = buttonPressed[1];
            }


        }
        if (buttonPressed[0].length() > 5 && buttonPressed[0].substring(0,6).equals("bcSort")) {
            // set the sort text store to sort number
            graphCreateScreen.textStoreMap.get("bcSortH").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].length() > 4 && buttonPressed[0].substring(0,5).equals("bcNum")) {
            // set the number text store to number of bars
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

                    // can load bar chart, set the bar chart global variables and call the load bar chart dat function
                    showNumBC = int(graphCreateScreen.textStoreMap.get("bcNumH").textLabel);
                    if (graphCreateScreen.textStoreMap.get("bcSortH").textLabel.equals("Ascending")) {
                        ascendingBC = true;
                    }
                    else {
                        ascendingBC = false;
                    }
                    loadBarChartData(graphCreateScreen.textStoreMap.get("1dataH").textLabel, graphCreateScreen.textStoreMap.get("2dataH").textLabel);
                    
                    // change screens
                    OnGraphCreateScreen = false;
                    OnbarChartShowScreen = true;
                    currentScreen = barChartShowScreen;
                    currentScreen.updateHighlights();
                }
                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Pi Chart")) {
                    // call load pi chart data
                    loadPiChartData(graphCreateScreen.textStoreMap.get("1dataH").textLabel);
                    OnGraphCreateScreen = false;
                    OnPiChartShowScreen = true;
                    currentScreen = piChartShowScreen;
                    currentScreen.updateHighlights();

                }

                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Scatter Plot")) {
                    // change screen and load scatter plot with correct data
                    loadScatterPlotData(graphCreateScreen.textStoreMap.get("1dataH").textLabel, graphCreateScreen.textStoreMap.get("2dataH").textLabel);
                    OnGraphCreateScreen = false;
                    OnGraphShowScreen = true;
                    currentScreen = graphShowScreen;
                    currentScreen.updateHighlights();
                }
                if (graphCreateScreen.textStoreMap.get("gTypeH").textLabel.equals("Histogram")) {
                    // change screen and load histogram with correct data
                    loadHistogramData(graphCreateScreen.textStoreMap.get("1dataH").textLabel,graphCreateScreen.textEditMap.get("histogramBin").textLabel);
                    OnGraphCreateScreen = false;
                    OnHistogramShowScreen = true;
                    currentScreen = histogramShowScreen;
                    currentScreen.updateHighlights();
                }

            }
        }
        if (isLoadGraphActive()) {
        graphCreateScreen.buttonMap.get("loadGraph").active = true;
        }
    }
    
}


void graphShowScreenPress() {
    String[] buttonPressed = graphShowScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
            currentScreen.updateHighlights();
        }
    }
}

void barChartShowScreenPress() {
    String[] buttonPressed = barChartShowScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnbarChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
            currentScreen.updateHighlights();
        }
    }
}

void filterDataScreenPress() {
    String[] buttonPressed = filterDataScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
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
                filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
                setFilterText1("Insert Info: ");
            }

        }
        if (buttonPressed[0].length() > 5 && buttonPressed[0].substring(0,6).equals("filNum")) {
            filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
            filterDataScreen.textStoreMap.get("1TypeH").textLabel = buttonPressed[1];
            filterDataScreen.dropDownMap.get("typeNumFilter").visible = true;
            filterDataScreen.textStoreMap.get("2TypeH").visible = true;
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
            filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
            filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
            if (buttonPressed[0].equals("nFilTsingleVal")) {
                setFilterText1("Equals: ");
            }
            if (buttonPressed[0].equals("nFilTgreater")) {
                setFilterText1("Greater Than: ");
            }
            if (buttonPressed[0].equals("nFilTlesser")) {
                setFilterText1("Less Than: ");
            }
            if (buttonPressed[0].equals("nFilTrange")) {
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = true;
                setFilterText1("Greater Than: ");
                setFilterText2("Less Than: ");
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
        if (ifFilterActive()) {
        filterDataScreen.buttonMap.get("addFilter").active = true;
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



void handleHomePress(String buttonPressed) {
    if (buttonPressed.equals("homeB")) {
        OnHomeScreen = true;
        OnTableScreen = false;
        OnGraphCreateScreen = false;
        OnGraphShowScreen = false;
        OnbarChartShowScreen = false;
        OnBarGraphShowScreen = false;
        OnHistogramShowScreen = false;
        OnFilterDataScreen = false;
        OnSearchScreen = false;
        currentScreen = homeScreen;
        currentScreen.updateHighlights();
    }
}

void histogramShowScreenPress() {
    String[] buttonPressed = histogramShowScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnHistogramShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
            currentScreen.updateHighlights();
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
    String[] buttonPressed = piChartShowScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnPiChartShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
            currentScreen.updateHighlights();
        }
    }   
}


void changeTableTable(Screen s) {
    s.table.backgroundColor = color(#D4FCE4);
    s.table.cellColor =  color(#9AD6B1);
    s.table.titleColor = color(#2B9453);
}

void changeTableSearch(Screen s) {
    s.table.backgroundColor = color(#c5edfa);
    s.table.cellColor =  color(#a2d0fa);
    s.table.titleColor = color(#4ea4f5);
}

void searchScreenPress() {
    String[] buttonPressed = searchScreen.getButtonPressed();
    handleHomePress(buttonPressed[0]);
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Open") ) {
        if (buttonPressed[0].equals("clearButton")) {
                searchText = "";
                selectedColumn = "All";
                searchApplied = false;
                searchScreen.textEditMap.get("minDist").textLabel="";
                searchScreen.textEditMap.get("maxDist").textLabel="";
                searchScreen.textEditMap.get("endTime").textLabel="";
                searchScreen.textEditMap.get("startTime").textLabel="";

                applyFilters();


        }
        else {
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
            searchScreen.dropDownMap.get("filterColumn").textLabel = "Filter: " + selectedColumn;
            applyFilters();
        }

    }


}