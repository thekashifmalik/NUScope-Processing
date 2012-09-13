// NU Scope 2
// Kalail
// 9/12/2012

// Libraries
import controlP5.*;
import processing.serial.*;

// Globals
int windowWidth;
int windowHeight;
int windowFrameRate;

Serial serialPort;
ControlP5 uInterface;
StateMachine scopeStateMachine;
BufferedReader fileI;
String[] fileO;
SimpleThread dataThread;

int color_background = 0
int color_main;

float runningIndicator;
boolean changedState;
int globalCounter;

boolean debug = true;

// SETUP MAIN
void setup()
{
	//Window properties
	size(windowWidth, windowHeight);
	frameRate(windowFrameRate);
	background(color_background);
	smooth();

	//Initialize state machine
	scopeStateMachine = new StateMachine();
	scopeStateMachine.addState("Ports");
	scopeStateMachine.addState("Scope");
	scopeStateMachine.addState("Update");
	
	changedState = false;
	uInterface = new ControlP5(this);
	RunningIndicator = 0;
	
	// Get config file
	fileI = createReader("NUScopeConfig.txt");
	fileO = new String[2];
	uInterface.addButton("Exit", 1, (width - 90), 10, 80, 20);
	
	JustStarted = true;
	
	ChangedState = scopeStateMachine.SetState("Ports");
	
	MasterThread = new SimpleThread(this, "Master", 1000/MasterFrequency, 0, "master");
	MasterThread.start();
}

boolean getConfig()
{
	if (fileI != null)
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
					return true;
				}
			}
		}
	}
	return false
}
void master()
{
}

//DRAW MAIN
void draw()
{
	DrawStatic();
	currentState = scopeStateMachine.GetState();
	if (currentState.equals("Scope"))
	{
		DrawStaticScope();
		if (ChangedState)
		{
			enterStateScope();
		}
	}
	else if (currentState.equals("Ports"))
	{
		if (ChangedState)
		{
			enterStatePorts();
		}
		DrawStaticPorts();
	}
}


//void sendData()
//{
//    SerialPort.write("s 18600 620 1 1 1 0 1 0 0 0 0 1 1 500 1 500 50 1\n");
//    println("trans");
//}

void selectPort(String portName)
{
	SerialPort = new Serial(this, portName, 115200);
	if (Debug)
	{
		 println("Selected Port: " + portName);
	}
	FileO[0] = "NU Scope Configuration File";
	FileO[1] = portName;
	leaveStatePorts();
}

void controlEvent(ControlEvent theEvent)
{

	if (theEvent.isController())
	{
		if (theEvent.controller().name().equals("Select Ports"))
		{
			leaveStateScope();
			ChangedState = scopeStateMachine.SetState("Ports");
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
	if (scopeStateMachine.GetState().equals("Scope"))
	{
		SerialPort.clear();
		SerialPort.stop();
	}
	MasterThread.quit();
	exit();
}

