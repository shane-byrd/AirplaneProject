// functions for extracting arrayList of data from flight arraylist, 
// written by Shane Byrd

// functions to get arraylist of values from the an arraylist of flights, used for scatterplots
ArrayList<Float> getDistance(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float)f.distance);
    }
    return r;
}

ArrayList<Float> getDepartureDelay(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        int depTime  = hhmmToMinConvert(f.depTime);
        int scheduledDepTime  = hhmmToMinConvert(f.scheduledDepTime);
        int delayTime;
        if (abs((depTime - scheduledDepTime)) < abs((depTime + 24*60) - scheduledDepTime) ) {
            delayTime = depTime - scheduledDepTime;
        }
        else {
            delayTime = (depTime + 24*60) - scheduledDepTime;
        }
        if (delayTime > 1300) {
            delayTime -= 24 *60;
        }
        r.add((float)delayTime);
    }
    return r;
}

ArrayList<Float> getArrivalDelay(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        int arrTime  = hhmmToMinConvert(f.arrTime);
        int scheduledArrTime  = hhmmToMinConvert(f.scheduledArrTime);
        int delayTime;
        if (abs((arrTime - scheduledArrTime)) < abs((arrTime + 24*60) - scheduledArrTime) ) {
            delayTime = arrTime - scheduledArrTime;
        }
        else {
            delayTime = (arrTime + 24*60) - scheduledArrTime;
        }
        if (delayTime > 1300) {
            delayTime -= 24 *60;
        }
        r.add((float)delayTime);
    }
    return r;
}

ArrayList<Float> getDuration(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        int arrTime = hhmmToMinConvert(f.arrTime);
        int depTime = hhmmToMinConvert(f.depTime);
        if (arrTime < depTime) {
            if (abs(arrTime -depTime) < 60 ) {
                arrTime += 60;
            }
            else {
                arrTime += (24*60);
            }
            
        }
        r.add((float)arrTime - depTime);

    }
    return r;
}

ArrayList<Float> getTimeYear(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        Float dayNum = 0.0;
        for (int i = 1; i < (f.flightMonth - 1); i++) {
            dayNum += (float)daysInMonth[i];
        }
        dayNum += (float)f.flightDay;
        r.add((float)dayNum);
    }
    return r;
}



ArrayList<Float> getTimeDaySTD(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float) hhmmToMinConvert(f.scheduledDepTime));
    }
    return r;
}

ArrayList<Float> getTimeDayATD(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float)hhmmToMinConvert(f.depTime));
    }
    return r;
}

ArrayList<Float> getTimeDaySTA(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float) hhmmToMinConvert(f.scheduledArrTime));
    }
    return r;
}

ArrayList<Float> getTimeDayATA(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float) hhmmToMinConvert(f.arrTime));
    }
    return r;
}

// find minimum and maximum of an arraylist of floats
float[] getMinAndMax(ArrayList<Float> floatArray) {
    boolean firstMin = true;
    boolean firstMax = true;
    float[] r = {floatArray.get(0), floatArray.get(0)};
    for (float f : floatArray) {
        if (f < r[0]) {
            r[0] = f;
        }
        if (f > r[1]) {
            r[1] = f;
        }
    }
    return r;
}


// get hashmap data from category and data string
Map<String, Float> getHashData(String category, String data, ArrayList<Flight> flights) {
    Map<String, Float> returnMap = new HashMap<>();
    Map<String, Float> freqMap = new HashMap<>();
    for (Flight f : flights) {
        String vs = getStringData(f,category);
        freqMap.put(vs, freqMap.getOrDefault(vs, 0.0f) + 1.0f);
        returnMap.put(vs, getFloatData(f,data,returnMap.getOrDefault(vs,1.0f),freqMap.get(vs)));
    }
    return returnMap;
}

// get the string data based on the category from a single flight
String getStringData(Flight f, String category) {
    if (category.equals("Airport (Destination)")) {
        return f.destAirport;
    }
    if (category.equals("Airline")) {
        return f.airlineCode;
    }
    if (category.equals("City (Destination)")) {
        return f.destCity;
    }
    if (category.equals("State (Destination)")) {
        return f.destState;
    }

    if (category.equals("Airport (Departure)")) {
        return f.originAirport;
    }
    if (category.equals("City (Departure)")) {
        return f.originCity;
    }
    if (category.equals("State (Departure)")) {
        return f.originState;
    }

    return null;
}

