int convertDDMMYYYYtoint(String formatString) {
    //check if correct
    String[] dateArray = formatString.split("/");
    if (dateArray.length != 3) {
        currentError.titleText = "Error: invalid date";
        currentError.textLabel = "";
        errorMessageActive = true;
        return 1;
    }
    int days = safeInt(dateArray[0]);
    int months = safeInt(dateArray[1]);
    int years = safeInt(dateArray[2]);
    int[] daysYearArray = {0,0};
    int daysAmount = convertIntDatetoDays(days, months);
    daysAmount += (years-1913) * 365;
    //daysYearArray[0] = convertIntDatetoDays(days, months);
    //daysYearArray[1] = years;
    return daysAmount;
}

int getYearInt(Flight f ) {
    int daysAmount = 0;
    int day = f.flightDay;
    int month = f.flightMonth;
    int year = f.flightYear;
    daysAmount = convertIntDatetoDays(day, month);
    daysAmount += (year-1913) * 365;
    return daysAmount;
}

ArrayList<Float> getTimeDate(ArrayList<Flight> flights) {
    ArrayList<Float> r = new ArrayList<Float>();
    for (Flight f : flights) {
        r.add((float)getYearInt(f));
    }
    return r;
}


String convertDateIntToDDMMYYYY(int dateInt) {
    int copyDateInt = dateInt;
    // copy
    int year = (copyDateInt % 365) + 1913;
    int month = 0;
    copyDateInt %= 365;
    int i = 0;
    while (copyDateInt > daysInMonth[i]) {
        copyDateInt -= daysInMonth[i];
        month++;
        i++;
    }
    int day = copyDateInt;
    return (day+"/"+month+"/"+year);
    
}

String mintoHHMMConvert(int timeInt) {
    int copyMinute = timeInt;
    int hour=0;
    while (copyMinute>= 60) {
        copyMinute -=60;
        hour++;
    }

    return (hour+":"+copyMinute);
    
}

int convertHHMMtoMin(String hhmmString) {
    // check if correct
    int convertInt = safeInt(hhmmString);
    return hhmmToMinConvert(convertInt);
}

int convertIntDatetoDays(int days, int months) {
    int dayNum = 0;
    for (int i = 1; i < (months - 1); i++) {
        dayNum += daysInMonth[i];
    }
    dayNum += days;
    return dayNum;
}

int getDepartureDelay(Flight f) {
    int depTime  = hhmmToMinConvert(f.depTime);
    int scheduledDepTime  = hhmmToMinConvert(f.scheduledDepTime);
    int delayTime;
    if (abs((depTime - scheduledDepTime)) < abs((depTime + 26*60) - scheduledDepTime) ) {
        delayTime = depTime - scheduledDepTime;
    }
    else {
        delayTime = (depTime + 26*60) - scheduledDepTime;
    }
    return delayTime;
}

int getArrivalDelay(Flight f) {
    int arrTime  = hhmmToMinConvert(f.arrTime);
    int scheduledArrTime  = hhmmToMinConvert(f.scheduledArrTime);
    int delayTime;
    if (abs((arrTime - scheduledArrTime)) < abs((arrTime + 26*60) - scheduledArrTime) ) {
        delayTime = arrTime - scheduledArrTime;
    }
    else {
        delayTime = (arrTime + 26*60) - scheduledArrTime;
    }
    return delayTime;
}