// Xubo
class BarGraph {
  float x;
  float y;
  float w;
  float h;

  ArrayList<Flight> flights;
  PFont titleFont;
  PFont labelFont;

  String[] airportLabels;
  int[] airportCounts;
  int barCount;

  BarGraph(float x, float y, float w, float h, ArrayList<Flight> flights, PFont titleFont, PFont labelFont) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.titleFont = titleFont;
    this.labelFont = labelFont;
    updateData(flights);
  }

  void updateData(ArrayList<Flight> flights) {
    this.flights = flights;

    HashMap<String, Integer> airportMap = new HashMap<String, Integer>();

    for (int i = 0; i < flights.size(); i++) {
      Flight f = flights.get(i);

      if (f.originAirport != null && !f.originAirport.equals("")) {
        if (airportMap.containsKey(f.originAirport)) {
          airportMap.put(f.originAirport, airportMap.get(f.originAirport) + 1);
        } else {
          airportMap.put(f.originAirport, 1);
        }
      }
    }

    ArrayList<Map.Entry<String, Integer>> entries = new ArrayList<Map.Entry<String, Integer>>(airportMap.entrySet());

    Collections.sort(entries, new Comparator<Map.Entry<String, Integer>>() {
      public int compare(Map.Entry<String, Integer> a, Map.Entry<String, Integer> b) {
        return b.getValue() - a.getValue();
      }
    });

    int limit = min(10, entries.size());
    barCount = limit;

    airportLabels = new String[limit];
    airportCounts = new int[limit];

    for (int i = 0; i < limit; i++) {
      airportLabels[i] = entries.get(i).getKey();
      airportCounts[i] = entries.get(i).getValue();
    }
  }

  void draw() {
    fill(245);
    stroke(180);
    rect(x, y, w, h);

    fill(0);
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    text("Top 10 Origin Airports by Number of Flights", x + w/2, y + 25);

    if (barCount == 0) {
      textFont(labelFont);
      text("No airport data available", x + w/2, y + h/2);
      return;
    }

    float leftMargin = 70;
    float rightMargin = 30;
    float topMargin = 60;
    float bottomMargin = 80;

    float chartX = x + leftMargin;
    float chartY = y + topMargin;
    float chartW = w - leftMargin - rightMargin;
    float chartH = h - topMargin - bottomMargin;

    int maxCount = 0;
    for (int i = 0; i < barCount; i++) {
      if (airportCounts[i] > maxCount) {
        maxCount = airportCounts[i];
      }
    }

    stroke(0);
    line(chartX, chartY + chartH, chartX + chartW, chartY + chartH);
    line(chartX, chartY, chartX, chartY + chartH);

    int steps = 5;
    for (int i = 0; i <= steps; i++) {
      float yy = chartY + chartH - (chartH * i / steps);
      int value = round(maxCount * i / (float)steps);

      stroke(210);
      line(chartX, yy, chartX + chartW, yy);

      fill(0);
      textFont(labelFont);
      textAlign(RIGHT, CENTER);
      text(value, chartX - 8, yy);
    }

    float gap = 20;
    float totalGap = gap * (barCount + 1);
    float barW = (chartW - totalGap) / barCount;

    for (int i = 0; i < barCount; i++) {
      float currentBarW = barW;
      if (currentBarW < 20) {
        currentBarW = 20;
      }

      float barX = chartX + gap + i * (barW + gap);
      float barH = map(airportCounts[i], 0, maxCount, 0, chartH - 20);
      float barY = chartY + chartH - barH;

      fill(#5a90d6);
      stroke(0);
      rect(barX, barY, currentBarW, barH);

      fill(0);
      textFont(labelFont);
      textAlign(CENTER, BOTTOM);
      text(airportCounts[i], barX + currentBarW/2, barY - 4);

      textAlign(CENTER, TOP);
      text(airportLabels[i], barX + currentBarW/2, chartY + chartH + 8);
    }

    noStroke();
  }
}