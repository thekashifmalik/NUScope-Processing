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
    // uInterface.addButton("Start", 1, 40, 80, 80, 20);
    // On/off buttons
    uInterface.addToggle("A1 On", 20, 80, 20, 20);
    uInterface.addToggle("A2 On", 20, 240, 20, 20);
    uInterface.addToggle("D1 On", 20, 400, 20, 20);
    uInterface.addToggle("D2 On", 20, 440, 20, 20);
    uInterface.addToggle("D3 On", 20, 480, 20, 20);
    uInterface.addToggle("D4 On", 20, 520, 20, 20);
    
    // Scope
    uInterface.addSlider("Sample Rate", 0, 100000, 50000, WindowWidth - 320, 100, 240, 20);
    RadioButton s;
    s = uInterface.addRadioButton("ScopeMode", WindowWidth - 320, 140);
    s.setItemsPerRow(10);
    s.setNoneSelectedAllowed(false);
    s.setSpacingColumn(40);
    s.addItem("Cont.", 1);
    s.addItem("Freeze", 2);
    s.addItem("Sweep", 3);
    s.activate("Cont.");
    
    // Function generator
    RadioButton r;
    r = uInterface.addRadioButton("Function", WindowWidth - 320, 200);
    r.setItemsPerRow(10);
    r.setNoneSelectedAllowed(false);
    r.setSpacingColumn(30);
    r.addItem("OFF", 1);
    r.addItem("SIN", 2);
    r.addItem("COS", 3);
    r.addItem("TAN", 4);
    r.addItem("REC", 5);
    r.activate("OFF");
    uInterface.addSlider("Function Freq", 0, 100000, 50000, WindowWidth - 320, 220, 240, 20);
    
    // Square Wave generator
    uInterface.addToggle("SQR ON", WindowWidth - 320, 320, 20, 20);
    uInterface.addSlider("SQR Freq", 0, 100000, 50000, WindowWidth - 320, 360, 240, 20);
    uInterface.addSlider("SQR Duty", 0, 100, 50, WindowWidth - 320, 390, 240, 20);
    
    // Current
    uInterface.addToggle("PWR On", WindowWidth - 320, 470, 20, 20);
    uInterface.addSlider("Current", 0, 100, 0, WindowWidth - 320, 510, 240, 20);
}

void RemoveRunningButtons()
{
    uInterface.remove("Start");
    uInterface.remove("A1 On");
    uInterface.remove("A2 On");
    uInterface.remove("D1 On");
    uInterface.remove("D2 On");
    uInterface.remove("D3 On");
    uInterface.remove("D4 On");
    
    uInterface.remove("Sample Rate");
    uInterface.remove("ScopeMode");
    
    uInterface.remove("Function");
    uInterface.remove("Function Freq");
    
    uInterface.remove("SQR ON");
    uInterface.remove("SQR Freq");
    uInterface.remove("SQR Duty");
    
    uInterface.remove("PWR On");
    uInterface.remove("Current");
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

void DrawStaticPorts()
{
    stroke(255);
    fill(255);
    text("Select Port", 35, 70);
    fill(0, 0);
}

void DrawStaticInitializing()
{
}
