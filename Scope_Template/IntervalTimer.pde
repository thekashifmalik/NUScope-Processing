class IntervalTimer
{
    private boolean Started;
    private boolean Initialized;
    private float CurrentInterval;
    private long TimeLast;
    
    IntervalTimer()
    {
        Started = false;
        Initialized = false;
    }
    
    float getFrequency()
    {
        return (1/(CurrentInterval/1000));
    }
    
    void punch()
    {
        if (Started)
        {
            long TimeNow = millis();
            long newInterval = (TimeNow - TimeLast);
            if (Initialized)
            {
                CurrentInterval = (float)(newInterval + CurrentInterval) / 2;
            }
            else
            {
                CurrentInterval = newInterval;
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
