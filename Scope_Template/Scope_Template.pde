// NU Scope 2
// Kalail
// 9/12/2012

// Libraries
import controlP5.*;
import processing.serial.*;

// Globals
boolean debug = false;

int windowWidth = 1024;
int windowHeight = 576;
int windowFrameRate = 30;

ControlP5 uInterface;
SimpleThread scopeThread;
SimpleThread dataThread;
Scope scope;

int colorBackground = 0;
int colorMain;

float runningIndicator = 0;
String currentState = "Initialize";

boolean picConnected = false;
boolean rawDataReady = false;
boolean askforDataReady = false;
boolean constructingPacket = false;
boolean readyToAsk = false;

byte[] packetRaw = new byte[64];

// Initialization
void setup()
{	
	// Window properties
	size(windowWidth, windowHeight);
	frameRate(windowFrameRate);
	background(colorBackground);
	smooth();

	// UI
	uInterface = new ControlP5(this);
	uInterface.addButton("Exit", 1, (width - 90), 10, 80, 20);

	changeState("Scope");
}

// Draw loop
void draw()
{
	drawStatic();
	if (currentState.equals("Scope"))
	{
		drawStaticScope();
		drawScope();
	}
}

void scopeThreadMain()
{

	// if ready - Parse data
	if (rawDataReady)
	{
		rawDataReady = false;
		parseData();
	}
}



void parseData()
{
	// Parse packetRaw.
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
	}
}
