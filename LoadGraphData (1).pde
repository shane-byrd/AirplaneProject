
void loadScatterPlotData(String xlabel, String ylabel) {
    if (xlabel.equals("Distance")) {
        scatterPlotXData = getDistance(filteredFlights);
        spXlabel = "Distance (miles)";
    }
    if (xlabel.equals("Departure Delay")) {
        scatterPlotXData = getDepartureDelay(filteredFlights);
        spXlabel = "Departure Delay Time (minutes)";
    }
    if (xlabel.equals("Arrival Delay")) {
        scatterPlotXData = getArrivalDelay(filteredFlights);
        spXlabel = "Arrival Delay Time (minutes)";
    }
    if (xlabel.equals("Duration")) {
        scatterPlotXData = getDuration(filteredFlights);
        spXlabel = "Duration (minutes)";
    }
    if (xlabel.equals("Time (year)")) {
        scatterPlotXData = getTimeYear(filteredFlights);
        spXlabel = "Time of year";
    }
    if (xlabel.equals("Scheduled Departure")) {
        scatterPlotXData = getTimeDaySTD(filteredFlights);
        spXlabel = "Time of day (Scheduled Departure)";
    }
    if (xlabel.equals("Actual Departure")) {
        scatterPlotXData = getTimeDayATD(filteredFlights);
        spXlabel = "Time of day (Actual Departure)";
    }
    if (xlabel.equals("Scheduled Arrival")) {
        scatterPlotXData = getTimeDaySTA(filteredFlights);
        spXlabel = "Time of day (Scheduled Arrival)";
    }
    if (xlabel.equals("Actual Arrival")) {
        scatterPlotXData = getTimeDayATA(filteredFlights);
        spXlabel = "Time of day (Actual Arrival)";
    }

    if (ylabel.equals("Distance")) {
        scatterPlotYData = getDistance(filteredFlights);
        spYlabel = "Distance (miles)";
    }
    if (ylabel.equals("Departure Delay")) {
        scatterPlotYData = getDepartureDelay(filteredFlights);
        spYlabel = "Departure Delay Time (minutes)";
    }
    if (ylabel.equals("Arrival Delay")) {
        scatterPlotYData = getArrivalDelay(filteredFlights);
        spYlabel = "Arrival Delay Time (minutes)";
    }
    if (ylabel.equals("Duration")) {
        scatterPlotYData = getDuration(filteredFlights);
        spYlabel = "Duration (minutes)";
    }
    if (ylabel.equals("Time (year)")) {
        scatterPlotYData = getTimeYear(filteredFlights);
        spYlabel = "Time of year";
    }
    if (ylabel.equals("Scheduled Departure")) {
        scatterPlotYData = getTimeDaySTD(filteredFlights);
        spYlabel = "Time of day (Scheduled Departure)";
    }
    if (ylabel.equals("Actual Departure")) {
        scatterPlotYData = getTimeDayATD(filteredFlights);
        spYlabel = "Time of day (Actual Departure)";
    }
    if (ylabel.equals("Scheduled Arrival")) {
        scatterPlotYData = getTimeDaySTA(filteredFlights);
        spYlabel = "Time of day (Scheduled Arrival)";
    }
    if (ylabel.equals("Actual Arrival")) {
        scatterPlotYData = getTimeDayATA(filteredFlights);
        spYlabel = "Time of day (Actual Arrival)";
    }

    float[] minMaxY = getMinAndMax(scatterPlotYData);
    float[] minMaxX = getMinAndMax(scatterPlotXData);

    scatterPlotRawMinX = minMaxX[0];
    scatterPlotRawMaxX = minMaxX[1];
    scatterPlotRawMinY = minMaxY[0];
    scatterPlotRawMaxY = minMaxY[1];

    minXsp = scatterPlotRawMinX;
    maxXsp = ensureDistinctUpper(scatterPlotRawMinX, scatterPlotRawMaxX);
    minYsp = scatterPlotRawMinY;
    maxYsp = ensureDistinctUpper(scatterPlotRawMinY, scatterPlotRawMaxY);
    spTitle = "Scatter Plot of " +spXlabel+ " vs. "+ spYlabel;

    resetScatterPlotScaleControls();
}

void loadBarChartData(String category, String data) {
    categoryMap = getHashData(category,data,filteredFlights);
    if (categoryMap.size() < showNumBC) {
        showNumBC = categoryMap.size();
    }
    List<Map.Entry<String, Float>> sorted = new ArrayList<>(categoryMap.entrySet());
    if (ascendingBC) {
        sorted.sort(Map.Entry.comparingByValue());
    }
    else {
        sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));
    }
    showBCdata = sorted.subList(0, Math.min(showNumBC, sorted.size()));

    float[] minmaxarray = getMinMaxShowData();
    barChartRawMinY = minmaxarray[0];
    barChartRawMaxY = minmaxarray[1];
    minBCval = barChartRawMinY;
    maxBCval = ensureDistinctUpper(barChartRawMinY, barChartRawMaxY);

    barChartVisibleStartIndex = 0;
    barChartVisibleEndIndexExclusive = showBCdata.size();

    titleBC = data +" for " + category + " bar chart";
    yLabelBC = data;

    resetBarChartScaleControls();
}

void loadHistogramData(String category, String binAmount) {
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
    histogramYLabel = category;
    Collections.sort(histogramData);
    histogramRawMinX = histogramData.get(0);
    histogramRawMaxX = histogramData.get(histogramData.size()-1);
    minValueHistogram = histogramRawMinX;
    maxValueHistogram = histogramRawMaxX;
    histogramBinAmount = float(binAmount);
    float intervalValueWidth = histogramShowScreen.histogram.getIntervalWidth(histogramBinAmount, histogramRawMinX, histogramRawMaxX);
    intervalWidthHistogram = intervalValueWidth;
    int i = 0;
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
    hsType = type;
    histogramRawMinY = minfreq;
    histogramRawMaxY = maxfreq;
    minfreqHistogram = histogramRawMinY;
    maxfreqHistogram = max(1, histogramRawMaxY);
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
    else  {
        return String.format("%.0f",input);
    }
}
