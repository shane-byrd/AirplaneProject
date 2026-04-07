// Tommy (Zhihan)
void sortFlights(String sortType) {
  Collections.sort(filteredFlights, new Comparator<Flight>() {
    public int compare(Flight a, Flight b) {

      if (sortType.equals("sortDataairlineAsc")) {
        return a.airlineCode.compareToIgnoreCase(b.airlineCode);
      }

      if (sortType.equals("sortDataairlineDesc")) {
        return b.airlineCode.compareToIgnoreCase(a.airlineCode);
      }

      if (sortType.equals("sortDatadistanceAsc")) {
        return a.distance - b.distance;
      }

      if (sortType.equals("sortDatadistanceDesc")) {
        return b.distance - a.distance;
      }

      if (sortType.equals("sortDatadepAsc")) {
        return a.depTime - b.depTime;
      }

      if (sortType.equals("sortDatadepDesc")) {
        return b.depTime - a.depTime;
      }

      if (sortType.equals("sortDataarrAsc")) {
        return a.arrTime - b.arrTime;
      }

      if (sortType.equals("sortDataarrDesc")) {
        return b.arrTime - a.arrTime;
      }

      return 0;
    }
  });
}