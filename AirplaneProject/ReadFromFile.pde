// loads flight array from csv file, written by Shane Byrd, edited by Tommy (Zhihan)
//


ArrayList<Flight> readFromFile(String filename)
{
  ArrayList<Flight> flights = new ArrayList<Flight>(600000);
  BufferedReader reader = createReader(filename);

  if (reader == null) {
    return flights;
  }

  try {
    String line = reader.readLine();

    while ((line = reader.readLine()) != null)
    {
      if (line.length() == 0) {
        continue;
      }

      Flight f = new Flight(line);
      if (!f.missingData) {
        flights.add(f);
      }
    }

    reader.close();
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }

  return flights;
}
