import java.lang.reflect.Method;
import java.lang.reflect.InvocationTargetException;

//Allows the creation and excecution of customized threads.
class SimpleThread extends Thread
{
    public String ID;
    public boolean IsRunning;
    private int WaitInterval;
    private int CountTo;
    private int Count;
    private Method RunMethod;
    private PApplet CallingApplet;

    // Constructor, create the thread
    SimpleThread (PApplet applet, String id, int waitInterval, int countTo, String method)
    {
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
        }
        
        IsRunning = false;
        Count = 0;
    }

    int getCount()
    {
        return Count;
    }

    void start()
    {
        IsRunning = true;
        super.start();
    }

    // We must implement run, this gets triggered by start()
    void run ()
    {
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
        //System.out.println(ID + " thread is done!");  // The thread is done when we get to the end of run()
    }


    // Our method that quits the thread
    void quit()
    {
        IsRunning = false;
        //In case the thread is waiting. . .
        interrupt();
    }
}

