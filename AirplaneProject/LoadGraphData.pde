// functions to load graph data, (title, x and y label, data points, etc) with appropriate data when the load graph 
// button is pressed, written By Shane Byrd
//
void loadScatterPlotData(String xlabel, String ylabel) {
    // load the x and y data based on the x label or ylabel
    String type = "";
    if (xlabel.equals("Distance")) {
        scatterPlotXData = getDistance(filteredFlights);
        spXlabel = "Distance (miles)";
    }
    if (xlabel.equals("Departure Delay")) {
        scatterPlotXData = getDepartureDelay(filteredFlights);
        spXlabel = "Departure Delay Time (hours:minutes)";
        type="timeScatter";
    }
    if (xlabel.equals("Arrival Delay")) {
        scatterPlotXData = getArrivalDelay(filteredFlights);
        spXlabel = "Arrival Delay Time (hours:minutes)";
        type="timeScatter";
    }
    if (xlabel.equals("Duration")) {
        scatterPlotXData = getDuration(filteredFlights);
        spXlabel = "Duration (hours:minutes)";
        type="timeScatter";
    }
    if (xlabel.equals("Time (year)")) {
        scatterPlotXData = getTimeYear(filteredFlights);
        spXlabel = "Time of year";

    }
    if (xlabel.equals("Scheduled Departure")) {
        scatterPlotXData = getTimeDaySTD(filteredFlights);
        spXlabel = "Time of day (Scheduled Departure)";
        type="timeScatter";
    }
    if (xlabel.equals("Actual Departure")) {
        scatterPlotXData = getTimeDayATD(filteredFlights);
        spXlabel = "Time of day (Actual Departure)";
        type="timeScatter";
    }
    if (xlabel.equals("Scheduled Arrival")) {
        scatterPlotXData = getTimeDaySTA(filteredFlights);
        spXlabel = "Time of day (Scheduled Arrival)";
        type="timeScatter";
    }
    if (xlabel.equals("Actual Arrival")) {
        scatterPlotXData = getTimeDayATA(filteredFlights);
        spXlabel = "Time of day (Actual Arrival)";
        type="timeScatter";
    }
    scatterTypeX = type;
    type="";

    //ylabel
    if (ylabel.equals("Distance")) {
        scatterPlotYData = getDistance(filteredFlights);
        spYlabel = "Distance (miles)";
    }
    if (ylabel.equals("Departure Delay")) {
        scatterPlotYData = getDepartureDelay(filteredFlights);
        spYlabel = "Departure Delay Time (hours:minutes)";
        type="timeScatter";
    }
    if (ylabel.equals("Arrival Delay")) {
        scatterPlotYData = getArrivalDelay(filteredFlights);
        spYlabel = "Arrival Delay Time (hours:minutes)";
        type="timeScatter";
    }
    if (ylabel.equals("Duration")) {
        scatterPlotYData = getDuration(filteredFlights);
        spYlabel = "Duration (hours:minutes)";
        type="timeScatter";
    }
    if (ylabel.equals("Time (year)")) {
        scatterPlotYData = getTimeYear(filteredFlights);
        spYlabel = "Time of year";
    }
    if (ylabel.equals("Scheduled Departure")) {
        scatterPlotYData = getTimeDaySTD(filteredFlights);
        spYlabel = "Time of day (Scheduled Departure)";
        type="timeScatter";
    }
    if (ylabel.equals("Actual Departure")) {
        scatterPlotYData = getTimeDayATD(filteredFlights);
        spYlabel = "Time of day (Actual Departure)";
        type="timeScatter";
    }
    if (ylabel.equals("Scheduled Arrival")) {
        scatterPlotYData = getTimeDaySTA(filteredFlights);
        spYlabel = "Time of day (Scheduled Arrival)";
        type="timeScatter";
    }
    if (ylabel.equals("Actual Arrival")) {
        scatterPlotYData = getTimeDayATA(filteredFlights);
        spYlabel = "Time of day (Actual Arrival)";
        type="timeScatter";
    }
    scatterTypeY = type;

    // find min and max
    float[] minMaxY = getMinAndMax(scatterPlotYData);
    float[] minMaxX = getMinAndMax(scatterPlotXData);

    // set min and max to higher and to minimum of zero
    scatterPlotRawMinX = min(0,minMaxX[0]*1.2);
    scatterPlotRawMaxX = minMaxX[1] * 1.2;
    scatterPlotRawMinY = min(minMaxY[0]*1.2,0);
    scatterPlotRawMaxY = minMaxY[1] * 1.2;

    // randomise the data so that the sorting order doesnt have negative consqeuences for larger datasets
    Random rand = new Random();
    if (scatterPlotXData.size() == scatterPlotYData.size()) {
        for (int i = scatterPlotXData.size() - 1; i > 0; i--) {
            int j = rand.nextInt(i + 1);

            Collections.swap(scatterPlotXData, i, j);
            Collections.swap(scatterPlotYData, i, j);
        }
    }


    minXsp = scatterPlotRawMinX;
    maxXsp = ensureDistinctUpper(scatterPlotRawMinX, scatterPlotRawMaxX);
    minYsp = scatterPlotRawMinY;
    maxYsp = ensureDistinctUpper(scatterPlotRawMinY, scatterPlotRawMaxY);
    maxYsp = ensureDistinctUpper(minMaxY[0], minMaxY[1]);

    //set title data
    spTitle = "Scatter Plot of " +spXlabel+ " vs. "+ spYlabel;

    resetScatterPlotScaleControls();
}

