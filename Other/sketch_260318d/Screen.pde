/*class Screen {
  color backgroundColor;
  ArrayList<Widget> widgets;
  ArrayList<radioButton> radioButtons;
  ArrayList<Slider> sliders;
  
  Screen(color backgroundColor) {
    widgets = new ArrayList<Widget>();
    sliders = new ArrayList<Slider>();
    radioButtons = new ArrayList<radioButton>();
    this.backgroundColor=backgroundColor;
  }
  
  void draw() {
    background(backgroundColor);
    for (Widget w : widgets) {
        w.draw();
    }
    for (radioButton b : radioButtons) {
        b.draw();
    }
    for (Slider s : sliders) {
      s.draw();
    }
  }
  void addWidget(Widget w) {
    widgets.add(w);
  }
  void addRadioButton(radioButton b) {
    radioButtons.add(b);
  }
  void addSlider(Slider s) {
    sliders.add(s);
  }
  
  int getEvent(int mX, int mY) {
    for (Widget w : widgets) {
      if (w.overWidget(mX,mY)) {
        return w.event;
      }
    }
    for (radioButton b : radioButtons) {
      if (b.overWidget(mX,mY)) {
        for (radioButton b2 : radioButtons) {
          b2.selected=false;
   
        }
        b.selected = true;
      }
    }
    return 0;
  }
}*/
