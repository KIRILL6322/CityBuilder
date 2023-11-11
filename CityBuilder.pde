PImage karta[]=new PImage[2];
//0-sputnik, 1-google
boolean mn[][];
ArrayList<classDoma> dom=new ArrayList<classDoma>();

float cameraZ=0;
void setup(){
  fullScreen(P3D);
  
  cameraZ=height-1080;
  beginCamera();
  camera();
  translate(0,0,cameraZ);
  endCamera();
  
  karta[0]=loadImage("1.png");
  karta[1]=loadImage("3.png");
  imageMode(CENTER);
  rectMode(CENTER);
  mn=new boolean[karta[1].width][karta[1].height];
  noStroke();
  razdelit();
  stavit();
}

void draw(){
  background(0);
  image(karta[0], width*3/4, height/2,500,500);
  //image(karta[1], width*3/4, height/2,500,500);
  
  risuet();
  if(mousePressed)stavit();
}

void razdelit(){
  for(int i=0; i<karta[1].width; i++){
    for(int k=0; k<karta[1].height; k++){
      float r=red(karta[1].get(i,k));
      float g=green(karta[1].get(i,k));
      float b=blue(karta[1].get(i,k));
      mn[i][k]=(r==233 && g==234 && b==237);
      //fill(karta[1].get(i,k));
      //rect(i*1, k*1, 1,1);
    }  
  }
}

void risuet(){
  for(int i=0; i<karta[1].width; i++){
    for(int k=0; k<karta[1].height; k++){
      fill(karta[1].get(i,k));
      rect(i*1, k*1, 1,1);
    }  
  }
  
  for(int i=0; i<dom.size(); i++){
    dom.get(i).update();
  }
}

void stavit(){
  
  
  for(int i=0; i<15; i++){
    dom.add(new classDoma(int(random(karta[1].width)), int(random(karta[1].height))));
    while(!dom.get(i).mogno){
      dom.remove(i);
      dom.add(new classDoma(int(random(karta[1].width)), int(random(karta[1].height))));
    }
  }
}

class classDoma{
  int x,y,razmerX, razmerY;
  boolean mogno=true;
  
  
  classDoma(int a,int b){
    razmerX=int(random(20,61));
    razmerY=int(random(20,61));
    int rx=int(razmerX/2);
    int ry=int(razmerY/2);
    if(a-rx>=0 && a+rx<karta[1].width && b-ry>=0 && b+ry<karta[1].height){
      for(int i=0;i<rx; i++){
        for(int k=0;k<ry; k++){
          if(!mn[a-i][b-k] || !mn[a+i][b+k] || !mn[a-i][b+k] || !mn[a+i][b-k])mogno=false;
          //println(!mn[a-i][b-k] || !mn[a+i][b+k] || !mn[a-i][b+k] || !mn[a+i][b-k]);
        }
      }
    }
    else mogno=false;
    
    println(mogno);
    
    if(mogno){
      x=a;
      y=b;
      for(int i=0;i<rx; i++){
        for(int k=0;k<ry; k++){
          mn[a-i][b-k]=false;
          mn[a+i][b+k]=false;
          mn[a-i][b+k]=false;
          mn[a+i][b-k]=false;
        }
      }
    }
    else {
      x=-10000;
      y=-10000;
    }
  }
  
  void update(){
    fill(255,255,0);
    rect(x,y, razmerX-10,razmerY-10);
  }
}
