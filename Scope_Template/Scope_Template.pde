//NU Scope 2
//Kalail
//11/29/2011

//LIBRARIES
import controlP5.*;
import processing.serial.*;

//GLOBAL VARIABLES
//Setup
int WindowWidth = 1024;
int WindowHeight = 576;
int WindowFrameRate = 30;

//Plugin controllers
Serial SerialPort;
ControlP5 UI;
StateMachine ScopeStateMachine;
BufferedReader FileI;
String[] FileO;
SimpleThread DataThread;

//Other variables
float RunningIndicator;
boolean ChangedState;
boolean JustStarted;
boolean Debug = true;
int GlobalCounter;


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
    ScopeStateMachine.AddState("Scope");
    ChangedState = ScopeStateMachine.SetState("Initializing");
}


//DRAW MAIN
void draw()
{
    GlobalCounter++;
    DrawStatic();
    if (ScopeStateMachine.GetState().equals("Scope"))
    {
        DrawStaticScope();
        if (ChangedState)
        {
            enterStateScope();
        }
    }
    else if (ScopeStateMachine.GetState().equals("SelectingPorts"))
    {
        if (ChangedState)
        {
            enterStateSelectingPorts();
        }
        DrawStaticSelectingPorts();
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
void sendData()
{
    SerialPort.write("s 18600 620 1 1 1 0 1 0 0 0 0 1 1 500 1 500 50 1\n");
    println("trans");
}
void selectPort(String portName)
{
    SerialPort = new Serial(this, portName, 115200);
    if (Debug)
    {
         println("Selected Port: " + portName);
    }
    FileO[0] = "NU Scope Configuration File";
    FileO[1] = portName;
    leaveStateSelectingPorts();
}

void controlEvent(ControlEvent theEvent)
{

    if (theEvent.isController())
    {
        if (theEvent.controller().name().equals("Select Ports"))
        {
            leaveStateScope();
            ChangedState = ScopeStateMachine.SetState("SelectingPorts");
        }

        else if (theEvent.controller().value() == 10)
        {   
            selectPort(theEvent.controller().name());
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
    String myString = thisPort.readString();

    // if you got any bytes other than the newline
    if (myString != null)
    {
        myString = trim(myString); // ditch the newline
        //println(myString);
        println("rec: " + myString.length());
    }
}

//stop
public void Exit()
{
    if (ScopeStateMachine.GetState().equals("Scope"))
    {
        SerialPort.clear();
        SerialPort.stop();
    }
    exit();
}

