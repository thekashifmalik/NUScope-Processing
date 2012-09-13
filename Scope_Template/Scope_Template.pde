// NU Scope 2
// Kalail
// 9/12/2012

// Libraries
import controlP5.*;
import processing.serial.*;

// Globals
boolean debug = true;

int windowWidth = 1024;
int windowHeight = 576;
int windowFrameRate = 30;

Serial serialPort;
ControlP5 uInterface;

int colorBackground = 0;
int colorMain;

float runningIndicator = 0;
String currentState = "Initialize";


// Initialization
void setup()
{
	//Window properties
	size(windowWidth, windowHeight);
	frameRate(windowFrameRate);
	background(colorBackground);
	smooth();

	uInterface = new ControlP5(this);
	uInterface.addButton("Exit", 1, (width - 90), 10, 80, 20);

	changeState("Ports");
}

// Draw loop
void draw()
{
	drawStatic();
	if (currentState.equals("Scope"))
	{
		drawStaticScope();
	}
	else if (currentState.equals("Ports"))
	{
		drawStaticPorts();
	}
}

//void sendData()
//{
//    serialPort.write("s 18600 620 1 1 1 0 1 0 0 0 0 1 1 500 1 500 50 1\n");
//    println("trans");
//}

void selectPort(String portName)
{
	serialPort = new Serial(this, portName, 115200);
	if (debug)
	{
		 println("Selected Port: " + portName);
	}
	changeState("Scope");
}

void controlEvent(ControlEvent theEvent)
{

	if (theEvent.isController())
	{
		if (theEvent.controller().name().equals("Exit"))
		{
			exit();
			changeState("Exit");
		}

		else if (theEvent.controller().name().equals("Select Ports"))
		{
			changeState("Ports");
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
