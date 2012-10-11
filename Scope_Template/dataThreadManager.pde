
void setDataThread(int frequency)
{
	dataThread.quit();
	dataThread = new SimpleThread(this, "dataThread", 1000/frequency, 0, "dataThreadMain");
	dataThread.start();
}

byte[] constructPacket()
{
	// Run through UI elements to construct and return a packet.
	byte[] packet = new byte[100];

}

void dataThreadMain()
{
	// Construct packet
	constructingPacket = true;
	byte[] packet_send = constructPacket();
	constructingPacket = false;

	// Ask for data
	pic.write(packet_send);

	// Wait for response
	byte[] packet_rec = new byte[64];
	pic.read(packet_rec);

	// Copy over data
	System.arraycopy( packet_rec, 0, packetRaw, 0, packet_rec.length );

	// Set data ready flag
	rawDataReady = true;
}
