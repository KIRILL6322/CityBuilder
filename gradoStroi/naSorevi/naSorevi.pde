PImage karta[]=new PImage[2];
//0-sputnik, 1-google
PImage domik;
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
  domik=loadImage("domik.jpg");
  imageMode(CENTER);
  rectMode(CENTER);
  mn=new boolean[karta[1].width][karta[1].height];
  noStroke();
  razdelit();
  stavit();
}

void draw(){
  background(0);
  //image(karta[0], width*3/4, height/2,500,500);
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
      mn[i][k]=(r>=200 && g>=234 && b>=219);
      //fill(karta[1].get(i,k));
      //rect(i*1, k*1, 1,1);
    }  
  }
}

void risuet(){
  
  for(int i=0; i<karta[1].width; i++){
    for(int k=0; k<karta[1].height; k++){
      //float r=red(karta[1].get(i,k));
      //float g=green(karta[1].get(i,k));
      //float b=blue(karta[1].get(i,k));
      fill(karta[1].get(i,k));
      if(mn[i][k])fill(0,150,0);
      if(!mn[i][k]){
        pushMatrix();
        translate(i*1, k*1, 1);
        rect(0, 0, 1,1);
        popMatrix();
      }
      else rect(i*1, k*1, 1,1);
      
    }  
  }
  
  noFill();
  //fill(0,255,0);
  strokeWeight(3);
  stroke(0);
  
  rectMode(CORNER);
  int razm=200;
  for(int i=0; i<karta[1].width/razm; i++){
    for(int k=0; k<karta[1].height/razm; k++){
      rect(i*razm,k*razm,(i+1)*razm, (k+1)*razm);
    }
  }
  rectMode(CENTER);
  noStroke();
  
  for(int i=0; i<dom.size(); i++){
    dom.get(i).update();
  }
}

void stavit(){
  int razm=200;
  for( int k=0; k<karta[1].width/razm; k++){
    for( int l=0; l<karta[1].height/razm; l++){
  //for(int i=0; i<1; i++){
    //dom.add(new classDoma(int(random(k*100, k*100+100)), int(random(l*100,l*100+100))));
    //while(!dom.get(i).mogno){
      //dom.remove(i);
      dom.add(new classDoma(int(random(k*razm+30, (k+1)*razm-30)), int(random(l*razm+30, (l+1)*razm-30))));
      println(l);
    //}
  //}
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
    
    //println(mogno);
    
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
      dom.remove(this);
      x=-10000;
      y=-10000;
    }
  }
  
  void update(){
    fill(75);
    pushMatrix();
    translate(0,0,2);
    //image(domik,x,y, razmerX-10,razmerY-10);
    
    rect(x,y, razmerX-10,razmerY-10);
    popMatrix();
  }
}
