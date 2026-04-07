// Week 10 flight filtering helpers
// Add this file to the same Processing sketch folder as your other .pde files.
// Required global variables in AirplaneProject.pde:
//   ArrayList<Flight> flights;
//   ArrayList<Flight> filteredFlights;
// In setup(), after reading flights, initialise with:
//   filteredFlights = new ArrayList<Flight>(flights);

void resetFilteredFlights() {
    filteredFlights = new ArrayList<Flight>(flights);
}

void clearFilteredFlights() {
    filteredFlights = new ArrayList<Flight>();
}

// ============================================================
// Public filter functions required for Week 10
// These work on the CURRENT filteredFlights list so filters can be chained.
// If you want to start from all flights again, call resetFilteredFlights() first.
// ============================================================

void ExactValue(String attribute, String value) {
    String[] values = { value };
    ExactValue(attribute, values);
}

void ExactValue(String attribute, String[] values) {
    ArrayList<Flight> source = getWorkingFlightList();
    ArrayList<Flight> result = new ArrayList<Flight>();

    for (Flight f : source) {
        if (matchesAnyExactValue(f, attribute, values)) {
            result.add(f);
        }
    }

    filteredFlights = result;
}

void ExactValue(String attribute, int value) {
    int[] values = { value };
    ExactValue(attribute, values);
}

void ExactValue(String attribute, int[] values) {
    ArrayList<Flight> source = getWorkingFlightList();
    ArrayList<Flight> result = new ArrayList<Flight>();

    for (Flight f : source) {
        if (matchesAnyExactNumericValue(f, attribute, values)) {
            result.add(f);
        }
    }

    filteredFlights = result;
}

void BetweenRange(String attribute, int minValue, int maxValue) {
    ArrayList<Flight> source = getWorkingFlightList();
    ArrayList<Flight> result = new ArrayList<Flight>();

    for (Flight f : source) {
        int value = getNumericAttributeDifferent(f, attribute);
        if (value >= minValue && value <= maxValue) {
            result.add(f);
        }
    }

    filteredFlights = result;
}

void BelowValue(String attribute, int maxValue) {
    ArrayList<Flight> source = getWorkingFlightList();
    ArrayList<Flight> result = new ArrayList<Flight>();
    for (Flight f : source) {
        int value = getNumericAttributeDifferent(f, attribute);
        if (value <= maxValue) {
            result.add(f);
        }
    }

    filteredFlights = result;
}

void AboveValue(String attribute, int minValue) {
    
    ArrayList<Flight> source = getWorkingFlightList();
    ArrayList<Flight> result = new ArrayList<Flight>();
    
    for (Flight f : source) {
        int value = getNumericAttributeDifferent(f, attribute);
        if (value >= minValue) {
            result.add(f);
        }
    }

    filteredFlights = result;
}

// Optional helper if you want a single-function dispatcher.
void ConstrainFlightData(String attribute, String value) {
    ExactValue(attribute, value);
}

void ConstrainFlightData(String attribute, int value) {
    ExactValue(attribute, value);
}

// ============================================================
// Internal helpers
// ============================================================

ArrayList<Flight> getWorkingFlightList() {
    if (filteredFlights == null) {
        return flights;
    }
    return filteredFlights;
}

boolean matchesAnyExactValue(Flight f, String attribute, String[] values) {
    String attributeValue = getStringAttribute(f, attribute);
    

    for (String candidate : values) {
        if (attribute.equals("Date")) {
            if (datesMatch(attributeValue, candidate)) {
                return true;
            }
        }
        else if (attribute.equals("Cancelled") || attribute.equals("Diverted")) {
            if (normaliseBooleanString(attributeValue).equals(normaliseBooleanString(candidate))) {
                return true;
            }
        }
        else if (attribute.equals("Months")) {
            if (int(attributeValue) == (int) monthMap.get(candidate)) {
                return true;
            }
        }
        else {
            if (attributeValue.equalsIgnoreCase(candidate)) {
                return true;
            }
        }
    }
    return false;
}

boolean matchesAnyExactNumericValue(Flight f, String attribute, int[] values) {
    int attributeValue = getNumericAttributeDifferent(f, attribute);
    for (int candidate : values) {
        if (attributeValue == candidate) {
            return true;
        }
    }
    return false;
}

