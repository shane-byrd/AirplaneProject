int safeInt(String s) {
    if (s == null || s.equals("")) {
        return 0;
    }
    return int(s);
}

String convertTime24(int inputTime) {
    int hour = inputTime / 100;
    int minutes = inputTime - ( hour * 100 );
    if (minutes < 9) {
        return String.valueOf(hour) + ":" + String.valueOf(minutes) + "0";
    }
    else {
        return String.valueOf(hour) + ":" + String.valueOf(minutes);
    }
}

String convertBoolToString(boolean value) {
    if (value) {
        return "True";
    }
    else {
        return "False";
    }

}

HashMap StringToIntegerMap(String[] keys, Integer[] values) {
    int keysSize = keys.length;
    int valuesSize = values.length;
    if (keysSize != valuesSize) {
        println("error: string array does not match integer array in size");
        return new HashMap();
        
    }
    if (keysSize == 0 ) {
        return new HashMap();
    }
    HashMap<String, Integer> m = new HashMap<String, Integer>();
    for (int i = 0; i < keysSize; i ++) {
        m.put(keys[i], values[i]);
    }
    return m;
}

void clampScroll() {
        if (XOFFSET > MAXXOFFSET ) {
                XOFFSET = MAXXOFFSET;
        }
        if (XOFFSET < MINXOFFSET) {
                XOFFSET = MINXOFFSET;
        }
        if (YOFFSET >MAXYOFFSET ) {
                YOFFSET = MAXYOFFSET;
        }
        if (YOFFSET < MINYOFFSET) {
                YOFFSET = MINYOFFSET;
        }
}

/*
if (c == 0) { // date
        outputText = flights.get(r-1).getDateRegular();
}
else if (c == 1) { // airline
        outputText = flights.get(r-1).airlineCode;
}
else if (c == 2) { // flight number
        outputText = String.valueOf(flights.get(r-1).flightNumber);
}
else if (c == 3) { // origin airport
        outputText = flights.get(r-1).originAirport;
}
else if (c == 4) { // Origin City
        outputText = flights.get(r-1).originCity;
}
else if (c == 5) { // Origin State
        outputText = flights.get(r-1).originState;
}
else if (c == 6) { // Origin WAC
        outputText = String.valueOf(flights.get(r-1).originWac);
}

else if (c == 7) { // destination airport
        outputText = flights.get(r-1).destAirport;
}
else if (c == 8) { // Destination City
        outputText = flights.get(r-1).destCity;
}
else if (c == 9) { // Origin State
        outputText = flights.get(r-1).destState;
}
else if (c == 10) { // Origin WAC
        outputText = String.valueOf(flights.get(r-1).destWac);
}
else if (c == 11) { // scheduled departutre time
        outputText = convertTime24(flights.get(r-1).scheduledDepTime);
}
else if (c == 12) { // actual departutre time
        outputText = convertTime24(flights.get(r-1).depTime);
}
else if (c == 13) { // scheduled arrival time
        outputText = convertTime24(flights.get(r-1).scheduledArrTime);
}
else if (c == 14) { // actual arrival time
        outputText = convertTime24(flights.get(r-1).arrTime);
}
else if (c == 15) { // Cancelled
        outputText = convertBoolToString(flights.get(r-1).cancelled);
}
else if (c == 16) { // Diverted
        outputText = convertBoolToString(flights.get(r-1).diverted);
}
else if (c == 17) {
        outputText = String.valueOf(flights.get(r-1).distance);
}
else {
        outputText = "n";
}
*/

float bestDivider(float low, float high) {
    float div = (high-low) / 10.0;
    float rounded = (float) Math.pow(10, Math.round(Math.log10(div)));
    float bestRounded = rounded;
    for (int i = 1; i < 10; i ++) {
        float testRounded = rounded * i;
        float divisions = (high-low) / testRounded;

        if (Math.abs(10 - divisions) < Math.abs(10 - ((high-low) / bestRounded)) ){
            bestRounded = testRounded;
        }
    }
    return bestRounded;

}

float bestBinWidth(float low, float high, float binAmount) {
    float div = (high-low) / binAmount;
    float rounded = (float) Math.pow(10, Math.round(Math.log10(div)));
    float bestRounded = rounded;
    for (int i = 1; i < 10; i ++) {
        float testRounded = rounded * i;
        float divisions = (high-low) / testRounded;

        if (Math.abs(10 - divisions) < Math.abs(10 - ((high-low) / bestRounded)) ){
            bestRounded = testRounded;
        }
    }
    return bestRounded;

}



void closeAll(InteriorDropDown idd) {
    idd.openW = false;
    for (InteriorDropDown iddn : idd.sIDD) {
        closeAll(iddn);
    }
}


int hhmmToMinConvert(int hhmm) {
    int hour = hhmm / 100;
    int minutes = hhmm - ( hour * 100 );
    int onlyMinutes = (hour * 60) + minutes;
    return onlyMinutes;
}

String[] handleDropDownArray(DropDown dd) {
    String[] returnLabel = {"None","None"};
    if (dd.openW == true) {
        for (Button b : dd.selectionButtons) {
            if (b.cursorOverWidget()) {
                returnLabel[0] = b.idLabel;
                returnLabel[1] = b.textLabel;
                for (InteriorDropDown idd : dd.sIDD) {
                    closeAll(idd);
                }
            }
        }
        for (InteriorDropDown idd : dd.sIDD) {
            String[] newString = handleInteriorDropDownArray(idd);
            if (!newString[0].equals("None")) {
                returnLabel = newString.clone();
            }
        }
        if (returnLabel[0].equals( "None" ) && dd.overBackGround() == false) {
            dd.openW = false;
            for (InteriorDropDown idd : dd.sIDD) {
                closeAll(idd);
            }
        }
        return returnLabel;
    }
    else {
        if (dd.cursorOverWidget() == true) {
            dd.openW = true;
        }
    }
    returnLabel[0] = "Opened";
    returnLabel[1] = "Opened";
    return returnLabel;

}

String[] handleInteriorDropDownArray(InteriorDropDown idd) {
    String[] returnLabel = {"None","None"};
    if (idd.openW == true) {  
        for (Button b : idd.selectionButtons) {
            if (b.cursorOverWidget()) {
                returnLabel[0] = b.idLabel;
                returnLabel[1] = b.textLabel;
                for (InteriorDropDown iddn : idd.sIDD) {
                    closeAll(iddn);
                }
            }
        }
        for (InteriorDropDown iddn : idd.sIDD) {
            String[] newString = handleInteriorDropDownArray(iddn);
            if (!newString[0].equals("None")) {
                returnLabel = newString.clone();
            }
        }
        if (returnLabel[0].equals("None") && idd.overBackGround() == false) {
            idd.openW = false;
        }
        return returnLabel;
    }
    else {
        if (idd.cursorOverWidget() == true) {
            idd.openW = true;
            returnLabel[0] = "Opened";
            returnLabel[1] = "Opened";
            return returnLabel;
        }
    }
    return returnLabel;
}

boolean isInteger(String str) {
    if (str == null || str.isEmpty()) return false;
    try {
        Integer.parseInt(str);
        return true;
    } catch (NumberFormatException e) {
        return false;
    }
}