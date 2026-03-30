class Screen {
    ArrayList<Button> buttons;
    HashMap<String, Button> buttonMap;
    ArrayList<DropDown> ddMenus;
    ArrayList<StaticRect> staticRects;
    Table table;
    ScatterPlot scatterPlot;
    BarChart barChart;
    HorizontalScrollBar hscroll;
    VerticalScrollBar vscroll;
    BarGraph barGraph;
    RangeSlider rangeSlider;

    boolean hasVerticalScroll;
    boolean hasHorizontalScroll;
    //boolean hasBarChart;
    boolean hasScatterPlot;
    boolean hasTable;
    boolean hasBarGraph;
    boolean hasRangeSlider;

    int minXOffset;
    int maxXOffset;
    int minYOffset;
    int maxYOffset;
    int curXOffset;
    int curYOffset;
    
    Screen() {
        ddMenus = new ArrayList<DropDown>();
        buttons = new ArrayList<Button>();
        staticRects = new ArrayList<StaticRect>();
        buttonMap = new HashMap<String, Button>();

        this.hasVerticalScroll = false;
        this.hasHorizontalScroll = false;
        //this.hasBarChart = false;
        this.hasScatterPlot = false;
        this.hasTable = false;
        this.hasBarGraph = false;
        this.hasRangeSlider = false;
    }
    
    void draw() {

        if (hasTable) {
            table.draw(titleData, filteredFlights, whichValues);
            MAXYOFFSET = max(0, int((table.cellH + table.gapY) * max(0, filteredFlights.size() - 20)));
            clampScroll();
        }
        for (StaticRect sr : staticRects) {
            sr.draw();
        }
        for (Button b : buttons) {
            b.draw();
        }
        for (DropDown dd : ddMenus) {
            dd.draw();
        }
        if (hasScatterPlot) {
            scatterPlot.draw(scatterPlotXData,scatterPlotYData,minXsp,maxXsp,minYsp,maxYsp,spTitle, spXlabel, spYlabel);
        }
        if (hasBarGraph) {
            barGraph.updateData(filteredFlights);
            barGraph.draw();
        }
        if (hasVerticalScroll) {
            vscroll.draw();
        }
        if (hasHorizontalScroll) {
            hscroll.draw();
        }
        if (hasRangeSlider) {
            rangeSlider.draw();
        }
    }

    void addButton(Button b) {
        buttons.add(b);
        buttonMap.put(b.idLabel, b);
    }
    void addDropDownMenu(DropDown dd) {
        ddMenus.add(dd);
    }
    void addStaticRect(StaticRect sr) {
        staticRects.add(sr);
    }

    // give idlabel and text label of button or item pressed
    String[] getButtonPressed() {
        String[] returnString = {"None","None"};
        for (DropDown dd : ddMenus) {
            
            String[] checkString = handleDropDownArray(dd);
            if (!checkString[0].equals("None") && !checkString[0].equals("Opened")) {
                //return returnString;
                returnString[0] = checkString[0];
                returnString[1] = checkString[1];
            }
        }
        for (Button b : buttons) {
            if (b.cursorOverWidget()) {
                String[] reString = {b.idLabel, b.textLabel};
                return reString;
            }
        }
        return returnString;
    }
    void handleDropDownMenuPress() {
        for (DropDown dd : ddMenus) {
            handleDropDownArray(dd);
        }
    }
}