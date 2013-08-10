/*
操作說明：
1. 自行更改ImageSource class，以符合自己想要的動畫效果
2. new Stripes物件的時候, 調整blackWidth, gapWidth, panSpeed這三個參數可能會影響輸出及動畫效果, 需自行使用不同參數值測試
3. 按p是預覽原始動畫效果
   按s是使用柵欄(stripes)
   按空白鍵是產生optical illusion圖案
   按i是秀出所產生optical illusion圖案 (需先按空白鍵產生optical illusion圖案)
4. 按v是產生optical illusion圖案的PDF檔，以及柵欄(stripes)的PDF檔。以方便做print out。

demo video : http://youtu.be/ebApHDtSxqM


 Author: Shen, Sheng-Po (http://shengpo.github.io)
 Test Environment: Processing 2.0.1
 Date:   2013.07.15
 License: CC BY-SA 3.0
*/


import processing.pdf.*;


ImageSource source = null;
Stripes stripes = null;

PImage illusionImage = null;


boolean isShowPreviewAnimation = true;
boolean isShowIllusion = false;
boolean isShowStripes = false;



void setup(){
    size(400, 400);
    
    source = new ImageSource(loadImage("ot-logo2.png"));
    stripes = new Stripes(width*2, height, 6, 1, 0.2);    //auto-moving stripes
//    stripes = new Stripes(width*2, height, 6, 1, 0);    //move stripes by mouse
}

void draw(){
    background(255);
    
    if(isShowPreviewAnimation){
        source.previewAnimation();
    }
    
    if(isShowIllusion){
        if(illusionImage != null){
            image(illusionImage, 0, 0);
        }else{
        //    println("no Optical Illusion Image, please make it first!");
        }
    }
    
    if(isShowStripes){
        stripes.show();
    }
}


void keyPressed(){
    if(key == 'p'){
        isShowPreviewAnimation = !isShowPreviewAnimation;
        isShowIllusion = false;
        
        println("Preview Original Animation");
    }

    if(key == 'i'){
        isShowIllusion = !isShowIllusion;
        isShowPreviewAnimation = false;
        
        println("Show Optical Illusion Image");
    }
    
    if(key == 's'){
        isShowStripes = !isShowStripes;
        
        println("Show moving Stripes");
    }
    
    //make optical illusion image
    if(key == ' '){
        illusionImage = stripes.getIllusionImage(source);
        
        println("Optical Illusion Image produced !!");
    }
    
    //make PDF file for printing out
    if(key == 'v'){
        stripes.makeIllusionStripesPDF(source, sketchPath("pdf"), "sample");
        
        println("PDF files of Optical Illusion Image and Stripes Image are produced !!");
    }
}


