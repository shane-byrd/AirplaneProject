class Screen {
    ArrayList<Button> buttons;
    ArrayList<TextBox> textBoxes;
    ArrayList<TextEdit> textEdits;
    HashMap<String, Button> buttonMap;
    HashMap<String, DropDown> dropDownMap;
    HashMap<String, TextBox> textBoxMap;
    HashMap<String, TextEdit> textEditMap;
    ArrayList<DropDown> ddMenus;
    ArrayList<StaticRect> staticRects;
    boolean hasActiveTextField;
    TextEdit activeTextField;
    Table table;
    ScatterPlot scatterPlot;
    BarChart barChart;
    Histogram histogram;
    HorizontalScrollBar hscroll;
    VerticalScrollBar vscroll;
    BarGraph barGraph;
    RangeSlider rangeSlider;

    boolean hasVerticalScroll;
    boolean hasHorizontalScroll;
    boolean hasBarChart;
    boolean hasScatterPlot;
    boolean hasTable;
    boolean hasBarGraph;
    boolean hasRangeSlider;
    boolean hasTextEdit;
    boolean hasHistogram;

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
        dropDownMap = new HashMap<String, DropDown>();
        textBoxMap = new HashMap<String, TextBox>();
        textBoxes = new ArrayList<TextBox>();
        textEdits = new ArrayList<TextEdit>();
        textEditMap = new HashMap<String, TextEdit>();
        this.hasVerticalScroll = false;
        this.hasHorizontalScroll = false;
        this.hasBarChart = false;
        this.hasScatterPlot = false;
        this.hasTable = false;
        this.hasBarGraph = false;
        this.hasRangeSlider = false;
        this.hasActiveTextField = false;
        this.hasHistogram = false;
    }
    
    void draw() {

        if (hasTable) {
            //table.draw(titleData,flights,whichValues);
            table.draw(titleData,filteredFlights,whichValues);
        }
        for (StaticRect sr : staticRects) {
            sr.draw();
        }
        for (TextBox tx : textBoxes) {
            tx.draw();
        }
        for (Button b : buttons) {
            b.draw();
        }
        for (DropDown dd : ddMenus) {
            dd.draw();
        }
        for (TextEdit te : textEdits) {
            te.draw();
        }
        if (hasScatterPlot) {
            scatterPlot.draw(scatterPlotXData,scatterPlotYData,minXsp,maxXsp,minYsp,maxYsp,spTitle, spXlabel, spYlabel);
        }
        if (hasBarChart) {
            barChart.draw();
        }
        if (hasBarGraph) {
            barGraph.draw();
        }
        if (hasHistogram) {
            histogram.draw(intervalFrequencyData,minValueHistogram,maxValueHistogram,minfreqHistogram,maxfreqHistogram,histogramTitle,histogramYLabel,intervalWidthHistogram,hsType);
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
    void addTextBox(TextBox tx) {
        textBoxes.add(tx);
        textBoxMap.put(tx.idLabel, tx);
        
    }
    void addTextEdit(TextEdit te) {
        textEdits.add(te);
        textEditMap.put(te.idLabel, te);
        activeTextField = te;
    }
    void addDropDownMenu(DropDown dd) {
        ddMenus.add(dd);
        dropDownMap.put(dd.idLabel, dd);
    }
    void addStaticRect(StaticRect sr) {
        staticRects.add(sr);
    }

    // give idlabel and text label of button or item pressed
    String[] getButtonPressed() {
        String[] returnString = {"None","None"};
        for (DropDown dd : ddMenus) {
            if (dd.visible) {
                String[] checkString = handleDropDownArray(dd);
                if (!checkString[0].equals("None") && !checkString[0].equals("Opened")) {
                    //return returnString;
                    returnString[0] = checkString[0];
                    returnString[1] = checkString[1];
                }
            }
            

        }
        for (Button b : buttons) {
            if (b.visible) {
                if (b.cursorOverWidget()) {
                    String[] reString = {b.idLabel, b.textLabel};
                    return reString;
                }
            }
        }
        boolean tePress=false;
        for (TextEdit textED : textEdits) {
            if (textED.visible) {
                if (textED.cursorOverWidget()) {
                    tePress = true;
                    if (textED.active) {
                        textED.active = false;
                        hasActiveTextField = false;
                    }
                    else {

                        activeTextField.active = false;
                        textED.active = true;
                        hasActiveTextField = true;
                        activeTextField = textED;
                    }

                }
            }
        }
        if (!tePress) {
            for (TextEdit ted : textEdits) {
                ted.active = false;
                hasActiveTextField = false;
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