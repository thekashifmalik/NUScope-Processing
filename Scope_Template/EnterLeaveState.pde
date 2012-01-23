void enterStateInitializing()
{
    FileI = createReader("NUScopeConfig.txt");
    FileO = new String[2];
    UI.addButton("Exit", 1, (width - 90), 10, 80, 20);
    ChangedState = false;
}

void leaveStateInitializing()
{
    JustStarted = true;
}

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
    
    for (int sIndex = 0; sIndex < Serial.list().length; sIndex++)
    {
        println(Serial.list()[sIndex]);
        UI.addButton(Serial.list()[sIndex], 10, 60, 90 + 30*sIndex, 80, 20);
    }
}

void leaveStateSelectingPorts()
{
    println(Serial.list().length);
    for (int seriali = 0; seriali < Serial.list().length; seriali++)
    {
        println(Serial.list()[seriali]);
        UI.remove(Serial.list()[seriali]);
    }
    saveStrings("NUScopeConfig.txt", FileO);
    JustStarted = false;
    ChangedState = ScopeStateMachine.SetState("Running");
}

void enterStateRunning()
{
    UI.addButton("Select Ports", 1, (width - 180), 10, 80, 20);
    ChangedState = false;
}

void leaveStateRunning()
{
    SerialPort.clear();
    SerialPort.stop();
    UI.remove("Select Ports");
}

