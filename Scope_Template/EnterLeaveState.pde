
void enterStateSelectingPorts()
{
    ChangedState = false;
    if (JustStarted)
    {
        if (FileI != null)
        {
            String lineIn;
            try
            {
                lineIn = FileI.readLine();
            } 
            catch (IOException e)
            {
                e.printStackTrace();
                lineIn = null;
            }
            if (lineIn.equals("NU Scope Configuration File"))
            {
                try
                {
                    lineIn = FileI.readLine();
                } 
                catch (IOException e)
                {
                    e.printStackTrace();
                    lineIn = null;
                }
                
                for (int sIndex2 = 0; sIndex2 < Serial.list().length; sIndex2++)
                {
                    if (Serial.list()[sIndex2].equals(lineIn))
                    {
                        selectPort(lineIn);
                        return;
                    }
                }
            }
        }
    }
    JustStarted = false;
    for (int sIndex = 0; sIndex < Serial.list().length; sIndex++)
    {
        if (Debug)
        {
            println("Detected Port: " + Serial.list()[sIndex]);
        }
        UI.addButton(Serial.list()[sIndex], 10, 60, 90 + 30*sIndex, 80, 20);
    }
}

void leaveStateSelectingPorts()
{
    if(!JustStarted)
    {
        for (int seriali = 0; seriali < Serial.list().length; seriali++)
        { 
            UI.remove((Serial.list()[seriali]));
            if (Debug)
            {
                println("Removed UI: " + Serial.list()[seriali]);
            }
        }
    }
    saveStrings("NUScopeConfig.txt", FileO);
    JustStarted = false;
    ChangedState = ScopeStateMachine.SetState("Scope");
}

void enterStateScope()
{
    ChangedState = false;
    UI.addButton("Select Ports", 1, (width - 180), 10, 80, 20);
    CreateRunningButtons();
    
    int frequency = 30;
    DataThread = new SimpleThread(this, "dataThread", 1000/frequency, 0, "sendData");
    DataThread.start();
}

void leaveStateScope()
{
    DataThread.quit();
    SerialPort.clear();
    SerialPort.stop();
    UI.remove("Select Ports");
    RemoveRunningButtons();
}

