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
    UI.addToggle("A1 On", 20, 80, 20, 20);
    UI.addToggle("A2 On", 20, 240, 20, 20);
    UI.addToggle("D1 On", 20, 400, 20, 20);
    UI.addToggle("D2 On", 20, 440, 20, 20);
    UI.addToggle("D3 On", 20, 480, 20, 20);
    UI.addToggle("D4 On", 20, 520, 20, 20);
    
    // Scope
    UI.addSlider("Sample Rate", 0, 100000, 50000, WindowWidth - 320, 100, 240, 20);
    RadioButton s;
    s = UI.addRadioButton("ScopeMode", WindowWidth - 320, 140);
    s.setItemsPerRow(10);
    s.setNoneSelectedAllowed(false);
    s.setSpacingColumn(40);
    s.addItem("Cont.", 1);
    s.addItem("Freeze", 2);
    s.addItem("Sweep", 3);
    s.activate("Cont.");
    
    // Function generator
    RadioButton r;
    r = UI.addRadioButton("Function", WindowWidth - 320, 200);
    r.setItemsPerRow(10);
    r.setNoneSelectedAllowed(false);
    r.setSpacingColumn(30);
    r.addItem("OFF", 1);
    r.addItem("SIN", 2);
    r.addItem("COS", 3);
    r.addItem("TAN", 4);
    r.addItem("REC", 5);
    r.activate("OFF");
    UI.addSlider("Function Freq", 0, 100000, 50000, WindowWidth - 320, 220, 240, 20);
    
    // Square Wave generator
    UI.addToggle("SQR ON", WindowWidth - 320, 320, 20, 20);
    UI.addSlider("SQR Freq", 0, 100000, 50000, WindowWidth - 320, 360, 240, 20);
    UI.addSlider("SQR Duty", 0, 100, 50, WindowWidth - 320, 390, 240, 20);
    
    // Current
    UI.addToggle("PWR On", WindowWidth - 320, 470, 20, 20);
    UI.addSlider("Current", 0, 100, 0, WindowWidth - 320, 510, 240, 20);
}

void RemoveRunningButtons()
{
    UI.remove("Start");
    UI.remove("A1 On");
    UI.remove("A2 On");
    UI.remove("D1 On");
    UI.remove("D2 On");
    UI.remove("D3 On");
    UI.remove("D4 On");
    
    UI.remove("Sample Rate");
    UI.remove("ScopeMode");
    
    UI.remove("Function");
    UI.remove("Function Freq");
    
    UI.remove("SQR ON");
    UI.remove("SQR Freq");
    UI.remove("SQR Duty");
    
    UI.remove("PWR On");
    UI.remove("Current");
}

void DrawStaticScope()
{
    // Graph placeholder
    stroke(color(255));
    fill(20);
    rect(60,80, 620, 140);
    rect(60,240, 620, 140);
    rect(60,400, 620, 24);
    rect(60,440, 620, 24);
    rect(60,480, 620, 24);
    rect(60,520, 620, 24);
    
    stroke(255);
    fill(255);
    text("Scope", WindowWidth - 320, 80);
    text("Function Generator", WindowWidth - 320, 180);
    text("Square Wave Generator", WindowWidth - 320, 300);
    text("Power", WindowWidth - 320, 450);
    fill(0,0);
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
