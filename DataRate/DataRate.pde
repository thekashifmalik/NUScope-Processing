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
IntervalTimer ITimer;
BufferedReader FileI;
String[] FileO;
SimpleThread ValueThread;

//Other variables
float RunningIndicator;
boolean ChangedState;
boolean JustStarted;
int RecievedData;


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
    
    ValueThread = new SimpleThread(this, "ValueThread", 1000, 0, "showValue");
    
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
    SerialPort.bufferUntil('\n');
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
        else if (theEvent.controller().name().equals("Select Ports"))
        {
            leaveStateRunning();
            ChangedState = ScopeStateMachine.SetState("SelectingPorts");
        }
        else if (theEvent.controller().name().equals("Start"))
        {
            ITimer = new IntervalTimer();
            SerialPort.write("1");
            RecievedData = 0;
        }
    }
}

void showValue()
{
    if (RecievedData == 100)
    {
        println("Frequency: " + ITimer.getFrequency());
        println("Interval: " + ITimer.getInterval());
    }
    println(RecievedData);
}

//KeyPress
void keyPressed()
{
}


//Serial Event
void serialEvent(Serial thisPort)
{
    // read the serial buffer as a string until a newline appears
    String myString = thisPort.readString();
    
    //if you got any bytes other than the newline
    if (myString != null)
    {
        myString = trim(myString); // ditch the newline
        if (myString.equals("1000"))
        {
            ITimer.punch();
            RecievedData++;
        }
        //println(myString);
    }
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

