// code for handling axis scale sliders for graphs, written by Mingqi
float scatterPlotRawMinX = 0;
float scatterPlotRawMaxX = 1;
float scatterPlotRawMinY = 0;
float scatterPlotRawMaxY = 1;

float histogramRawMinX = 0;
float histogramRawMaxX = 1;
int histogramRawMinY = 0;
int histogramRawMaxY = 1;

float barChartRawMinY = 0;
float barChartRawMaxY = 1;
int barChartVisibleStartIndex = 0;
int barChartVisibleEndIndexExclusive = 0;

RangeSlider scatterPlotXScaleSlider;
VerticalRangeSlider scatterPlotYScaleSlider;
RangeSlider histogramXScaleSlider;
VerticalRangeSlider histogramYScaleSlider;
RangeSlider barChartXScaleSlider;
VerticalRangeSlider barChartYScaleSlider;

String formatScaleValue(float value, String type) {
    return getCorrectFormat(value, type);
    //return String.format("%.0f", value);
}

float safeAxisSpan(float low, float high) {
    if (high - low == 0) {
        return 1;
    }
    return high - low;
}

float ensureDistinctUpper(float low, float high) {
    if (high <= low) {
        return low + 1;
    }
    return high;
}

void resetScatterPlotScaleControls() {
    scatterPlotXScaleSlider = null;
    scatterPlotYScaleSlider = null;
}

void resetHistogramScaleControls() {
    histogramXScaleSlider = null;
    histogramYScaleSlider = null;
}

void resetBarChartScaleControls() {
    barChartXScaleSlider = null;
    barChartYScaleSlider = null;
}

