import processing.serial.*;
import processing.sound.*;

//Serial port
Serial myPort;

//Image to load
PImage img; 

//Sound file objects
SoundFile crashFile, highHatFile, rideFile, snareFile, highTomFile, midTomFile, lowTomFile, bassFile, silenceFile;

//          W,   H,   r
//Crash   - 280, 177, 280-165
//HH      - 150, 379, 150-34
//Snare   - 339, 429, 427-339
//HTom    - 440, 211, 537-440
//MTom    - 664, 211, 664-566
//LTom    - 790, 418, 790-678
//Ride    - 887, 205, 887-757
//Bass    - 720-385, 473-421
int limit = 3;

public class instrument{
    public float x, y, h, w;
    public int mapping, limit;
    public SoundFile noise;
    
    instrument (float xPos, float yPos, float hLength, float wLength, int map, int lim, SoundFile sound){
      this.x = xPos;
      this.y = yPos;
      this.h = hLength;
      this.w = wLength;
      this.mapping = map;
      this.limit = lim;
      this.noise = sound;
    }
    //Overloaded for symmetric height and width
    instrument (float xPos, float yPos, float wLength, int map, int lim, SoundFile sound){
      this.x = xPos;
      this.y = yPos;
      this.h = wLength;
      this.w = wLength;
      this.mapping = map;
      this.limit = lim;
      this.noise = sound;
    } 
    
    void hitDrum(){
      ellipse(this.x, this.y, 2 * this.w, 2 * this.h);
      this.noise.play();
    }
}

instrument crash, highHat, ride, snare, highTom, midTom, lowTom, bass;

void setup() {
  //Setup screen image
  size(1046, 586);
  background(0);
  
  //Setting up serial comms
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
 
  // Load the backgroun image into the program  
  img = loadImage("drumkit-empty.png");  
  
  //Loading sound files
  crashFile = new SoundFile(this, "Cym_Crash1.wav");
  highHatFile = new SoundFile(this, "HH_808_cl.wav");
  rideFile = new SoundFile(this, "Ride_Proc1.wav");
  snareFile = new SoundFile(this, "Snare_808.wav");
  highTomFile = new SoundFile(this, "Tom_Acou_H.wav");
  midTomFile = new SoundFile(this, "Tom_Acou_M.wav");
  lowTomFile = new SoundFile(this, "Tom_Acou_L.wav");
  bassFile = new SoundFile(this, "Kick_Acou1.wav");
  silenceFile = new SoundFile(this, "Silent.wav");
  
  //Setting up Drum objects
  crash = new instrument(279, 174, 280-165, 2, limit, crashFile);
  highHat = new instrument(149, 375, 150-34, 1, limit, highHatFile);
  snare = new instrument(338, 428, 427-339, 8, limit, snareFile);
  highTom = new instrument(439, 211, 537-440, 16, limit, highTomFile);
  midTom = new instrument(664, 211, 664-566, 32, limit, midTomFile);
  lowTom = new instrument(791, 417, 794-678, 64, limit, lowTomFile);
  ride = new instrument(886, 203, 887-757, 4, limit, rideFile);
  bass = new instrument(552, 447, (473-421) / 2, (710-410) / 2, 128, 20, bassFile);
   
  //Don't want borders
  noStroke();
  //Colour Red
  fill(0, 0, 0, 150);
  
  
  //display image
  image(img, 0, 0);
  delay(1500);
}

int counter = 0;
int inByte;
instrument kit[] = {highHat, crash, ride, snare, highTom, midTom, lowTom, bass};

void draw() {
  if(counter++ > 50){
    //display image
    image(img, 0, 0);
  }
  
  
  inByte = 0;
  
   while (myPort.available() > 0) {
    inByte = myPort.read();
    println(inByte);
  }
  
  
  if((inByte & highHat.mapping) == 1 && highHat.limit++ >= limit){

    highHat.hitDrum();
    highHat.limit = 0;
  }
  if((inByte & crash.mapping) == 2 && crash.limit++ >= limit){
    crash.hitDrum();
    crash.limit = 0;
  }
  if((inByte & ride.mapping) == 4 && ride.limit++ >= limit){
    ride.hitDrum();
    ride.limit = 0;
  }
  if((inByte & snare.mapping) == 8 && snare.limit++ >= limit){
    snare.hitDrum();
    snare.limit = 0;
  }
  if((inByte & highTom.mapping) == 16 && highTom.limit++ >= limit){
    highTom.hitDrum();
    highTom.limit = 0;
  }
  if((inByte & midTom.mapping) == 32 && midTom.limit++ >= limit){
    midTom.hitDrum();
    midTom.limit = 0;
  }
  if((inByte & lowTom.mapping) == 64 && lowTom.limit++ >= limit){
    lowTom.hitDrum();
    lowTom.limit = 0;
  }
  if((inByte & bass.mapping) == 128 && bass.limit++ >= limit){
    bass.hitDrum();
    bass.limit = 0;
  }  
}
