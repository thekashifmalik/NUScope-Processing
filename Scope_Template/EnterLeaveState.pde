
void enterStatePorts()
{
    ChangedState = false;
    if (JustStarted)
    {
    }
    JustStarted = false;
    for (int sIndex = 0; sIndex < Serial.list().length; sIndex++)
    {
        if (Debug)
        {
            println("Detected Port: " + Serial.list()[sIndex]);
        }
        uInterface.addButton(Serial.list()[sIndex], 10, 60, 90 + 30*sIndex, 80, 20);
    }
}

void leaveStatePorts()
{
    if(!JustStarted)
    {
        for (int seriali = 0; seriali < Serial.list().length; seriali++)
        { 
            uInterface.remove((Serial.list()[seriali]));
            if (Debug)
            {
                println("Removed uInterface: " + Serial.list()[seriali]);
            }
        }
    }
    saveStrings("NUScopeConfig.txt", FileO);
    JustStarted = false;
    ChangedState = scopeStateMachine.SetState("Scope");
}

void enterStateScope()
{
    ChangedState = false;
    uInterface.addButton("Select Ports", 1, (width - 180), 10, 80, 20);
    CreateRunningButtons();
    
//    int frequency = 30;
//    DataThread = new SimpleThread(this, "dataThread", 1000/frequency, 0, "sendData");
//    DataThread.start();
}

void leaveStateScope()
{
//    DataThread.quInterfacet();
    SerialPort.clear();
    SerialPort.stop();
    uInterface.remove("Select Ports");
    RemoveRunningButtons();
}

