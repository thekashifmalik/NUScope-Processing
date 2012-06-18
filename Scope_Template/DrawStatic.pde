void DrawStatic()
{
    //Draw titles
    background(0);
    stroke(255);
    fill(255);
    textAlign(CENTER);
    text("NU Scope v1.0", width/2, 20);
    textAlign(LEFT);
    
    //Draw running indicatior
    stroke(255);
    fill(255);
    RunningIndicator += 0.3;
    arc(20, 20, 20, 20, RunningIndicator, (240 * PI/180) + RunningIndicator);
    stroke(0);
    fill(0);
    arc(20, 20, 15, 15, 0, 2 * PI);

}

void CreateRunningButtons()
{
    // UI.addButton("Start", 1, 40, 80, 80, 20);
    // On/off buttons
    UI.addToggle("A1 On", 10, 80, 20, 20);
    UI.addToggle("D1 On", 10, 250, 20, 20);
    UI.addToggle("D2 On", 10, 290, 20, 20);
    
    // Function generator
    RadioButton r;
    r = UI.addRadioButton("Function", 470, 120);
    r.setItemsPerRow(5);
    r.setNoneSelectedAllowed(false);
    r.setSpacingColumn(20);
    r.addItem("OFF", 1);
    r.addItem("SIN", 2);
    r.addItem("COS", 3);
    r.addItem("TAN", 4);
    r.addItem("REC", 5);
    r.activate("OFF");
    UI.addSlider("Function freq", 0, 100000, 50000, 470, 140, 100, 15);
    UI.addSlider("Function duty", 0, 100, 50, 470, 160, 100, 15);
    
    // Sample rate
    UI.addSlider("Sample Rate", 0, 100000, 50000, 470, 80, 100, 15);
    
    // Current
    UI.addToggle("PWR On", 540, 300, 20, 20);
    UI.addSlider("Current", 0, 100, 0, 590, 220, 20, 100);
}

void RemoveRunningButtons()
{
    UI.remove("Start");
    UI.remove("A1 On");
    UI.remove("D1 On");
    UI.remove("D2 On");
    UI.remove("Function");
    UI.remove("Function freq");
    UI.remove("Function duty");
    UI.remove("Sample Rate");
    UI.remove("PWR On");
    UI.remove("Current");
}

void DrawStaticScope()
{
    // Graph placeholder
    stroke(color(255));
    fill(20);
    rect(40,80, 420, 150);
    rect(40,250, 420, 24);
    rect(40,290, 420, 24);
    fill(0, 0);
}

void DrawStaticSelectingPorts()
{
    stroke(255);
    fill(255);
    text("Select Port", 35, 70);
    fill(0, 0);
}

void DrawStaticInitializing()
{
}