void ensureScatterPlotScaleSliders(Screen s) {
    if (scatterPlotXScaleSlider == null) {
        scatterPlotXScaleSlider = new RangeSlider(
            s.scatterPlot.x,
            s.scatterPlot.y + s.scatterPlot.h + 55,
            s.scatterPlot.w,
            50,
            "scatterXAxisScale",
            0,
            0,
            18,
            28,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        scatterPlotXScaleSlider.displayLabel = "X scale";
    }
    if (scatterPlotYScaleSlider == null) {
        scatterPlotYScaleSlider = new VerticalRangeSlider(
            s.scatterPlot.x + s.scatterPlot.w + 170,
            s.scatterPlot.y +40,
            36,
            s.scatterPlot.h,
            "scatterYAxisScale",
            22,
            18,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        scatterPlotYScaleSlider.displayLabel = "Y scale";
    }
}

void ensureHistogramScaleSliders(Screen s) {
    if (histogramXScaleSlider == null) {
        histogramXScaleSlider = new RangeSlider(
            s.histogram.x,
            s.histogram.y + s.histogram.h + 55,
            s.histogram.w,
            50,
            "histogramXAxisScale",
            0,
            0,
            18,
            28,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        histogramXScaleSlider.displayLabel = "X scale";
    }
    if (histogramYScaleSlider == null) {
        histogramYScaleSlider = new VerticalRangeSlider(
            s.histogram.x + s.histogram.w + 170,
            s.histogram.y + 40,
            36,
            s.histogram.h,
            "histogramYAxisScale",
            22,
            18,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        histogramYScaleSlider.displayLabel = "Y scale";
    }
}

void ensureBarChartScaleSliders(Screen s) {
    if (barChartXScaleSlider == null) {
        barChartXScaleSlider = new RangeSlider(
            s.barChart.x,
            s.barChart.y + s.barChart.h + 55,
            s.barChart.w,
            50,
            "barChartXAxisScale",
            0,
            0,
            18,
            28,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        barChartXScaleSlider.displayLabel = "Visible bars";
    }
    if (barChartYScaleSlider == null) {
        barChartYScaleSlider = new VerticalRangeSlider(
            s.barChart.x + s.barChart.w + 170,
            s.barChart.y +40,
            36,
            s.barChart.h,
            "barChartYAxisScale",
            22,
            18,
            color(#c8c8c8),
            color(#5a90d6),
            color(#2B9453),
            color(#000000),
            smallFont
        );
        barChartYScaleSlider.displayLabel = "Y scale";
    }
}

void handleSliderInteraction(RangeSlider slider) {
    if (slider == null) return;
    if (mousePressed) {
        if (!slider.isDragging()) {
            slider.press();
        }
        if (slider.isDragging()) {
            slider.drag();
        }
    } else if (slider.isDragging()) {
        slider.release();
    }
}

void handleSliderInteraction(VerticalRangeSlider slider) {
    if (slider == null) return;
    if (mousePressed) {
        if (!slider.isDragging()) {
            slider.press();
        }
        if (slider.isDragging()) {
            slider.drag();
        }
    } else if (slider.isDragging()) {
        slider.release();
    }
}

void updateScatterPlotScaleFromSliders() {
    ensureScatterPlotScaleSliders(graphShowScreen);
    handleSliderInteraction(scatterPlotXScaleSlider);
    handleSliderInteraction(scatterPlotYScaleSlider);

    float xSpan = safeAxisSpan(scatterPlotRawMinX, scatterPlotRawMaxX);
    float ySpan = safeAxisSpan(scatterPlotRawMinY, scatterPlotRawMaxY);

    minXsp = scatterPlotRawMinX + scatterPlotXScaleSlider.startValue * xSpan;
    maxXsp = scatterPlotRawMinX + scatterPlotXScaleSlider.endValue * xSpan;
    minYsp = scatterPlotRawMinY + scatterPlotYScaleSlider.startValue * ySpan;
    maxYsp = scatterPlotRawMinY + scatterPlotYScaleSlider.endValue * ySpan;

    maxXsp = ensureDistinctUpper(minXsp, maxXsp);
    maxYsp = ensureDistinctUpper(minYsp, maxYsp);
}

void updateHistogramScaleFromSliders() {
    ensureHistogramScaleSliders(histogramShowScreen);
    handleSliderInteraction(histogramXScaleSlider);
    handleSliderInteraction(histogramYScaleSlider);

    float xSpan = safeAxisSpan(histogramRawMinX, histogramRawMaxX);
    float ySpan = safeAxisSpan(histogramRawMinY, histogramRawMaxY);

    minValueHistogram = histogramRawMinX + histogramXScaleSlider.startValue * xSpan;
    maxValueHistogram = histogramRawMinX + histogramXScaleSlider.endValue * xSpan;
    minfreqHistogram = int(histogramRawMinY + histogramYScaleSlider.startValue * ySpan);
    maxfreqHistogram = int(histogramRawMinY + histogramYScaleSlider.endValue * ySpan);

    maxValueHistogram = ensureDistinctUpper(minValueHistogram, maxValueHistogram);
    if (maxfreqHistogram <= minfreqHistogram) {
        maxfreqHistogram = minfreqHistogram + 1;
    }
}

void updateBarChartScaleFromSliders() {
    ensureBarChartScaleSliders(barChartShowScreen);
    handleSliderInteraction(barChartXScaleSlider);
    handleSliderInteraction(barChartYScaleSlider);

    int totalBars = showBCdata.size();
    barChartVisibleStartIndex = barChartXScaleSlider.getStartIndex(totalBars);
    barChartVisibleEndIndexExclusive = barChartXScaleSlider.getEndIndexExclusive(totalBars);

    float ySpan = safeAxisSpan(barChartRawMinY, barChartRawMaxY);
    minBCval = barChartRawMinY + barChartYScaleSlider.startValue * ySpan;
    maxBCval = barChartRawMinY + barChartYScaleSlider.endValue * ySpan;
    maxBCval = ensureDistinctUpper(minBCval, maxBCval);
}

void drawScatterPlotScaleControls(Screen s) {
    ensureScatterPlotScaleSliders(s);
    updateScatterPlotScaleFromSliders();
    scatterPlotXScaleSlider.minDisplayValue = scatterPlotRawMinX;
    scatterPlotXScaleSlider.maxDisplayValue = scatterPlotRawMaxX;
    scatterPlotYScaleSlider.minDisplayValue = scatterPlotRawMinY;
    scatterPlotYScaleSlider.maxDisplayValue = scatterPlotRawMaxY;
    scatterPlotXScaleSlider.type = scatterTypeX;
    scatterPlotYScaleSlider.type = scatterTypeY;
    scatterPlotXScaleSlider.draw();
    scatterPlotYScaleSlider.draw();
}

void drawHistogramScaleControls(Screen s) {
    ensureHistogramScaleSliders(s);
    updateHistogramScaleFromSliders();
    histogramXScaleSlider.minDisplayValue = histogramRawMinX;
    histogramXScaleSlider.maxDisplayValue = histogramRawMaxX;
    histogramYScaleSlider.minDisplayValue = histogramRawMinY;
    histogramYScaleSlider.maxDisplayValue = histogramRawMaxY;
    histogramXScaleSlider.type = hsType;
    histogramYScaleSlider.type = " ";
    histogramXScaleSlider.draw();
    histogramYScaleSlider.draw();
}

void drawBarChartScaleControls(Screen s) {
    ensureBarChartScaleSliders(s);
    updateBarChartScaleFromSliders();
    barChartXScaleSlider.minDisplayValue = 0;
    barChartXScaleSlider.maxDisplayValue = showBCdata.size();
    barChartYScaleSlider.minDisplayValue = barChartRawMinY;
    barChartYScaleSlider.maxDisplayValue = barChartRawMaxY;
    barChartYScaleSlider.type = " ";
    barChartYScaleSlider.type = " ";
    barChartXScaleSlider.draw();
    barChartYScaleSlider.draw();
}
