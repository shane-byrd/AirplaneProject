// functions for converting data into representable format, written by Shane Byrd
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

// convert minutes into string in HH:MM format
String mintoHHMMConvert(int timeInt) {
    int copyMinute = timeInt;
    int hour=0;
    while (copyMinute>= 60) {
        copyMinute -=60;
        hour++;
    }

    return (hour+":"+copyMinute);
    
}

// convert minutes to string in HH:MM format
String minToHoursandMin(int timeInt) {
    int copyMinute = abs(timeInt);
    int hour=0;
    while (copyMinute>= 60) {
        copyMinute -=60;
        hour++;
    }
    String returnString = "";
    if (timeInt < 0) {
        returnString =  "-"+hour+":"+copyMinute;
    }
    else {
        returnString = hour+":"+copyMinute;
    }
    if (copyMinute == 0) {
        returnString+= "0";
    }
    else if (copyMinute < 10) {
        returnString = returnString.substring(0,returnString.length()-1) + "0" + returnString.substring(returnString.length()-1,returnString.length());
    }
    return returnString;
    

}

// convert HH:MM String to minutes
int convertHHMMtoMin(String hhmmString) {
    // check if correct
    int convertInt = safeInt(hhmmString);
    return hhmmToMinConvert(convertInt);
}

//convert day and month to number of days through the year
int convertIntDatetoDays(int days, int months) {
    int dayNum = 0;
    for (int i = 1; i < (months - 1); i++) {
        dayNum += daysInMonth[i];
    }
    dayNum += days;
    return dayNum;
}

// get the departure delay for a flight
int getDepartureDelay(Flight f) {
    int depTime  = hhmmToMinConvert(f.depTime);
    int scheduledDepTime  = hhmmToMinConvert(f.scheduledDepTime);
    int delayTime;
    if (abs((depTime - scheduledDepTime)) < abs((depTime + 24*60) - scheduledDepTime) ) {
        delayTime = depTime - scheduledDepTime;
    }
    else {
        delayTime = (depTime + 24*60) - scheduledDepTime;
    }
    return delayTime;
}

// get arrival delay for a flight
int getArrivalDelay(Flight f) {
    int arrTime  = hhmmToMinConvert(f.arrTime);
    int scheduledArrTime  = hhmmToMinConvert(f.scheduledArrTime);
    int delayTime = arrTime - scheduledArrTime;
    if (delayTime < -720) {
        delayTime += 1440;
    }
    return delayTime;
}