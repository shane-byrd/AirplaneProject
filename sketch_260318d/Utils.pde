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
