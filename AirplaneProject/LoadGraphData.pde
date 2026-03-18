//text label name
void loadScatterPlotData(String xlabel, String ylabel) {
    if (xlabel.equals("Distance")) {
        scatterPlotXData = getDistance(flights);
        spXlabel = "Distance (miles)";
    }
    if (xlabel.equals("Departure Delay")) {
        scatterPlotXData = getDepartureDelay(flights);
        spXlabel = "Departure Delay Time (minutes)";
    }
    if (xlabel.equals("Arrival Delay")) {
        scatterPlotXData = getArrivalDelay(flights);
        spXlabel = "Arrival Delay Time (minutes)";
    }
    if (xlabel.equals("Duration")) {
        scatterPlotXData = getDuration(flights);
        spXlabel = "Duration (minutes)";
    }
    if (xlabel.equals("Time (year)")) {
        scatterPlotXData = getTimeYear(flights);
        spXlabel = "Time of year";
    }
    if (xlabel.equals("Scheduled Departure")) {
        scatterPlotXData = getTimeDaySTD(flights);
        spXlabel = "Time of day (Scheduled Departure)";
    }
    if (xlabel.equals("Actual Departure")) {
        scatterPlotXData = getTimeDayATD(flights);
        spXlabel = "Time of day (Actual Departure)";
    }
    if (xlabel.equals("Scheduled Arrival")) {
        scatterPlotXData = getTimeDaySTA(flights);
        spXlabel = "Time of day (Scheduled Arrival)";
    }
    if (xlabel.equals("Actual Arrival")) {
        scatterPlotXData = getTimeDayATA(flights);
        spXlabel = "Time of day (Actual Arrival)";
    }

    //ylabel
    if (ylabel.equals("Distance")) {
        scatterPlotYData = getDistance(flights);
        spYlabel = "Distance (miles)";
    }
    if (ylabel.equals("Departure Delay")) {
        scatterPlotYData = getDepartureDelay(flights);
        spYlabel = "Departure Delay Time (minutes)";
    }
    if (ylabel.equals("Arrival Delay")) {
        scatterPlotYData = getArrivalDelay(flights);
        spYlabel = "Arrival Delay Time (minutes)";
    }
    if (ylabel.equals("Duration")) {
        scatterPlotYData = getDuration(flights);
        spYlabel = "Duration (minutes)";
    }
    if (ylabel.equals("Time (year)")) {
        scatterPlotYData = getTimeYear(flights);
        spYlabel = "Time of year";
    }
    if (ylabel.equals("Scheduled Departure")) {
        scatterPlotYData = getTimeDaySTD(flights);
        spYlabel = "Time of day (Scheduled Departure)";
    }
    if (ylabel.equals("Actual Departure")) {
        scatterPlotYData = getTimeDayATD(flights);
        spYlabel = "Time of day (Actual Departure)";
    }
    if (ylabel.equals("Scheduled Arrival")) {
        scatterPlotYData = getTimeDaySTA(flights);
        spYlabel = "Time of day (Scheduled Arrival)";
    }
    if (ylabel.equals("Actual Arrival")) {
        scatterPlotYData = getTimeDayATA(flights);
        spYlabel = "Time of day (Actual Arrival)";
    }
    float[] minMaxY = getMinAndMax(scatterPlotYData);
    float[] minMaxX = getMinAndMax(scatterPlotXData);
    minXsp = minMaxX[0];
    maxXsp = minMaxX[1];
    minYsp = minMaxY[0];
    maxYsp = minMaxY[1];
    spTitle = "Scatter Plot of " +spXlabel+ " vs. "+ spYlabel;

}