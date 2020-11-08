# Interactive-Drumkit

I created a projected image of a drum kit on my wall.<br/>
I made it interactable using copper tape-capacitive touch sensors, taped to the wall and read by an Arduino Uno. <br/>
The Arduino communicates with a Processing sketch, which plays the sounds and animates the projected image.<br/>

## Setup:
First I (artfully) covered my wall in copper tape.
![copper wall](https://github.com/SenanS/Interactive-Drumkit/blob/main/Media/Wall-Coppered.jpeg)
Then made wire connectors to the capacitive touch sensors.
![copper wires](https://github.com/SenanS/Interactive-Drumkit/blob/main/Media/Making-Wires.jpg)
## Arduino Code:
The Arduino code simply reads the digital capactitive touch sensors and transfers the data, via serial protocol, to the processing sketch.
![Arduino Prototype](https://github.com/SenanS/Interactive-Drumkit/blob/main/Media/Circuit%20Setup.jpg)
## Processing Sketch:
The processing sketch loads the <code>/Media/drumkit-empty.png</code> image into the background. <br/>
When it is sent a serial message that a drum has been hit it illuminates that drum in the output and plays a sample sound.<br/>
## Demo
<em>Click for sound (Youtube)</em><br/>
[![Drum Kit working video](https://github.com/SenanS/Interactive-Drumkit/blob/main/Media/DrumKit.gif)](https://www.youtube.com/watch?v=8VHfrf0_ESo)
