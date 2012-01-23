class IntervalTimer
{
    private boolean Started;
    private boolean Initialized;
    private long CurrentInterval;
    private long TimeLast;
    
    IntervalTimer()
    {
        Started = false;
        Initialized = false;
    }
    
    double getFrequency()
    {
        return (1/((double)CurrentInterval/1000));
    }
    
    long getInterval()
    {
        return CurrentInterval;
    }
    
    void punch()
    {
        if (Started)
        {
            long TimeNow = millis();
            long newInterval = (TimeNow - TimeLast);
            if (Initialized)
            {
                CurrentInterval = (long)(newInterval + CurrentInterval) / 2;
            }
            else
            {
                CurrentInterval = newInterval;
                Initialized = true;
            }
            TimeLast = TimeNow;
        }
        else
        {
            TimeLast = millis();
            Started = true;
        }
    }
}
