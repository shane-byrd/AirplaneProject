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
        if (buttonPressed[0].substring(0,4).equals("show")) {
            // set the show array
            whichValues[(int) showLabelToIndex.get(buttonPressed[0])] = !whichValues[(int) showLabelToIndex.get(buttonPressed[0])];
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
        else if (buttonPressed[0].equals("sort")) { 
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
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("scOption")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").visible = true;
            graphCreateScreen.buttonMap.get("scndDataHolder").visible = true;
            graphCreateScreen.dropDownMap.get("scYData").visible = true;
            graphCreateScreen.dropDownMap.get("scXData").visible = true;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = false;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = false;
            graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel = buttonPressed[1];
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = "";
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = "";
            graphCreateScreen.dropDownMap.get("hsdOption").visible = false;
        }
        //
        if (buttonPressed[0].equals("bcOption")) {
            //OnGraphCreateScreen = false;
            //OnBarGraphShowScreen = true;
            //currentScreen = barGraphShowScreen;
            graphCreateScreen.buttonMap.get("fstDataHolder").visible = true;
            graphCreateScreen.buttonMap.get("scndDataHolder").visible = true;
            graphCreateScreen.dropDownMap.get("scYData").visible = false;
            graphCreateScreen.dropDownMap.get("scXData").visible = false;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = true;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = true;
            graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel = buttonPressed[1];
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = "";
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = "";
            graphCreateScreen.dropDownMap.get("hsdOption").visible = false;

                graphCreateScreen.dropDownMap.get("bcNum").visible = false;
                graphCreateScreen.buttonMap.get("bcChooseNumHold").textLabel = "";
                graphCreateScreen.buttonMap.get("bcChooseNumHold").visible = false;
                graphCreateScreen.dropDownMap.get("bcSort").visible = false;
                graphCreateScreen.buttonMap.get("bcSortHolder").visible = false;
                graphCreateScreen.buttonMap.get("bcSortHolder").textLabel = "";

        }
        if (buttonPressed[0].equals("hOption")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").visible = true;
            graphCreateScreen.dropDownMap.get("hsdOption").visible = true;
            graphCreateScreen.buttonMap.get("scndDataHolder").visible = false;
            graphCreateScreen.dropDownMap.get("scYData").visible = false;
            graphCreateScreen.dropDownMap.get("scXData").visible = false;
            graphCreateScreen.dropDownMap.get("bcCatOpt").visible = false;
            graphCreateScreen.dropDownMap.get("bcDataOpt").visible = false;
            graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel = buttonPressed[1];
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = "";
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = "his";
               graphCreateScreen.dropDownMap.get("bcNum").visible = false;
                graphCreateScreen.buttonMap.get("bcChooseNumHold").visible = false;
                graphCreateScreen.buttonMap.get("bcChooseNumHold").textLabel = "";
                graphCreateScreen.dropDownMap.get("bcSort").visible = false;
                graphCreateScreen.buttonMap.get("bcSortHolder").visible = false;
                graphCreateScreen.buttonMap.get("bcSortHolder").textLabel = "";

        }
        //
        if (buttonPressed[0].substring(0,3).equals("scx")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("scy")) {
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,4).equals("hsgd")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("bcc")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = buttonPressed[1];
            if (!graphCreateScreen.buttonMap.get("fstDataHolder").textLabel.equals(" ") && !graphCreateScreen.buttonMap.get("scndDataHolder").textLabel.equals(" ")) {
                graphCreateScreen.dropDownMap.get("bcNum").visible = true;
                graphCreateScreen.buttonMap.get("bcChooseNumHold").visible = true;
                graphCreateScreen.dropDownMap.get("bcSort").visible = true;
                graphCreateScreen.buttonMap.get("bcSortHolder").visible = true;
            }
        }
        if (buttonPressed[0].substring(0,6).equals("bcSort")) {
            graphCreateScreen.buttonMap.get("bcSortHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,5).equals("bcNum")) {
            graphCreateScreen.buttonMap.get("bcChooseNumHold").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("bcd")) {
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = buttonPressed[1];
            if (!graphCreateScreen.buttonMap.get("fstDataHolder").textLabel.equals("") && !graphCreateScreen.buttonMap.get("scndDataHolder").textLabel.equals(" ")) {
                graphCreateScreen.dropDownMap.get("bcNum").visible = true;
                graphCreateScreen.buttonMap.get("bcChooseNumHold").visible = true;
                graphCreateScreen.dropDownMap.get("bcSort").visible = true;
                graphCreateScreen.buttonMap.get("bcSortHolder").visible = true;
            }
        }
        if (buttonPressed[0].equals("loadGraph")) {
            if (!graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel.equals("")
            && !graphCreateScreen.buttonMap.get("fstDataHolder").textLabel.equals("")
            && !graphCreateScreen.buttonMap.get("scndDataHolder").textLabel.equals("")) {
                if (graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel.equals("Bar Chart")
                && !graphCreateScreen.buttonMap.get("bcChooseNumHold").textLabel.equals("")
                && !graphCreateScreen.buttonMap.get("bcSortHolder").textLabel.equals("")) {
                    // change screen and load bar chart with correct data
                    showNumBC = int(graphCreateScreen.buttonMap.get("bcChooseNumHold").textLabel);
                    loadBarChartData(graphCreateScreen.buttonMap.get("fstDataHolder").textLabel, graphCreateScreen.buttonMap.get("scndDataHolder").textLabel);
                    
                    if (graphCreateScreen.buttonMap.get("bcSortHolder").textLabel.equals("Ascending")) {
                        ascendingBC = true;
                    }
                    else {
                        ascendingBC = false;
                    }
                    OnGraphCreateScreen = false;
                    OnbarChartShowScreen = true;
                    currentScreen = barChartShowScreen;
                }
                if (graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel.equals("Scatter Plot")) {
                    // change screen and load scatter plot with correct data
                    loadScatterPlotData(graphCreateScreen.buttonMap.get("fstDataHolder").textLabel, graphCreateScreen.buttonMap.get("scndDataHolder").textLabel);
                    OnGraphCreateScreen = false;
                    OnGraphShowScreen = true;
                    currentScreen = graphShowScreen;
                }
                if (graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel.equals("Histogram")) {
                    // change screen and load histogram with correct data
                    loadHistogramData(graphCreateScreen.buttonMap.get("fstDataHolder").textLabel,"40");
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
            OnBarGraphShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnBarGraphShowScreen = false;
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
            OnBarGraphShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnBarGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = graphShowScreen.getButtonPressed();
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
            OnBarGraphShowScreen = false;
            OnTableScreen = true;
            currentScreen = tableScreen;
        }
        if (visualiseOption[0] == "vgraph") {
            OnBarGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
    String[] buttonPressed = filterDataScreen.getButtonPressed();
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("TypChNonNum")) {
            clearAllFilterOptions();
            filterDataScreen.buttonMap.get("typeDataFilterHolder").textLabel = buttonPressed[1];
            filterDataScreen.buttonMap.get("fstTypeHolder").visible = true;
            filterDataScreen.dropDownMap.get("filterNonNum").visible = true;

        }
        if (buttonPressed[0].equals("TypeChNum")) {
            filterDataScreen.buttonMap.get("typeDataFilterHolder").textLabel = buttonPressed[1];
            clearAllFilterOptions();
            filterDataScreen.buttonMap.get("fstTypeHolder").visible = true;
            filterDataScreen.dropDownMap.get("filterNum").visible = true;

        }
        if (buttonPressed[0].length() > 6 && buttonPressed[0].substring(0,6).equals("filNon")) {
                filterDataScreen.buttonMap.get("fstTypeHolder").textLabel = buttonPressed[1];
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

            }
            else {
                filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Insert Info Here: ";
                filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
            }

        }
        if (buttonPressed[0].length() > 6 && buttonPressed[0].substring(0,6).equals("filNum")) {
            filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
            filterDataScreen.buttonMap.get("fstTypeHolder").textLabel = buttonPressed[1];
            filterDataScreen.dropDownMap.get("typeNumFilter").visible = true;
            filterDataScreen.buttonMap.get("scndTypeHolder").visible = true;
            // set all the next values to empty or invisible;
            filterDataScreen.buttonMap.get("scndTypeHolder").textLabel = "";
            filterDataScreen.textEditMap.get("valueFirstHolder").visible = false;
            filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
            filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
            filterDataScreen.textEditMap.get("valueFirstHolder").textLabel = "";
            filterDataScreen.textEditMap.get("valueSecondHolder").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";

        }
        if (buttonPressed[0].length() > 4 && buttonPressed[0].substring(0,4).equals("nFil")) {
            filterDataScreen.buttonMap.get("scndTypeHolder").textLabel = buttonPressed[1];
            
            if (filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Time of day: Departure") || filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Time of day: Destination")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "Enter in format hhmm";
            }
            if (filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Delay: Departure") || filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Delay: Destination")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In minutes: ";
            }
            if (filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Distance")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In miles: ";
            }
            if (filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("Date")) {
                filterDataScreen.textBoxMap.get("InfoNum").textLabel = "In format DD/MM/YYYY: ";
            }
            //filterDataScreen.buttonMap.get("valueFstHolder").visible = true;
            filterDataScreen.textEditMap.get("valueFirstHolder").visible = true;
            filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
            filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
            if (buttonPressed[0].equals("nFilTsingleVal")) filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Equals: ";
            if (buttonPressed[0].equals("nFilTgreater")) filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Greater Than: ";
            if (buttonPressed[0].equals("nFilTlesser")) filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Less Than: ";
            if (buttonPressed[0].equals("nFilTrange")) {
                //filterDataScreen.buttonMap.get("valueScndHolder").visible = true;
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = true;
                filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "Greater Than: ";
                filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "Less Than: ";
            }
            else {
                filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
            }
        }
        if (buttonPressed[0].equals("addFilter")) {
            if (filterDataScreen.dropDownMap.get("filterNonNum").visible == true) {
                if (monthSet.contains(filterDataScreen.buttonMap.get("fstTypeHolder").textLabel)
                    || filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.length() > 7 && filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.substring(0,8).equals("Diverted")
                    || filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.length() > 8 && filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.substring(0,9).equals("Cancelled")
                
                ) {
                    filterDataNonNumerical(filterDataScreen.buttonMap.get("fstTypeHolder").textLabel, filterDataScreen.buttonMap.get("fstTypeHolder").textLabel);
                    if (errorMessageActive) {
                        clearAllFilterOptions();
                    }
                    else {
                        // if succesful
                    }
                }
                else {
                    if (!filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel.equals("")) {
                        filterDataNonNumerical(filterDataScreen.buttonMap.get("fstTypeHolder").textLabel, filterDataScreen.textEditMap.get("valueFirstHolder").textLabel);
                        if (errorMessageActive) {
                            clearAllFilterOptions();
                        }
                        else {
                            // if succesful
                        }
                    }
                }
            }
            else if (filterDataScreen.dropDownMap.get("filterNum").visible == true) {
                if (!filterDataScreen.buttonMap.get("fstTypeHolder").textLabel.equals("")
                    && !filterDataScreen.buttonMap.get("scndTypeHolder").textLabel.equals("")
                    && !filterDataScreen.buttonMap.get("valueFstHolder").textLabel.equals("")
                ) {
                    if (filterDataScreen.buttonMap.get("scndTypeHolder").textLabel.equals("Range")) {
                        if (!filterDataScreen.textEditMap.get("valueSecondHolder").textLabel.equals("")) {
                            //apply filter, reset screen
                            filterDataNumerical(filterDataScreen.buttonMap.get("fstTypeHolder").textLabel,
                            filterDataScreen.buttonMap.get("scndTypeHolder").textLabel,
                            filterDataScreen.textEditMap.get("valueFirstHolder").textLabel,
                            filterDataScreen.textEditMap.get("valueSecondHolder").textLabel);
                            if (errorMessageActive) {
                                clearAllFilterOptions();
                            }
                            else {
                                // if succesful
                            }
                        }
                    }
                    else {
                        //apply filter, reset screen
                        filterDataNumerical(filterDataScreen.buttonMap.get("fstTypeHolder").textLabel,
                        filterDataScreen.buttonMap.get("scndTypeHolder").textLabel,
                        filterDataScreen.textEditMap.get("valueFirstHolder").textLabel);
                        if (errorMessageActive) {
                            clearAllFilterOptions();
                        }
                        else {
                            // if succesful
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

        }
    }
}

void clearAllFilterOptions() {
    filterDataScreen.buttonMap.get("fstTypeHolder").visible = false;
    filterDataScreen.buttonMap.get("scndTypeHolder").visible = false;
    filterDataScreen.dropDownMap.get("filterNonNum").visible = false;
    filterDataScreen.dropDownMap.get("filterNum").visible = false;
    filterDataScreen.dropDownMap.get("typeNumFilter").visible = false;
    filterDataScreen.buttonMap.get("scndTypeHolder").textLabel = "";
    filterDataScreen.buttonMap.get("fstTypeHolder").textLabel = "";
    filterDataScreen.textEditMap.get("valueFirstHolder").visible = false;
    filterDataScreen.textEditMap.get("valueSecondHolder").visible = false;
    filterDataScreen.textBoxMap.get("InfoSmallTwo").textLabel = "";
    filterDataScreen.textBoxMap.get("InfoSmallOne").textLabel = "";
    filterDataScreen.textEditMap.get("valueFirstHolder").textLabel = "";
    filterDataScreen.textEditMap.get("valueSecondHolder").textLabel = "";
    filterDataScreen.textBoxMap.get("InfoNum").textLabel = "";
    filterDataScreen.buttonMap.get("typeDataFilterHolder").textLabel="";
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