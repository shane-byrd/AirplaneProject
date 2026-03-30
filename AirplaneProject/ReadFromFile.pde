
ArrayList<Flight> readFromFile(String filename) 
{
    ArrayList<Flight> flights = new ArrayList<Flight>();
    String[] lines = loadStrings(filename);
    for (int i = 1; i < lines.length; i++) 
    {
        String[] dataPoints = split(lines[i], ",");
        Flight f = new Flight(dataPoints);
        if (f.missingData == false) {
            flights.add(f);
        }
        
    }
    return flights;
}

/*
ArrayList<Flight> readFromFile(String filename) 
{
    ArrayList<Flight> flights = new ArrayList<Flight>();
    String[] lines = loadStrings(filename);
    for (int i = 1; i < lines.length; i++) 
    {
        //String[] dataPoints = split(lines[i], ",");
        int count = 1;
        for (int j = 0; j < lines[i].length(); j++) {
            if (lines[i].charAt(j) == ',') count++;
        }
        String[] dataPoints = new String[count];
        int start = 0, index = 0;
        for (int j = 0; j < lines[i].length(); j++) {
            if (lines[i].charAt(j) == ',') {
                dataPoints[index++] = lines[i].substring(start, j);
                start = j + 1;
            }
        }
        dataPoints[index] = lines[i].substring(start);

        Flight f = new Flight(dataPoints);
        if (f.missingData == false) {
            flights.add(f);
        }
        
    }
    return flights;
}
*/