// class to represent a screen, and deal with screen interactions, (mouse movement and press) and drawing
// written by Xubo 
class Screen {
    ArrayList<Button> buttons;
    ArrayList<TextBox> textBoxes;
    ArrayList<TextEdit> textEdits;
    ArrayList<TextStore> textStores;
    HashMap<String, Button> buttonMap;
    HashMap<String, DropDown> dropDownMap;
    HashMap<String, TextBox> textBoxMap;
    HashMap<String, TextEdit> textEditMap;
    HashMap<String, TextStore> textStoreMap;
    ArrayList<DropDown> ddMenus;
    ArrayList<StaticRect> staticRects;
    boolean hasActiveTextField;
    TextEdit activeTextField;
    Table table;
    ScatterPlot scatterPlot;
    BarChart barChart;
    Histogram histogram;
    PiChart piChart;
    HorizontalScrollBar hscroll;
    VerticalScrollBar vscroll;
    RangeSlider rangeSlider;

    boolean hasVerticalScroll;
    boolean hasHorizontalScroll;
    boolean hasBarChart;
    boolean hasScatterPlot;
    boolean hasTable;
    boolean hasRangeSlider;
    boolean hasTextEdit;
    boolean hasHistogram;
    boolean hasPiChart;
    boolean hasSearchTable;

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
        textStores = new ArrayList<TextStore>();
        textStoreMap = new HashMap<String, TextStore>();
        this.hasVerticalScroll = false;
        this.hasHorizontalScroll = false;
        this.hasBarChart = false;
        this.hasScatterPlot = false;
        this.hasTable = false;
        this.hasSearchTable = false;
        this.hasRangeSlider = false;
        this.hasActiveTextField = false;
        this.hasHistogram = false;
        this.hasPiChart = false;
    }
    
    void draw() {
        // call each of the screens attributes draw function
        if (hasTable) {
            table.draw(titleData,filteredFlights,whichValues);
        }
        if (hasSearchTable) {
            table.draw(titleData,searchFlights,whichValues);
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
        for (TextStore ts : textStores) {
            ts.draw();
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

        if (hasHistogram) {
            histogram.draw(intervalFrequencyData,minValueHistogram,maxValueHistogram,minfreqHistogram,maxfreqHistogram,histogramTitle,histogramYLabel,intervalWidthHistogram,hsType);
        }
        if (hasPiChart) {
            piChart.draw();
        }
        if (hasHorizontalScroll) {
            hscroll.draw();
        }
        if (hasVerticalScroll) {
            vscroll.draw();
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
    void addTextStore(TextStore ts) {
        textStores.add(ts);
        textStoreMap.put(ts.idLabel, ts); 
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

    // Shane byrd additions
    // give idlabel and text label of button or item pressed
    String[] getButtonPressed() {
        String[] returnString = {"None","None"};
        // use recursive logic for drop down menus
        for (DropDown dd : ddMenus) {
            if (dd.visible) {
                String[] checkString = handleDropDownArray(dd);
                if (!checkString[0].equals("None") && !checkString[0].equals("Opened")) {
                    returnString[0] = checkString[0];
                    returnString[1] = checkString[1];
                }
            }
        }

        // handle buttons
        for (Button b : buttons) {
            if (b.visible) {
                if (b.cursorOverWidget()) {
                    String[] reString = {b.idLabel, b.textLabel};
                    return reString;
                }
            }
        }

        // handle making text fields active
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

    //update the pressed state of buttons and drop downs
    void updateMousePress() {
        for (Button b : buttons) {
            if (b.cursorOverWidget()) {
                b.pressed = true;
                b.mouseOver = false;
            }
        }
        for (DropDown dd : ddMenus) {
            if (dd.visible) {
                handleDropDownMousePress(dd);
            }
        }

    }

    //update highlight state of buttons and dropdowns
    void updateHighlights() {
        for (Button b : buttons) {
            b.mouseOver = b.cursorOverWidget();
        }
        for (DropDown dd : ddMenus) {
            if (dd.visible) {
                handleDropDownHighlight(dd);
            }
        }

    }

    //update pressed state of buttons and highlights
    void updateMouseReleased() {
        for (Button b : buttons) {
            b.pressed = false;
            b.mouseOver = b.cursorOverWidget();
        }
        for (DropDown dd : ddMenus) {
            if (dd.visible) {
                handleDropDownReleased(dd);
            }
        }
    }
}