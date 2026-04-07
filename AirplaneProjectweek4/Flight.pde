class Flight {
  int flightYear;
  int flightMonth;
  int flightDay;

  String airlineCode;
  int flightNumber;

  String originAirport;
  String originCity;
  String originState;
  int originWac;

  String destAirport;
  String destCity;
  String destState;
  int destWac;

  int scheduledDepTime;
  int depTime;
  int scheduledArrTime;
  int arrTime;

  boolean cancelled;
  boolean diverted;

  boolean missingData;

  int distance;
  String[] valuesInStringFormat = new String[18];

  Flight(String[] row) {
    String[] flightDate = row[0].split("/");
    flightMonth = safeInt(flightDate[0]);
    flightDay =  safeInt(flightDate[1]);
    flightYear =  safeInt(flightDate[2].substring(0,4));
  /*
    flightMonth = safeInt(row[0].substring(0,2));
    flightDay = safeInt(row[0].substring(3,5));
    flightYear = safeInt(row[0].substring(6,10));
    */
    missingData = false;
    for (String col : row) {
      if (col.length() == 0) {
        missingData = true;
      }
    }
    airlineCode = row[1];
    flightNumber = safeInt(row[2]);

    originAirport = row[3];
    originCity = row[4].substring(1);
    originState = row[6];
    originWac = safeInt(row[7]);

    destAirport = row[8];
    destCity = row[9].substring(1);
    destState = row[11];
    destWac = safeInt(row[12]);

    scheduledDepTime = safeInt(row[13]);
    depTime = safeInt(row[14]);
    scheduledArrTime = safeInt(row[15]);
    arrTime = safeInt(row[16]);

    cancelled = safeInt(row[17]) == 1;
    diverted = safeInt(row[18]) == 1;

    distance = safeInt(row[19]);
  
    // to make it easier to present data have an array of strings
    valuesInStringFormat[0] = this.getDateRegular();
    valuesInStringFormat[1] =  airlineCode;
    valuesInStringFormat[2] =  String.valueOf(flightNumber);
    valuesInStringFormat[3] =  originAirport;
    valuesInStringFormat[4] =  originCity;
    valuesInStringFormat[5] =  originState;
    valuesInStringFormat[6] =  String.valueOf(originWac);
    valuesInStringFormat[7] =  destAirport;
    valuesInStringFormat[8] =  destCity;
    valuesInStringFormat[9] =  destState;
    valuesInStringFormat[10] =  String.valueOf(destWac);
    valuesInStringFormat[11] =  convertTime24(scheduledDepTime);
    valuesInStringFormat[12] =  convertTime24(depTime);
    valuesInStringFormat[13] =  convertTime24(scheduledArrTime);
    valuesInStringFormat[14] =  convertTime24(arrTime);
    valuesInStringFormat[15] =  convertBoolToString(cancelled);
    valuesInStringFormat[16] =  convertBoolToString(diverted);
    valuesInStringFormat[17] =  String.valueOf(distance);
      
  }

  String getDateAmerican() {
    return flightMonth + "/" + flightDay + "/" + flightYear;
  }
  String getDateRegular() {
    return flightDay + "/" + flightMonth + "/" + flightYear;
  }

}