void loadBarChartData(String category, String data) {
    // get hashmap of data
    categoryMap = getHashData(category,data,filteredFlights);

    // reset the show number if its too large
    if (categoryMap.size() < showNumBC) {
        showNumBC = categoryMap.size();
    }

    // create a list that is showNumBC long
    List<Map.Entry<String, Float>> sorted = new ArrayList<>(categoryMap.entrySet());

    // sort the list depending on ascendingBC
    if (ascendingBC) {
        sorted.sort(Map.Entry.comparingByValue());
    }
    else {
        sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));
    }
    showBCdata = sorted.subList(0, Math.min(showNumBC, sorted.size()));

    // find min and max
    float[] minmaxarray = getMinMaxShowData();
    barChartRawMinY = min(minmaxarray[0]*1.3,0);
    barChartRawMaxY = minmaxarray[1] * 1.3;
    minBCval = barChartRawMinY;
    maxBCval = ensureDistinctUpper(barChartRawMinY, barChartRawMaxY);
    barChartVisibleStartIndex = 0;
    barChartVisibleEndIndexExclusive = showBCdata.size();

    // set title data and label data
    titleBC = data +" for " + category + " Bar Chart";
    yLabelBC = data;

    resetBarChartScaleControls();
}

void loadHistogramData(String category, String binAmount) {
    // load histogram data depending on which category
    String type="";
    switch(category) {
        case "Duration":
            histogramData = getDuration(filteredFlights);
            break;
        case "Distance":
            histogramData = getDistance(filteredFlights);
            break;
        case "Time of Day: Departure":
            type="time";
            histogramData = getTimeDayATD(filteredFlights);
            break;
        case "Time of Day: Destination":
            type="time";
            histogramData = getTimeDayATD(filteredFlights);
            break;
        case "Delay Time: Departure":
            histogramData = getDepartureDelay(filteredFlights);
            break;
        case "Delay Time: Destination":
            histogramData = getArrivalDelay(filteredFlights);
            break;
        case "Date":
            type="date";
            histogramData = getTimeDate(filteredFlights);
            break;
        default:
            println("Unknown histogram category: " + category+".");
    }

    // set thelabel
    histogramYLabel = category;

    // sort data to find min and max
    Collections.sort(histogramData);
    histogramRawMinX = histogramData.get(0);
    histogramRawMaxX = histogramData.get(histogramData.size()-1);
    minValueHistogram = histogramRawMinX;
    maxValueHistogram = histogramRawMaxX;

    // get interval width based on interval width algorithm
    histogramBinAmount = float(binAmount);
    float intervalValueWidth = histogramShowScreen.histogram.getIntervalWidth(histogramBinAmount, histogramRawMinX, histogramRawMaxX);
    intervalWidthHistogram = intervalValueWidth;
    int i = 0;

    // create the frequency array
    intervalFrequencyData = new int[int(histogramBinAmount)+1];
    for (float value : histogramData) {
        if (value <((i+1)*intervalValueWidth) + histogramRawMinX) {
            intervalFrequencyData[i]++;
        }
        else {
            i++;
            if (i>(int) histogramBinAmount) {
                break;
            }
            intervalFrequencyData[i]++;
        }
    }

    // find min and max frequency
    int minfreq = 0;
    int maxfreq = intervalFrequencyData[0];
    for (int freq : intervalFrequencyData) {
        if (freq < minfreq) {
            minfreq = freq;
        }
        if (freq > maxfreq) {
            maxfreq = freq;
        }
    }

    // define the type of data
    hsType = type;

    // set min and max
    histogramRawMinY = min(minfreq,0);
    histogramRawMaxY = (int)( (float)maxfreq * 1.5);
    minfreqHistogram = histogramRawMinY;
    maxfreqHistogram = max(1, histogramRawMaxY);

    // set title
    histogramTitle = "Histogram of "+category+" with "+String.format("%.0f",histogramBinAmount)+" intervals.";

    resetHistogramScaleControls();
}
String getCorrectFormat(float input, String type) {
    if (type == "dateOneYear") {
        return String.format("%.0f",input);
    }
    if (type == "date") {
        return convertDateIntToDDMMYYYY((int)input);
    }
    if (type == "time") {
        return mintoHHMMConvert((int)input);
    }
    if (type == "timeScatter") {
        return minToHoursandMin((int)input);
    }
    else  {
        return String.format("%.0f",input);
    }
}

void loadPiChartData(String category) {

    // use bar charts frequency category
    categoryMap = getHashData(category,"Frequency",filteredFlights);

    List<Map.Entry<String, Float>> sorted = new ArrayList<>(categoryMap.entrySet());

    // define total number of items in the data set
    piTotal = (float) filteredFlights.size();

    // sort in descending order
    sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder())); 

    // set title and data
    piFreqData = sorted;
    titlePC = "Pi Chart of " + category;
}