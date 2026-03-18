// Tommy (Zhihan)
void sortFlights(String sortType) {
  Collections.sort(flights, new Comparator<Flight>() {
    public int compare(Flight a, Flight b) {

      if (sortType.equals("airlineAsc")) {
        return a.airlineCode.compareToIgnoreCase(b.airlineCode);
      }

      if (sortType.equals("airlineDesc")) {
        return b.airlineCode.compareToIgnoreCase(a.airlineCode);
      }

      if (sortType.equals("distanceAsc")) {
        return a.distance - b.distance;
      }

      if (sortType.equals("distanceDesc")) {
        return b.distance - a.distance;
      }

      if (sortType.equals("depAsc")) {
        return a.depTime - b.depTime;
      }

      if (sortType.equals("depDesc")) {
        return b.depTime - a.depTime;
      }

      if (sortType.equals("arrAsc")) {
        return a.arrTime - b.arrTime;
      }

      if (sortType.equals("arrDesc")) {
        return b.arrTime - a.arrTime;
      }

      return 0;
    }
  });
}