String getStringAttribute(Flight f, String attribute) {
    switch(attribute) {
        case "Date":
            return f.getDateRegular();
        case "Airline":
            return f.airlineCode;
        case "Flight Number":
            return String.valueOf(f.flightNumber);
        case "Dep. Airport":
            return f.originAirport;
        case "Dep. City":
            return f.originCity;
        case "Dep. State":
            return f.originState;
        case "Dep. WAC":
            return String.valueOf(f.originWac);
        case "Dest. Airport":
            return f.destAirport;
        case "Dest. City":
            return f.destCity;
        case "Dest. State":
            return f.destState;
        case "Dest. WAC":
            return String.valueOf(f.destWac);
        case "STD":
            return String.valueOf(f.scheduledDepTime);
        case "ATD":
            return String.valueOf(f.depTime);
        case "STA":
            return String.valueOf(f.scheduledArrTime);
        case "ATA":
            return String.valueOf(f.arrTime);
        case "Cancelled":
            return convertBoolToString(f.cancelled);
        case "Diverted":
            return convertBoolToString(f.diverted);
        case "Distance":
            return String.valueOf(f.distance);
        case "Months":
            return String.valueOf(f.flightMonth);
        default:
            println("Unknown string attribute: " + attribute);
            return "";
    }
}
// date, distance, delay departure, delay destination, time of day departure, time of day destination
int getNumericAttributeDifferent(Flight f, String attribute) {
    switch(attribute) {
        case "Date":
            return getYearInt(f);
        case "Flight Number":
            return f.flightNumber;
        case "Time of day: Departure":
            return hhmmToMinConvert(f.depTime);
        case "Time of day: Destination":
            return hhmmToMinConvert(f.arrTime);
        case "Delay: Departure":
        return getDepartureDelay(f);
        case "Delay: Destination":
            return getArrivalDelay(f);
        case "Distance":
            return f.distance;
        default:
            println("Unknown numeric attribute: " + attribute);
            return Integer.MIN_VALUE;
    }
}
/*
int getNumericAttribute(Flight f, String attribute) {
    switch(attribute) {
        case "Date":
            return getComparableDateValue(f);
        case "Flight Number":
            return f.flightNumber;
        case "Dep. WAC":
            return f.originWac;
        case "Dest. WAC":
            return f.destWac;
        case "STD":
            return f.scheduledDepTime;
        case "ATD":
            return f.depTime;
        case "STA":
            return f.scheduledArrTime;
        case "ATA":
            return f.arrTime;
        case "Cancelled":
            return f.cancelled ? 1 : 0;
        case "Diverted":
            return f.diverted ? 1 : 0;
        case "Distance":
            return f.distance;
        default:
            println("Unknown numeric attribute: " + attribute);
            return Integer.MIN_VALUE;
    }
}
*/
int getComparableDateValue(Flight f) {
    return f.flightYear * 10000 + f.flightMonth * 100 + f.flightDay;
}

boolean datesMatch(String existingDate, String inputDate) {
    return normaliseDateString(existingDate).equals(normaliseDateString(inputDate));
}

String normaliseDateString(String rawDate) {
    if (rawDate == null) {
        return "";
    }

    String cleaned = trim(rawDate);
    cleaned = cleaned.replace('-', '/');

    String[] parts = split(cleaned, '/');
    if (parts == null || parts.length != 3) {
        return cleaned;
    }

    int a = safeInt(parts[0]);
    int b = safeInt(parts[1]);
    int c = safeInt(parts[2]);

    // Support dd/mm/yyyy or mm/dd/yyyy input.
    if (c > 999) {
        if (a > 12) {
            return nf(a, 2) + "/" + nf(b, 2) + "/" + nf(c, 4);
        }
        else if (b > 12) {
            return nf(b, 2) + "/" + nf(a, 2) + "/" + nf(c, 4);
        }
        else {
            // Default to the format already used in your table and Flight.getDateRegular()
            return nf(a, 2) + "/" + nf(b, 2) + "/" + nf(c, 4);
        }
    }

    return cleaned;
}

String normaliseBooleanString(String value) {
    if (value == null) {
        return "false";
    }

    String cleaned = trim(value).toLowerCase();
    if (cleaned.equals("1") || cleaned.equals("true") || cleaned.equals("yes")) {
        return "true";
    }
    if (cleaned.equals("0") || cleaned.equals("false") || cleaned.equals("no")) {
        return "false";
    }
    return cleaned;
}
