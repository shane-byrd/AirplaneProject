//text label name
void loadScatterPlotData(String xlabel, String ylabel) {
    String type = "";
    if (xlabel.equals("Distance")) {
        scatterPlotXData = getDistance(filteredFlights);
        spXlabel = "Distance (miles)";
    }
    if (xlabel.equals("Departure Delay")) {
        scatterPlotXData = getDepartureDelay(filteredFlights);
        spXlabel = "Departure Delay Time (minutes)";
        type="timeScatter";
    }
    if (xlabel.equals("Arrival Delay")) {
        scatterPlotXData = getArrivalDelay(filteredFlights);
        spXlabel = "Arrival Delay Time (minutes)";
        type="timeScatter";
    }
    if (xlabel.equals("Duration")) {
        scatterPlotXData = getDuration(filteredFlights);
        spXlabel = "Duration (minutes)";
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
        spYlabel = "Departure Delay Time (minutes)";
        type="timeScatter";
    }
    if (ylabel.equals("Arrival Delay")) {
        scatterPlotYData = getArrivalDelay(filteredFlights);
        spYlabel = "Arrival Delay Time (minutes)";
        type="timeScatter";
    }
    if (ylabel.equals("Duration")) {
        scatterPlotYData = getDuration(filteredFlights);
        spYlabel = "Duration (minutes)";
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
    float[] minMaxY = getMinAndMax(scatterPlotYData);
    float[] minMaxX = getMinAndMax(scatterPlotXData);
    minXsp = minMaxX[0];
    maxXsp = minMaxX[1];
    minYsp = minMaxY[0];
    maxYsp = minMaxY[1];
    spTitle = "Scatter Plot of " +spXlabel+ " vs. "+ spYlabel;

}

void loadBarChartData(String category, String data) {
    categoryMap = getHashData(category,data,filteredFlights);

    if (categoryMap.size() < showNumBC) {
        showNumBC = categoryMap.size();
    }
    List<Map.Entry<String, Float>> sorted = new ArrayList<>(categoryMap.entrySet());
    for (Map.Entry<String, Float> entry : sorted) {
        String key = entry.getKey();
        Float value = entry.getValue();
    }
    if (ascendingBC) {
        sorted.sort(Map.Entry.comparingByValue()); // ascending
    }
    else {
        sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder())); // descending
    }
    showBCdata = sorted.subList(0, Math.min(showNumBC, sorted.size()));

    float[] minmaxarray = getMinMaxShowData();
    //float[] minmaxarray = getMinMaxBCVal();
    minBCval = minmaxarray[0];
    maxBCval = minmaxarray[1];
    titleBC = data +" for " + category + " Bar Chart";
    yLabelBC =data;
}


void loadHistogramData(String category, String binAmount) {
    String type="";
    switch(category) {
        case "Duration":
            histogramData = getDuration(filteredFlights);
            type = "timeScatter";
            break;
        case "Distance":
            histogramData = getDistance(filteredFlights);
            break;
        case "Time of Day: Departure":
            type="timeScatter";
            histogramData = getTimeDayATD(filteredFlights);
            break;
        case "Time of Day: Destination":
            type="timeScatter";
            histogramData = getTimeDayATD(filteredFlights);
            break;
        case "Delay Time: Departure":
        type = "timeScatter";
            histogramData = getDepartureDelay(filteredFlights);
            break;
        case "Delay Time: Destination":
        type="timeScatter";
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
    minValueHistogram = histogramData.get(0); 
    maxValueHistogram = histogramData.get(histogramData.size()-1);
    histogramBinAmount = float(binAmount);
    float intervalValueWidth = histogramShowScreen.histogram.getIntervalWidth(histogramBinAmount, minValueHistogram, maxValueHistogram);
    intervalWidthHistogram = intervalValueWidth;
    int i = 0;
    intervalFrequencyData = new int[int(histogramBinAmount)+1];
    for (float value : histogramData) {
        if (value <((i+1)*intervalValueWidth) + minValueHistogram) {
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
    if (minfreq > 0) {
        minfreqHistogram = (int) ((float)minfreq/2.0);
    }
    hsType = type;
    minfreqHistogram = minfreq;
    maxfreqHistogram = maxfreq;
    histogramTitle = "Histogram of "+category+" with "+String.format("%.0f",histogramBinAmount)+" intervals.";

}


String getCorrectFormat(float input, String type) {
    if (type == "dateOneYear") {
        return String.format("%.0f",input);
        //return getYearInt(input);
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
    categoryMap = getHashData(category,"Frequency",filteredFlights);

    List<Map.Entry<String, Float>> sorted = new ArrayList<>(categoryMap.entrySet());
    for (Map.Entry<String, Float> entry : sorted) {
        String key = entry.getKey();
        Float value = entry.getValue();
    }
    piTotal = (float) filteredFlights.size();

    sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder())); // descending

    piFreqData = sorted;
    titlePC = "Pi Chart of " + category;
}