
class PacketSend
{
	int PowerOn;
	int SensA;
	int SensB;
	int NumDataPoints;
	int SampleRate;
	int FnType;
	int FnFreq;
	int DigType;
	int DigFreq;
	int TrigType;
	int TrigLevel;

	PacketSend()
	{
		// Run through the UI elements to get the required values to construct packet.
		PowerOn = iPowerOn;
		SensA = iSensA;
		SensB = iSensB;
		NumDataPoints = iNumDataPoints;
		SampleRate = iSampleRate;
		FnType = iFnType;
		FnFreq = iFnFreq;
		DigType = iDigType;
		DigFreq = iDigFreq;
		TrigType = iTrigType;
		TrigLevel = iTrigLevel;
	}
}

class PacketRecRaw
{
	PacketRecRaw()
	{

	}
}

class PacketRecParsed
{
	PacketRecParsed()
	{

	}
}