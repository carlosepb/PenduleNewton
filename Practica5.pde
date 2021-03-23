import gifAnimation.*;
boolean up, down, left, right, space;
float moveX, moveY;
PImage ballTexture, woodTexture;
PShape ball, stickX, stickY, stickZ;
float ang, moveDer, moveIzq, inc;
float[] moveRand;
boolean side;
float a = 0;
int cam=0, col=3;
//GifMaker fileGIF;

void setup()
{ 
  size(1400, 800, P3D);
  ballTexture =loadImage("images/silver.JPG");
  woodTexture =loadImage("images/wood.JPG");
  fill(255);
  stroke(0);
  
  camera();
  
  side=true;
  moveDer=80;
  moveIzq=-80;
  inc=10;
  moveRand = new float[3];
  
  beginShape();  
  ball = createShape(SPHERE, 20);
  ball.setStroke(255);
  ball.setTexture(ballTexture);
  
  stickX = createShape(BOX, 360,5,5);
  stickX.setStroke(255);
  stickX.setTexture(woodTexture);
  
  stickY = createShape(BOX, 5,200,5);
  stickY.setStroke(255);
  stickY.setTexture(woodTexture);
  
  stickZ = createShape(BOX, 5,5,200);
  stickZ.setStroke(255);
  stickZ.setTexture(woodTexture);
  endShape();
  
  //fileGIF= new GifMaker(this,"animation.gif");
  //fileGIF.setRepeat(0);
}

void draw(){
  
  background(255);
  
  if(up==true) {
    if(moveY>360){
      moveY=0;
    }else{
      moveY++;
    }
  }
  if(down==true){
    if(moveY<0){
      moveY=360;
    }else{
      moveY--;
    }
  }
  if(left==true) {
    if(moveX>360){
      moveX=0;
    }else{
      moveX++;
    }
  } 
  if(right==true) {
    if(moveX<0){
      moveX=360;
    }else{
      moveX--;
    }
  }
  
  if(space){
  
    if(a<600){
      a+=2;
    }else{
      if(cam==2){
        cam=0;
      }else{
        cam++;
      }
      a=-600;
    }
  
    switch(cam){
      case 0:
      camera(width/2.0+a, height/2.0, +700, width/2.0, height/2.0, 0, 0, 1, 0);
      break;
      case 1:
      camera(width/2.0, height/2.0, +700-a, width/2.0, height/2.0, 0, 0, 1, 0);
      break;
      case 2:
      camera(width/2.0, height/2.0+a, +700, width/2.0, height/2.0, 0, 0, 1, 0);
      break;
    }  
  }else{
    pushMatrix();
    fill(0);
    textSize(15);
    text("Flechas dirección -> Rotar el péndulo\nClic ratón -> Cambiar color luz\nEspacio -> Activar o desactivar movimiento cámara\nTecla r -> Resetear controles\nTecla e -> Cerrar aplicación", 50, 50);
    popMatrix();
  }
    
  switch(col){
   case 0:
   ambientLight(255, 0, 0) ;
   break;
   case 1:
   ambientLight(0, 255, 0) ;
   break;
   case 2:
   ambientLight(0, 0, 255) ;
   break;
   case 3:
   lights();
   break;
  }
 
  translate(width/2, height/2, 0);
  rotateX(radians(moveY));
  rotateY(radians(moveX));
  
  pushMatrix();
  translate(0,-150, 100);
  shape(stickX);
  translate(-177.5,100,0);
  shape(stickY);
  translate(0,97.5,-100);
  shape(stickZ);
  translate(355,-97.5, 100);
  shape(stickY);
  translate(0,97.5,-100);
  shape(stickZ);
  popMatrix();
  
  pushMatrix();
  translate(0,-150, -100);
  shape(stickX);
  translate(-177.5,100,0);
  shape(stickY);
  translate(355,0, 0);
  shape(stickY);
  popMatrix();
  
  pushMatrix();
  line(-80,-150,-100,moveIzq,0,0);
  line(-80,-150,100,moveIzq,0,0);
  translate(moveIzq, 0, 0);
  rotateY(radians(ang));
  shape(ball);
  popMatrix();
  
  for(int i=-40,e=0; i<=40; i+=40,e++){
    
    pushMatrix();
    translate(i+moveRand[e], 0, 0);
    line(-moveRand[e],-150,-100,0,0,0);
    line(-moveRand[e],-150,100,0,0,0);
    shape(ball);
    popMatrix();
  }
  
  pushMatrix();
  line(80,-150,-100,moveDer,0,0);
  line(80,-150,100,moveDer,0,0);
  translate(moveDer, 0, 0);
  rotateY(radians(ang));
  shape(ball);
  popMatrix();
  
   moveBall();
   //fileGIF.addFrame();
}

void keyPressed()
{
  if (keyCode == UP)
  {
    up = true;
  }
  if (keyCode == DOWN)
  {
    down = true;
  }
  if (keyCode == LEFT)
  {
    left=true;
  }
  if (keyCode == RIGHT)
  {
    right=true;
  }
}

void keyReleased()
{
  if (keyCode == UP)
  {
    up = false;
  }
  if (keyCode==DOWN)
  {
    down = false;
  }
  if (keyCode == LEFT)
  {
    left=false;
  }
  if (keyCode == RIGHT)
  {
    right=false;
  }
  if (key == ' ')
  {
    space=!space;
  }
  if (key == 'e' || key=='E')
  {
    exit();
  }
  if (key == 'r' || key == 'R')
  {
    space=true;
    col=3;
    cam=0;
    moveY=0;
    moveX=0;
    a=0;
  }
  /*if(key == 'g' || key == 'G'){
    fileGIF.finish();
  }*/
}


void mouseReleased(){
  if(col==3){
    col=0;
  }else{
    col++; 
  }
}

void moveBall()
{
  if(side)
  {
    if(moveDer>130){
      inc*=-1;
      moveDer+=inc;
    }else if(moveDer<80){
      moveDer=80;
      for(int i=0;i<moveRand.length;i++)
      {
         moveRand[i]=random(-4,0);
      }     
      side=!side;
    }else{
      moveDer+=inc;
    }
  }else{
    if(moveIzq<-130){
      inc*=-1;
      moveIzq+=inc;
    }else if(moveIzq>-80){
      moveIzq=-80;
      for(int i=0;i<moveRand.length;i++)
      {
         moveRand[i]=random(0,4);
      } 
      side=!side;
    }else{
      moveIzq+=inc;
    }
  } 
}