// get the float data from a single flight based on the category and the current value
Float getFloatData(Flight f, String data, Float currentVal, Float freqVal) {
    if (data.equals("Mean Distance")) {
        // calculate average
        Float newMean = ( (currentVal * freqVal) + f.distance ) / (freqVal + 1);
        return newMean;
    }
    if (data.equals("Mean delay time")) {
        //calculate average
        Float newMean = ( (currentVal * freqVal) + getSingleDepartureDelay(f) ) / (freqVal + 1);
        return newMean;
    }
    if (data.equals("Mean flight duration")) {
        // calculate average
        Float newMean = ( (currentVal * freqVal) + getSingleDuration(f) ) / (freqVal + 1);
        return newMean;
    }
    if (data.equals("% Diverted")) {
        //calculate new proportion
        Float curval;
        if (f.diverted) curval = 100.0;
        else curval = 0.0;
        Float newMean = ( (currentVal * freqVal) + curval ) / (freqVal + 1);
        return newMean;
        
    }
    if (data.equals("% Cancelled")) {
        //calculate new proportion
        Float curval;
        if (f.cancelled) curval = 100.0;
        else curval = 0.0;
        Float newMean = ( (currentVal * freqVal) + curval ) / (freqVal + 1);
        return newMean;
    }
    if (data.equals("Frequency")) {
       return freqVal; 
    }
    return 0.0;
}

// get departure and arrival delay for a single flight
Float getSingleDepartureDelay(Flight f) {
    int depTime  = hhmmToMinConvert(f.depTime);
    int scheduledDepTime  = hhmmToMinConvert(f.scheduledDepTime);
    int delayTime;
    if (abs((depTime - scheduledDepTime)) < abs((depTime + 24*60) - scheduledDepTime) ) {
        delayTime = depTime - scheduledDepTime;
    }
    else {
        delayTime = (depTime + 24*60) - scheduledDepTime;
    }
    return (float)delayTime;
}

Float getSingleArrivalDelay(Flight f) {
    int arrTime  = hhmmToMinConvert(f.arrTime);
    int scheduledArrTime  = hhmmToMinConvert(f.scheduledArrTime);
    int delayTime;
    if (abs((arrTime - scheduledArrTime)) < abs((arrTime + 24*60) - scheduledArrTime) ) {
        delayTime = arrTime - scheduledArrTime;
    }
    else {
        delayTime = (arrTime + 24*60) - scheduledArrTime;
    }
    return (float) delayTime;
}

Float getSingleDuration(Flight f) {
    int arrTime = hhmmToMinConvert(f.arrTime);
    int depTime = hhmmToMinConvert(f.depTime);
    if (arrTime < depTime) {
        arrTime += (24*60);
    }
    return (float) (arrTime - depTime);
}

// get the min and max value of the bar chart category map
float[] getMinMaxBCVal() {
    Map.Entry<String, Float> re = categoryMap.entrySet().iterator().next();
    float minval = re.getValue();
    float maxval = re.getValue();
    for (Map.Entry<String, Float> entry : categoryMap.entrySet()) {
        float val = entry.getValue();
        if (val < minval) {
            minval = val;
        }
        if (val > maxval) {
            maxval = val;
        }
    }
    float[] returnFl = {minval,maxval};
    return returnFl;
}

// get the nin and max of the bar chart data
float[] getMinMaxShowData() {
    float[] returnFL = {0.0,0.0};
    if (ascendingBC) {
        returnFL[0] = showBCdata.get(0).getValue();
        returnFL[1] = showBCdata.get(showBCdata.size() - 1).getValue();
        if (returnFL[0]==returnFL[1] && returnFL[0]> 0.0) {
            returnFL[0]=0.0;
        }
    }
    else {
        returnFL[0] = showBCdata.get(showBCdata.size() - 1).getValue();
        returnFL[1] = showBCdata.get(0).getValue();
    }
    return returnFL;
}