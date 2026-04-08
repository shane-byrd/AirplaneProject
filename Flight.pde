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

  Flight(String line) {
    int c0 = line.indexOf(',');
    if (c0 < 0) { missingData = true; return; }
    int c1 = line.indexOf(',', c0 + 1);
    if (c1 < 0) { missingData = true; return; }
    int c2 = line.indexOf(',', c1 + 1);
    if (c2 < 0) { missingData = true; return; }
    int c3 = line.indexOf(',', c2 + 1);
    if (c3 < 0) { missingData = true; return; }
    int c4 = line.indexOf(',', c3 + 1);
    if (c4 < 0) { missingData = true; return; }
    int c5 = line.indexOf(',', c4 + 1);
    if (c5 < 0) { missingData = true; return; }
    int c6 = line.indexOf(',', c5 + 1);
    if (c6 < 0) { missingData = true; return; }
    int c7 = line.indexOf(',', c6 + 1);
    if (c7 < 0) { missingData = true; return; }
    int c8 = line.indexOf(',', c7 + 1);
    if (c8 < 0) { missingData = true; return; }
    int c9 = line.indexOf(',', c8 + 1);
    if (c9 < 0) { missingData = true; return; }
    int c10 = line.indexOf(',', c9 + 1);
    if (c10 < 0) { missingData = true; return; }
    int c11 = line.indexOf(',', c10 + 1);
    if (c11 < 0) { missingData = true; return; }
    int c12 = line.indexOf(',', c11 + 1);
    if (c12 < 0) { missingData = true; return; }
    int c13 = line.indexOf(',', c12 + 1);
    if (c13 < 0) { missingData = true; return; }
    int c14 = line.indexOf(',', c13 + 1);
    if (c14 < 0) { missingData = true; return; }
    int c15 = line.indexOf(',', c14 + 1);
    if (c15 < 0) { missingData = true; return; }
    int c16 = line.indexOf(',', c15 + 1);
    if (c16 < 0) { missingData = true; return; }
    int c17 = line.indexOf(',', c16 + 1);
    if (c17 < 0) { missingData = true; return; }
    int c18 = line.indexOf(',', c17 + 1);
    if (c18 < 0) { missingData = true; return; }

    missingData = false;

    if (hasEmptyField(line, 0, c0)) { missingData = true; return; }
    parseDate(line, 0);
    if (missingData) return;

    if (hasEmptyField(line, c0 + 1, c1)) { missingData = true; return; }
    airlineCode = line.substring(c0 + 1, c1);

    if (hasEmptyField(line, c1 + 1, c2)) { missingData = true; return; }
    flightNumber = parseIntRange(line, c1 + 1, c2);

    if (hasEmptyField(line, c2 + 1, c3)) { missingData = true; return; }
    originAirport = line.substring(c2 + 1, c3);

    if (hasEmptyField(line, c3 + 1, c4)) { missingData = true; return; }
    originCity = substringTrimLeadingQuote(line, c3 + 1, c4);

    if (hasEmptyField(line, c5 + 1, c6)) { missingData = true; return; }
    originState = line.substring(c5 + 1, c6);

    if (hasEmptyField(line, c6 + 1, c7)) { missingData = true; return; }
    originWac = parseIntRange(line, c6 + 1, c7);

    if (hasEmptyField(line, c7 + 1, c8)) { missingData = true; return; }
    destAirport = line.substring(c7 + 1, c8);

    if (hasEmptyField(line, c8 + 1, c9)) { missingData = true; return; }
    destCity = substringTrimLeadingQuote(line, c8 + 1, c9);

    if (hasEmptyField(line, c10 + 1, c11)) { missingData = true; return; }
    destState = line.substring(c10 + 1, c11);

    if (hasEmptyField(line, c11 + 1, c12)) { missingData = true; return; }
    destWac = parseIntRange(line, c11 + 1, c12);

    if (hasEmptyField(line, c12 + 1, c13)) { missingData = true; return; }
    scheduledDepTime = parseIntRange(line, c12 + 1, c13);

    if (hasEmptyField(line, c13 + 1, c14)) { missingData = true; return; }
    depTime = parseIntRange(line, c13 + 1, c14);

    if (hasEmptyField(line, c14 + 1, c15)) { missingData = true; return; }
    scheduledArrTime = parseIntRange(line, c14 + 1, c15);

    if (hasEmptyField(line, c15 + 1, c16)) { missingData = true; return; }
    arrTime = parseIntRange(line, c15 + 1, c16);

    if (hasEmptyField(line, c16 + 1, c17)) { missingData = true; return; }
    cancelled = line.charAt(c16 + 1) == '1';

    if (hasEmptyField(line, c17 + 1, c18)) { missingData = true; return; }
    diverted = line.charAt(c17 + 1) == '1';

    if (hasEmptyField(line, c18 + 1, line.length())) { missingData = true; return; }
    distance = parseIntRange(line, c18 + 1, line.length());

    valuesInStringFormat[0] = getDateRegular();
    valuesInStringFormat[1] = airlineCode;
    valuesInStringFormat[2] = String.valueOf(flightNumber);
    valuesInStringFormat[3] = originAirport;
    valuesInStringFormat[4] = originCity;
    valuesInStringFormat[5] = originState;
    valuesInStringFormat[6] = String.valueOf(originWac);
    valuesInStringFormat[7] = destAirport;
    valuesInStringFormat[8] = destCity;
    valuesInStringFormat[9] = destState;
    valuesInStringFormat[10] = String.valueOf(destWac);
    valuesInStringFormat[11] = convertTime24(scheduledDepTime);
    valuesInStringFormat[12] = convertTime24(depTime);
    valuesInStringFormat[13] = convertTime24(scheduledArrTime);
    valuesInStringFormat[14] = convertTime24(arrTime);
    valuesInStringFormat[15] = convertBoolToString(cancelled);
    valuesInStringFormat[16] = convertBoolToString(diverted);
    valuesInStringFormat[17] = String.valueOf(distance);
  }

  boolean hasEmptyField(String s, int start, int end) {
    return start >= end;
  }

  void parseDate(String s, int start) {
    if (start + 9 >= s.length()) {
      missingData = true;
      return;
    }

    flightMonth = (s.charAt(start) - '0') * 10 + (s.charAt(start + 1) - '0');
    flightDay = (s.charAt(start + 3) - '0') * 10 + (s.charAt(start + 4) - '0');
    flightYear = (s.charAt(start + 6) - '0') * 1000
      + (s.charAt(start + 7) - '0') * 100
      + (s.charAt(start + 8) - '0') * 10
      + (s.charAt(start + 9) - '0');
  }

  int parseIntRange(String s, int start, int end) {
    int value = 0;
    int i = start;
    boolean negative = false;

    if (i < end && s.charAt(i) == '-') {
      negative = true;
      i++;
    }

    for (; i < end; i++) {
      char c = s.charAt(i);
      if (c >= '0' && c <= '9') {
        value = value * 10 + (c - '0');
      }
    }

    return negative ? -value : value;
  }

  String substringTrimLeadingQuote(String s, int start, int end) {
    if (start < end && s.charAt(start) == '\"') {
      start++;
    }
    return s.substring(start, end);
  }

  String getDateAmerican() {
    return flightMonth + "/" + flightDay + "/" + flightYear;
  }

  String getDateRegular() {
    return flightDay + "/" + flightMonth + "/" + flightYear;
  }
}
