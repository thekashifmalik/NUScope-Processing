import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

class SimpleThread extends Thread
{
	// Simple customizable threads.

	public String ID;
	public boolean IsRunning;
	private int WaitInterval;
	private int CountTo;
	private int Count;
	private Method RunMethod;
	private PApplet CallingApplet;

	SimpleThread (PApplet applet, String id, int waitInterval, int countTo, String method)
	{
		// Constructor
		
		ID = id;
		WaitInterval = waitInterval;
		CountTo = countTo;
		CallingApplet = applet;
		try
		{
			RunMethod = CallingApplet.getClass().getMethod(method, null);
		}
		catch (NoSuchMethodException e)
		{
			if (Debug)
			{
				println("Method not found!");
			}
		}
		
		IsRunning = false;
	}

	int getCount()
	{
		// Get the number of times the thread has executed.

		return Count;
	}

	void start()
	{
		// Start execution.

		Count = 0;
		IsRunning = true;
		if (Debug)
		{
			println("Started thread, ID: " + ID + ", Freq: " + 1000/WaitInterval + "Hz, Method: " + RunMethod);
		}
		super.start();
	}

	void run ()
	{
		// Run method, called by super.start().

		while (IsRunning && (Count < CountTo || CountTo == 0))
		{
			try
			{
				RunMethod.invoke(CallingApplet, null);
			}
			catch (IllegalArgumentException e)
			{
			} 
			catch (IllegalAccessException e)
			{
			} 
			catch (InvocationTargetException e)
			{
			}
			
			Count++;

			try
			{
				sleep(WaitInterval);
			}
			catch (Exception e)
			{
			}
		}
	}

	void quit()
	{
		// Exit the thread gracefully.

		IsRunning = false;
		// In case the thread is waiting. . .
		interrupt();
	}
}

