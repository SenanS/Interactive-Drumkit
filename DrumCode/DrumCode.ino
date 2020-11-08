#define highHat 5
#define crash   7
#define ride    9
#define snare   4
#define highTom 8
#define midTom  6
#define lowTom  2
#define bass    3

byte data = 0b10000000;

void setup() {
  Serial.begin(9600);
  pinMode(highHat,  INPUT);
  pinMode(crash,    INPUT);
  pinMode(ride,     INPUT);
  pinMode(snare,    INPUT);
  pinMode(highTom,  INPUT);
  pinMode(midTom,   INPUT);
  pinMode(lowTom,   INPUT);
  pinMode(bass,     INPUT);
}

void loop() {
  //Add each on or off signal to a bit, then send the byte
  bitWrite(data, 0, digitalRead(highHat));
  bitWrite(data, 1, digitalRead(crash));
  bitWrite(data, 2, digitalRead(ride));
  bitWrite(data, 3, digitalRead(snare));
  bitWrite(data, 4, digitalRead(highTom));
  bitWrite(data, 5, digitalRead(midTom));
  bitWrite(data, 6, digitalRead(lowTom));
  bitWrite(data, 7, digitalRead(bass));
  //Send the byte to the raspberry pi
  Serial.write(data);
}
