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

    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].substring(0,4).equals("show")) {
            // set the show array
            whichValues[(int) showLabelToIndex.get(buttonPressed[0])] = !whichValues[(int) showLabelToIndex.get(buttonPressed[0])];
        }
        else { // must be sort button
            sortFlights(buttonPressed[0]);
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

    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("scOption")) {
            graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel = buttonPressed[1];
        }
        //
        if (buttonPressed[0].equals("bcOption")) {
            OnGraphCreateScreen = false;
            OnBarGraphShowScreen = true;
            currentScreen = barGraphShowScreen;
        }
        //
        if (buttonPressed[0].substring(0,3).equals("scx")) {
            graphCreateScreen.buttonMap.get("fstDataHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].substring(0,3).equals("scy")) {
            graphCreateScreen.buttonMap.get("scndDataHolder").textLabel = buttonPressed[1];
        }
        if (buttonPressed[0].equals("loadGraph")) {
            if (graphCreateScreen.buttonMap.get("typeGraphHolder").textLabel.equals("Scatter Plot")
            && !graphCreateScreen.buttonMap.get("fstDataHolder").textLabel.equals(" ")
            && !graphCreateScreen.buttonMap.get("scndDataHolder").textLabel.equals(" ")) {
                // change screen and load scatter plot with correct data
                loadScatterPlotData(graphCreateScreen.buttonMap.get("fstDataHolder").textLabel, graphCreateScreen.buttonMap.get("scndDataHolder").textLabel);
                OnGraphCreateScreen = false;
                OnGraphShowScreen = true;
                currentScreen = graphShowScreen;
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
    if (!buttonPressed[0].equals("None") && !buttonPressed[0].equals("Opened")) {
        if (buttonPressed[0].equals("backW")) {
            OnGraphShowScreen = false;
            OnGraphCreateScreen = true;
            currentScreen = graphCreateScreen;
        }
    }
}