# Eldenring-stutter-fix
A way to diagnose and fix the double stutter that randomly occurs while playing Elden Ring.

### TLDR
Elden Ring has these random 1-2 sec stutters that happens in pairs. They are caused by a device being added or removed from your PC. In most cases this will be a smart TV that is on the same network as your PC. This script helps find out the device causing the problem. Solutions are mentioned in the solution section of readme.

# Problem
Massive 1-2 second stutters in Elden ring. This is not the same as traversal stutter or shader compilation stutters that are much shorter. The problem seems to be that Elden ring seems to process any and all device additions in the main rendering thread. Whenever a new device is added or the device connects, the renderer just freezes completely to process this. No other game does things this way.

To make the problem worse, the device doesnt need to be connected to your PC. Any device that can be discovered on your network will cause this. If you own a smart TV and it is connected to the same network, any time you turn on the TV or go the main menu of the smart TV to change the app, this causes the smart TV to be initialized as a "Digital Media Device". So somebody operating your TV will cause elden ring to freeze.

# Diagnosis
Run the script "which_device.ps1" by right clicking and selecting "run with Powershell" and play the game. Any time the big stutter occurs check the script window and it will show the culprit device.

  # Solution
  The fix depends on the type of device. I am guessing in most cases it will be a smart TV. First goto Control panel / Device manager in windows. Select "view" from menu bar and make sure "Show Hidden Devices" is checked.
  
  ### Smart TV or any other device on your network
  You can try removing the device under "Digital Media Device" but great windows will add it back when TV/device is turned on again. The only complete fix now seems to be to set your network to "public". This will make your PC non-discoverable to other devices. Click on your network in the notification or goto control panel/network and set the network to "public". This is the only way I have found to completely fix this stutter.
  
  ### USB device/HUB
  Certain faulty USB devices or hubs can disconnect/reconnect randomly. For this you will need to right click the device in device manager and disable or uninstall it.

Overall this feels like 25% windows fault for adding a device silently without the user asking for it and 75% Elden ring devs for processing every device addition in thier main render thread. Sadly neither will fix it.
