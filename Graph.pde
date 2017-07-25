import processing.serial.*;
Serial serial;

String stringGyroX;
String stringGyroY;

String stringAccX;
String stringAccY;

String stringCompX;
String stringCompY;

String stringKalmanX;
String stringKalmanY;

final int minAngle = -180;
final int maxAngle = 180;

float[] gyroX = new float[800];
float[] gyroY = new float[800];

float[] accX = new float[800];
float[] accY = new float[800];

float[] compAngleX = new float[800];
float[] compAngleY = new float[800];

float[] kalAngleX = new float[800];
float[] kalAngleY = new float[800];

void setup() {
  size(800, 600);
  //println(Serial.list()); // Use this to print connected serial devices
  serial = new Serial(this, Serial.list()[3], 9600); // Set this to your serial port obtained using the line above
  serial.bufferUntil('\n'); // Buffer until line feed

  for (int i=0; i<800; i++) // center all variables
  { 
    gyroX[i] = 600/2;
    gyroY[i] = 600/2;
    accX[i] = 600/2;
    accY[i] = 600/2;
    compAngleX[i] = 600/2;
    compAngleY[i] = 600/2;
    kalAngleX[i] = 600/2;
    kalAngleY[i] = 600/2;
  }
}

void draw() 
{
  /* Draw Graph */
  background(255); // White
  for (int i = 0; i < 800; i++) 
    {
      stroke(200); // Grey
      line(i*10, 0, i*10, 600);
      line(0, i*10, 800, i*10);
    }

    stroke(0); // Black
    
  for (int i = 1; i <= 3; i++) 
    {
      line(0, 600/4*i, 800, 600/4*i); // Draw line, indicating -90 deg, 0 deg and 90 deg
    }
    
  /*Convert*/
  if (stringAccX != null) 
      {
        stringAccX = trim(stringAccX); 
        println(stringAccX);
        accX[accX.length - 1] = map(float(stringAccX), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        
        /* Draw acceleromter x-axis */
        noFill();
        stroke(0, 255, 0); // Green
        // Redraw everything
        for (int i = 0; i<accX.length-1; i++) 
          {
            line(i, accX[i], i+1, accX[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<accX.length;i++) 
          {
            accX[i-1] = accX[i];
          }
      }
      
  if (stringGyroX != null) 
      {
        stringGyroX = trim(stringGyroX); // Trim off any whitespace
        gyroX[gyroX.length - 1] = map(float(stringGyroX), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        
        /* Draw gyro x-axis */ 
        noFill();
        stroke(255, 255, 0); // Yellow
        
        // Redraw everything
        for (int i = 0; i<gyroX.length-1; i++) 
          {
            line(i, gyroX[i], i+1, gyroX[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<gyroX.length-1;i++) 
          {
            gyroX[i-1] = gyroX[i];
          }
      }
          
  if (stringCompX != null) 
      {
        stringCompX = trim(stringCompX); // Trim off any whitespace
        compAngleX[compAngleX.length - 1] = map(float(stringCompX), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        /* Draw complementary filter x-axis */
        noFill();
        stroke(0, 0, 255); // Blue
        // Redraw everything
        for (int i = 0; i<compAngleX.length-1; i++) 
          {
            line(i, compAngleX[i], i+1, compAngleX[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<compAngleX.length; i++) 
          {
            compAngleX[i-1] = compAngleX[i];
          } 
      }
      
  if (stringKalmanX != null) 
      {
        stringKalmanX = trim(stringKalmanX); // Trim off any whitespace
        kalAngleX[kalAngleX.length - 1] = map(float(stringKalmanX), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        /* Draw kalman filter x-axis */
        noFill();
        stroke(255, 0, 0);// Red
        // Redraw everything
        for (int i = 0; i<kalAngleX.length-1; i++) 
          {
            line(i, kalAngleX[i], i+1, kalAngleX[i+1]);
          }

       // Put all data one array back
       for (int i = 1; i<kalAngleX.length; i++)
         {
           kalAngleX[i-1] = kalAngleX[i];
         }
      }
  if (stringAccY != null) 
      {
        stringAccY = trim(stringAccY); // Trim off any whitespace
        accY[accY.length - 1] = map(float(stringAccY), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        
        /* Draw acceleromter y-axis */
        noFill();
        stroke(0, 255, 255); // Light blue
        // Redraw everything
        for (int i = 0; i<accY.length-1; i++) 
          {
            line(i, accY[i], i+1, accY[i+1]);
          }
          
        // Put all data one array back
        for (int i = 1; i<accY.length;i++) 
          {
            accY[i-1] = accY[i];
          }    
      }

  if (stringGyroY != null) 
      {
        stringGyroY = trim(stringGyroY); // Trim off any whitespace
        gyroY[gyroY.length - 1] = map(float(stringGyroY), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        
        /* Draw gyro y-axis */
        noFill();
        stroke(255, 0, 255); // Purple
        // Redraw everything
        for (int i = 0; i<gyroY.length-1; i++) 
          {
            line(i, gyroY[i], i+1, gyroY[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<gyroY.length;i++) 
          {
             gyroY[i-1] = gyroY[i];
          }
      }
      
  if (stringCompY != null)
      {
        stringCompY = trim(stringCompY); // Trim off any whitespace
        compAngleY[compAngleY.length - 1] = map(float(stringCompY), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        /* Draw complementary filter y-axis */
        noFill();
        stroke(124, 252, 0); // Lawn Green
        // Redraw everything
       
        for (int i = 0; i<compAngleY.length-1; i++) 
          {
            line(i, compAngleY[i], i+1, compAngleY[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<compAngleY.length;i++) 
          {
            compAngleY[i-1] = compAngleY[i];
          }
      }
      
  if (stringKalmanY != null) 
      {
        stringKalmanY = trim(stringKalmanY); // Trim off any whitespace
        kalAngleY[kalAngleY.length - 1] = map(float(stringKalmanY), minAngle, maxAngle, 0, 600); // Convert to a float and map to the screen height, then save in buffer
        /* Draw kalman filter y-axis */
        noFill();
        stroke(0, 0, 0); // Black
        // Redraw everything
        for (int i = 0; i<kalAngleY.length-1; i++) 
          {
            line(i, kalAngleY[i], i+1, kalAngleY[i+1]);
          }

        // Put all data one array back
        for (int i = 1; i<kalAngleY.length;i++) 
          {
            kalAngleY[i-1] = kalAngleY[i];
          }
      }
}

void serialEvent (Serial serial)  // Get the ASCII strings:
{
  stringAccX = serial.readStringUntil('\t');
   
  stringGyroX = serial.readStringUntil('\t');
    
  stringCompX = serial.readStringUntil('\t');
    
  stringKalmanX = serial.readStringUntil('\t');
      
  serial.readStringUntil('\t'); // Ignore extra tab

  stringAccY = serial.readStringUntil('\t');
  
  stringGyroY = serial.readStringUntil('\t');
    
  stringCompY = serial.readStringUntil('\t');
    
  stringKalmanY = serial.readStringUntil('\t');
    
  serial.clear(); // Clear buffer
  
  //printAxis(); // Used for debugging
  
}

void printAxis() 
{
  print(stringGyroX);
  print(stringAccX);
  print(stringCompX);
  print(stringKalmanX);

  print('\t');

  print(stringGyroY);
  print(stringAccY);
  print(stringCompY);
  print(stringKalmanY);

  println();
}
