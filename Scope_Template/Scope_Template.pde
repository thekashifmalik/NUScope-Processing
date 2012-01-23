//NU Scope 2
//Kalail
//11/29/2011

//LIBRARIES
import controlP5.*;
import processing.serial.*;

//GLOBAL VARIABLES
//Setup
int WindowWidth = 640;
int WindowHeight = 360;
int WindowFrameRate = 30;

//Plugin controllers
Serial SerialPort;
ControlP5 UI;
StateMachine ScopeStateMachine;
BufferedReader FileI;
String[] FileO;

//Other variables
float RunningIndicator;
boolean ChangedState;
boolean JustStarted;


//SETUP MAIN
void setup()
{
    size(WindowWidth, WindowHeight);
    frameRate(WindowFrameRate);
    background(0);
    smooth();

    //Initialize plugins
    ScopeStateMachine = new StateMachine();
    ScopeStateMachine.AddState("Initializing");
    ScopeStateMachine.AddState("SelectingPorts");
    ScopeStateMachine.AddState("Running");
    ChangedState = ScopeStateMachine.SetState("Initializing");

    UI = new ControlP5(this);
    RunningIndicator = 0;
}


//DRAW MAIN
void draw()
{
    DrawStatic();
    if (ScopeStateMachine.GetState().equals("Running"))
    {
        if (ChangedState)
        {
            enterStateRunning();
        }
    }
    else if (ScopeStateMachine.GetState().equals("SelectingPorts"))
    {
        if (ChangedState)
        {
            enterStateSelectingPorts();
        }
        fill(255);
        text("Select Port", 35, 70);
        fill(0, 0);
    }
    else if (ScopeStateMachine.GetState().equals("Initializing"))
    {
        if (ChangedState)
        {
            enterStateInitializing();
        }
        leaveStateInitializing();
        ChangedState = ScopeStateMachine.SetState("SelectingPorts");
    }
}

void selectPort(String portName)
{
    SerialPort = new Serial(this, portName, 115200);
    FileO[0] = "NU Scope Configuration File";
    FileO[1] = portName;
    leaveStateSelectingPorts();
}

void controlEvent(ControlEvent theEvent)
{
    if (theEvent.isController())
    {
        if (theEvent.controller().value() == 10)
        {
            selectPort(theEvent.controller().name());
        }
        if (theEvent.controller().name().equals("Select Ports"))
        {
            leaveStateRunning();
            ChangedState = ScopeStateMachine.SetState("SelectingPorts");
        }
    }
}


//KeyPress
void keyPressed()
{
}


//Serial Event
void serialEvent(Serial thisPort)
{
    // read the serial buffer as a string until a newline appears
    //String myString = thisPort.readString();
    
    // if you got any bytes other than the newline
    //if (myString != null)
    //{
        //myString = trim(myString); // ditch the newline
        //println(myString);
    //}
}

//stop
public void Exit()
{
    if (ScopeStateMachine.GetState().equals("Running"))
    {
        SerialPort.clear();
        SerialPort.stop();
    }
    exit();
}

