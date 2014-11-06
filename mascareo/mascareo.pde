
/*
This code imports everything from SimpleOpenNI library and declares 
a variable of the type SimpleOpenNI named context.
*/
import SimpleOpenNI.*; 
 
SimpleOpenNI  context; 
PImage img;
//...add more declarations here...
 
/* 
Sets the size of application window and creates a new SimpleOpenNI context, 
that can be used to communicate with the Kinect device.
*/
void setup(){
  //set size of the application window
  size(640, 480); 
 
  //initialize context variable
  context = new SimpleOpenNI(this); 
 
  //asks OpenNI to initialize and start receiving depth sensor's data
  context.enableDepth(); 
  
  //asks OpenNI to initialize and start receiving User data
  context.enableUser();//SimpleOpenNI.SKEL_PROFILE_ALL);
 
  //asks OpenNI to initialize and start receiving RGB sensor's data
  context.enableRGB(); 
 
  //align the depth sensor to RGB sensor
  context.alternativeViewPointDepthToImage();
 
   img=createImage(640,480,RGB);
  img.loadPixels();
 
 
  //... add more variable initialization code here...
}
 
/*
Clears the window, gets new data from Kinect and draw a depthmap to the 
window.
*/
void draw(){
  //clears the window with the black color, this is usually a good idea 
  //to avoid color artefacts from previous draw iterations
  background(0);
 
  //asks kinect to send new data
  context.update(); 
 
 //retrieves depth image
  PImage depthImage=context.depthImage();
  depthImage.loadPixels();
  
  //retrieves depth image
  PImage colorImage=context.rgbImage();
  colorImage.loadPixels();
   

 int[] upix=context.userMap();
 
//colorize users
for(int i=0; i < upix.length; i++){
  if(upix[i] > 0){
      //there is a user on that position
      //NOTE: if you need to distinguish between users, check the value of the upix[i]
      img.pixels[i]= colorImage.pixels[i]; //color(0,0,255);
    }//if 
    else{
      //add depth data to the image
     img.pixels[i]=color(255,255,255);//depthImage.pixels[i];
    }//else
  }//end for 
  img.updatePixels(); 
 
//draws the depth map data as an image to the screen
//at position 0(left),0(top) corner
  image(img,0,0);
 
}//end draw
 
