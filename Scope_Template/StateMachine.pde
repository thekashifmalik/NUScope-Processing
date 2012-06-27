class StateMachine
//Allows creation and usage of simple state machines.
{
    //GLOBAL VARIABLES
    private ArrayList States;
    private String CurrentState;
    
    StateMachine()
    {
        States = new ArrayList();
        CurrentState = null;
    }
    
    void AddState(String StateName)
    //Adds a state if it does not already exist.
    {
        if (!States.contains(StateName))
        {
            States.add(StateName);
            if (Debug)
            {
                println("Added state: " + StateName);
            }
        }
        else
        {
            if (Debug)
            {
                println("State " + StateName + " already exists!");
            }
        }
    }
    
    void RemoveState(String StateName)
    //Removes a state if it exists.
    {
        int stateIndex = States.indexOf(StateName);
        
        if (stateIndex != -1)
        {
            States.remove(stateIndex);
            if (Debug)
            {
                println("Removed state: " + StateName);
            }
        }
        else
        {
            if (Debug)
            {
                println("State " + StateName + "does not exist!");
            }
        }
    }
    
    boolean SetState(String StateName)
    //Sets what the current state is, if it exists.
    {
        if (States.contains(StateName))
        {
            CurrentState = StateName;
            if (Debug)
            {
                println("Changed state: " + StateName);
            }
            return true;
        }
        return false;
    }
    
    String GetState()
    //Returns what the current state is.
    {
        return CurrentState;
    }
}
