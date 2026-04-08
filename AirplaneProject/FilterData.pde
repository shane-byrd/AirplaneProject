// functions for applying filter to data, for choosing which of Mingqi's functions to call, written by Shane Byrd
//
boolean filterDataNonNumerical(String category, String value) {
    // for non numerical data
    if (category.equals("") || value.equals("")) {
        currentError.titleText = "Error: empty values";
        currentError.textLabel = "You must enter values";
        errorMessageActive = true;
        return false;
    }
    
    boolean truthValue = false;
    String exactCategory = "";
    String exactValue = value;
    if (category.equals(value)) {
    // if month / cancelled / diverted
        
        if (monthSet.contains(category)) {
            exactCategory = "Months";
            exactValue = value;
        }
        else if (category.length() > 8 && category.substring(0,9).equals("Cancelled")) {
            exactCategory = "Cancelled";
            if (category.substring(category.length()-4,category.length()).equals("True")) {
                exactValue = "true";
            }
            else {
                exactValue = "false";
            }

        }
        else if (category.length() > 7 && category.substring(0,8).equals("Diverted")) {
        exactCategory = "Diverted";
            if (category.substring(category.length()-4,category.length()).equals("True")) {
                exactValue = "true";
            }
            else {
                exactValue = "false";
            }
        }
    }
    else {
        if (category.equals("Airline")) {
            exactCategory = "Airline";

        }
        if (category.equals("Airport: Destination")) {
            exactCategory = "Dep. Airport";
        }
        if (category.equals("Airport: Departure")) {
            exactCategory = "Dest. Airport";
        }
        if (category.equals("State: Destination")) {
            exactCategory = "Dest. State";
        }
        if (category.equals("State: Departure")) {
            exactCategory = "Dep. State";
        }
        if (category.equals("City: Destination")) {
            exactCategory = "Dest. City";
        }
        if (category.equals("City: Departure")) {
            exactCategory = "Dep. City";
        }
    }
    ExactValue(exactCategory, exactValue);
    filtersApplied = true;
    updateFilterLabel();
    tableScreen.table.updateDataSize(filteredFlights);
    updateVerticalLimit();
    updatePagination();
    return true;
    
}

boolean filterDataNumerical(String category, String type, String value) {
    // for single value numerical data
    if (category.equals("") || value.equals("")) {
        currentError.titleText = "Error: empty values";
        currentError.textLabel = "You must enter values";
        errorMessageActive = true;
        return false;
    }
    if (!category.equals("Date")) {
        if (!isInteger(value)) {
            currentError.titleText = "Error: input must be a number";
            currentError.textLabel = "";
            errorMessageActive = true;
            return false;
        }
    }
    int exactInt;
    int[] exactIntArray;
    boolean isArray = false;
    if (category.equals("Distance")) {
        exactInt = safeInt(value);
    }
    else if (category.equals("Date")) {
        exactInt = convertDDMMYYYYtoint(value);
    }
    else if (category.equals("Time of day: Departure")) {
        exactInt = convertHHMMtoMin(value);
    }
    else if (category.equals("Time of day: Destination")) {
        exactInt = convertHHMMtoMin(value);
    }
    else if (category.equals("Delay: Departure")) {
        exactInt = safeInt(value);
    }
    else if (category.equals("Delay: Destination")) {
        exactInt = safeInt(value);
    }
    else {
        return false;
    }

    if (type.equals("Greater Than")) {
        // apply filter and update label and table
        AboveValue(category, exactInt);
        filtersApplied = true;
        updateFilterLabel();
        tableScreen.table.updateDataSize(filteredFlights);
        updateVerticalLimit();
        updatePagination();

    }
    else if (type.equals("Less Than")) {
        // apply filter and update label and table
        BelowValue(category, exactInt);
        filtersApplied = true;
        updateFilterLabel();
        tableScreen.table.updateDataSize(filteredFlights);
        updateVerticalLimit();
        updatePagination();

    }
    else if (type.equals("Single Value")) {
        // apply filter and update label and table
        ExactValue(category, exactInt);
        filtersApplied = true;
        updateFilterLabel();
        tableScreen.table.updateDataSize(filteredFlights);
        updateVerticalLimit();
        updatePagination();
    }
    else {
        return false;
    }
    return true;
}

boolean filterDataNumerical(String category, String type, String valueOne, String valueTwo) {
    // for range numerical data
    int exactIntOne = 0;
    int exactIntTwo = 0;
    if (!category.equals("Date")) {
        if (!isInteger(valueOne) || !isInteger(valueTwo)) {
            currentError.titleText = "Error: input must be a number";
            currentError.textLabel = "";
            errorMessageActive = true;
            return false;
        }
    }
    if (category.equals("") || valueOne.equals("") || valueTwo.equals("")) {
        currentError.titleText = "Error: empty values";
        currentError.textLabel = "You must enter values";
        errorMessageActive = true;
        return false;
    }
    if (category.equals("Distance")) {
        exactIntOne = safeInt(valueOne);
        exactIntTwo = safeInt(valueTwo);
    }
    else if (category.equals("Date")) {
        exactIntOne = convertDDMMYYYYtoint(valueOne);
        exactIntTwo = convertDDMMYYYYtoint(valueTwo);
    }
    else if (category.equals("Time of day: Departure")) {
        exactIntOne = convertHHMMtoMin(valueOne);
        exactIntTwo = convertHHMMtoMin(valueTwo);
    }
    else if (category.equals("Time of day: Destination")) {
        exactIntOne = convertHHMMtoMin(valueOne);
        exactIntTwo = convertHHMMtoMin(valueTwo);
    }
    else if (category.equals("Delay: Departure")) {
        exactIntOne = safeInt(valueOne);
        exactIntTwo = safeInt(valueTwo);
    }
    else if (category.equals("Delay: Destination")) {
        exactIntOne = safeInt(valueOne);
        exactIntTwo = safeInt(valueTwo);
    }
    else {
        return false;
    }

    // call Mingqi's function
    BetweenRange(category,exactIntOne,exactIntTwo);
    filtersApplied = true;

    // update table and filter label
    updateFilterLabel();
    tableScreen.table.updateDataSize(filteredFlights);
    updateVerticalLimit();
    updatePagination();
    return true;
}

