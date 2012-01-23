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
        }
    }
    
    void RemoveState(String StateName)
    //Removes a state if it exists.
    {
        States.remove(StateName);
    }
    
    boolean SetState(String StateName)
    //Sets what the current state is, if it exists.
    {
        if (States.contains(StateName))
        {
            CurrentState = StateName;
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
