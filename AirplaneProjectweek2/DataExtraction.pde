
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
        if (abs((depTime - scheduledDepTime)) < abs((depTime + 26*60) - scheduledDepTime) ) {
            delayTime = depTime - scheduledDepTime;
        }
        else {
            delayTime = (depTime + 26*60) - scheduledDepTime;
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
        if (abs((arrTime - scheduledArrTime)) < abs((arrTime + 26*60) - scheduledArrTime) ) {
            delayTime = arrTime - scheduledArrTime;
        }
        else {
            delayTime = (arrTime + 26*60) - scheduledArrTime;
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
            arrTime += (24*60);
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