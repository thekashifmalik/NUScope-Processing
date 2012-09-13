class StateMachine
{
	// Simple state machine class.

	// Class variables
	private ArrayList States;
	private String CurrentState;
	
	public StateMachine()
	{
		// Constructor

		States = new ArrayList();
		CurrentState = null;
	}
	
	public void addState(String StateName)
	{
		// Add a state, if it does not already exist.

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
	
	 public void removeState(String StateName)
	{
		// Remove a state, if it exists.

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
	
	public boolean setState(String StateName)
	{
		// Set the current state, if it exists.

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
	
	public String getState()
	{
		// Get the current state.

		return CurrentState;
	}
}
