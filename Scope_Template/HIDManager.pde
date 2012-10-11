public final boolean DEBUG = true;

import com.codeminders.hidapi.*;

// HID manager and device
HIDManager mgr;
HIDDeviceInfo[] devs;
HIDDevice pic;
String picPath = "";

// openPic takes in the desired productID of the pic you wish to open
void openPic(int picNo)
{
  ClassPathLibraryLoader.loadNativeHIDLibrary();
  
  // Create instances of HIDManager, and USBListener
  try {
    mgr = HIDManager.getInstance();
  } 
 catch (Exception e) {
    e.printStackTrace();
    if (DEBUG)println("Failed to create HIDManager");
  }

  println("Attempting to Connect to PIC #"+picNo+"...");
  try {
    // Dump a list of all connected HID devices into devs
    devs = mgr.listDevices();
  } 
  catch (Exception e) {
    e.printStackTrace();
    if (DEBUG)println("Cannot List Devices");
  }

  if (DEBUG)println("Devices:\n");

  // Loop through devices
  for (int i=0;i<devs.length;i++)
  {
    if (DEBUG)
    {
      println(""+i+".\t"+devs[i]);
      println("---------------------------------------------\n");
    }

    // If this is our PIC Microcontroller
    try {
      if (devs[i].getProduct_id() == picNo &&
        devs[i].getVendor_id() == 1240)
      {     
        pic = devs[i].open();
        if (pic!=null) {
          pic.enableBlocking();
          println("Opened "+pic.getProductString());
        }
      }
    } 
    catch (Exception e) {
      e.printStackTrace();
      if (DEBUG)println("Can't open PIC");
    }
  }   
}

