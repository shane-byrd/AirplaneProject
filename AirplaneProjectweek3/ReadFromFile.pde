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