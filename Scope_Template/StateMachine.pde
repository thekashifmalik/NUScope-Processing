void changeState(String newState)
{
	if (currentState.equals("Scope"))
	{
		leaveStateScope();
	}
	else if (currentState.equals("Initialize"))
	{
	}

	if (newState.equals("Scope"))
	{
		enterStateScope();
	}

	else if (newState.equals("Exit"))
	{
		exit();
	}
	currentState = newState;
}


void openPicConnection()
{
   openPic(0);
   if (!picConnected)
   {
     openPicConnection();
   }
}

void enterStateScope()
{
    openPicConnection();
    // start data thread
    dataThread = new SimpleThread(this, "dataThread", 1000/dataThreadFrequency, 0, "dataThreadMain");
    dataThread.start();
    // start scope thread
    scopeThread = new SimpleThread(this, "scopeThread", 0, 0, "scopeThreadMain");
    scopeThread.start();
    createScopeButtons();
}

void leaveStateScope()
{
    serialPort.clear();
    serialPort.stop();
    uInterface.remove("Select Ports");
    removeScopeButtons();
    dataThread.quit();
    scopeThread.quit();
}

void createScopeButtons()
{
    // On/off buttons
    uInterface.addToggle("A1 On", 20, 80, 20, 20);
    uInterface.addToggle("A2 On", 20, 240, 20, 20);
    uInterface.addToggle("D1 On", 20, 400, 20, 20);
    uInterface.addToggle("D2 On", 20, 440, 20, 20);
    uInterface.addToggle("D3 On", 20, 480, 20, 20);
    uInterface.addToggle("D4 On", 20, 520, 20, 20);
    
    // Scope
    uInterface.addSlider("Sample Rate", 0, 100000, 50000, windowWidth - 320, 100, 240, 20);
    RadioButton s;
    s = uInterface.addRadioButton("ScopeMode", windowWidth - 320, 140);
    s.setItemsPerRow(10);
    s.setNoneSelectedAllowed(false);
    s.setSpacingColumn(40);
    s.addItem("Cont.", 1);
    s.addItem("Freeze", 2);
    s.addItem("Sweep", 3);
    s.activate("Cont.");
    
    // Function generator
    RadioButton r;
    r = uInterface.addRadioButton("Function", windowWidth - 320, 200);
    r.setItemsPerRow(10);
    r.setNoneSelectedAllowed(false);
    r.setSpacingColumn(30);
    r.addItem("OFF", 1);
    r.addItem("SIN", 2);
    r.addItem("COS", 3);
    r.addItem("TAN", 4);
    r.addItem("REC", 5);
    r.activate("OFF");
    uInterface.addSlider("Function Freq", 0, 100000, 50000, windowWidth - 320, 220, 240, 20);
    
    // Square Wave generator
    uInterface.addToggle("SQR ON", windowWidth - 320, 320, 20, 20);
    uInterface.addSlider("SQR Freq", 0, 100000, 50000, windowWidth - 320, 360, 240, 20);
    uInterface.addSlider("SQR Duty", 0, 100, 50, windowWidth - 320, 390, 240, 20);
    
    // Current
    uInterface.addToggle("PWR On", windowWidth - 320, 470, 20, 20);
    uInterface.addSlider("Current", 0, 100, 0, windowWidth - 320, 510, 240, 20);
}

void removeScopeButtons()
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
