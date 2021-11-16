# Application development project

A cross platform mobile app for playing the game hangman, developed for the course INFT2501 (Application development for mobile units).


The application is developed with Flutter in Android Studio. Development has been done with an Android 11 AVD (Pixel API 30) and debug mode in  web browser (Edge & Chrome), with additional testing on a real Android phone (Samsung Galaxy S8 SM-G950F).

To test the application, Flutter must be installed (and added to Path).

The simplest way to test the application is to open it in debug mode in a web browser. This can be done using one of either commands in the project root directory:
```bash
flutter run -d edge
```
```bash
flutter run -d chrome
```
This will build the necessary project components to view the app in debug mode, and open it in your chosen browser. Then toggle device emulation in inspect mode to see the application as intended for a mobile device.

To open the application in an emulator, first make sure you have a compatible emulator installed (I used Android 11 AVD with Pixel API 30), open it and find its device it. You can usually do this in the emulator settings, or if you are using ADB (Android Debug Bridge), you can find the id of your device with the following command:
```bash
adb devices
```
This will list running emulators and other compatible devices that are available. Copy the device ID you wish to run the app on, nad use the following command to build and run:
```bash
flutter run -d <device id>
```
For example:
```bash
flutter run -d emulator-5554
```
This will build the app and run it on your selected device.

Alternatively, all this can be done with the run/debug interface in Android Studio.
