/*
柵欄(stripes)設定要領：
- 柵欄寬度(stripeBlackWidth) 不要過大，太大不好看。
- 柵欄間隔(stripeGapWidth) 跟柵欄寬度不要相差太多，相差太多會造成illusion效果不好。
tips of setting stripes:
- let the `stripeBlackWidth` in suitable value, not too much. big value makes bad look.
- let the difference of `stripeBlackWidth` and `stripeGapWidth` in suitable value. big difference makes bad effect of illusion.


Animation製作要領：
- 盡量在很少的影格中完成想要的動畫，這樣效果較好
- 動畫的影格數最好跟illusionFrameCount一樣
tips of making animation:
- less frames of animation can produce better effect
- it is better to make the total count of frames is the same with `illusionFrameCount`


操作說明：
- 按s是開啟/關閉柵欄(stripes)
- 按空白鍵是產生預覽的optical illusion圖案, 以及optical illusion圖案的PDF檔，以及柵欄(stripes)的PDF檔 (位於pdf資料夾下)
- 按i是開啟/關閉所產生的optical illusion圖案 (需先按空白鍵產生optical illusion圖案)
description of operation for this sketch:
- press s : to switch on/off stripes
- press SPACE : to produce optical illusion image for preview, and also produce the PDF files of optical illusion image and stripes (under directory named "pdf") 
- press i : to switch on/off optical illusion image for preview (need to press SPACE first to produce optical illusion image)


demo video : http://youtu.be/sfQP6yzejXs


 Author: Shen, Sheng-Po (http://shengpo.github.io)
 Test Environment: Processing 2.0.1
 Date:   2013.08.08
 License: CC BY-SA 3.0
*/


import processing.pdf.*;


//use Maker object to make animated optical illusion
Maker maker = null;
int stripeBlackWidth = 6;                        //change this value by your need
int stripeGapWidth = 1;                          //change this value by your need
float stripePanSpeed = stripeGapWidth*0.15;      //this is a recommended value, but you still can change this value by your need
//float stripePanSpeed = 0;                                  //if this is 0, then you can move stripes by mouse
int illusionFrameCount = stripeBlackWidth/stripeGapWidth;    //this is a recommended value, you can set any value you like


//maybe you need some variables for your animation here
//...


void setup(){
    size(400, 400, P3D);
//    size(640, 360);

    /*
        parameters of Maker(): int stripeBlackWidth, int stripeGapWidth, float stripePanSpeed
        if the third parameter == 0, you can move the stripes by mouse.
        if the third parameter != 0, the stripes will move automatically

        parameter of Maker.setIllusionFrameCount(): int illusionFrameCount; 
        to set how many animation frames to be used for creating final illusion image 
    */
    maker = new Maker(stripeBlackWidth, stripeGapWidth, stripePanSpeed);    
    maker.setIllusionFrameCount(illusionFrameCount);
//    maker.doIllusion();    //you can do illsuion-making at initial stage!!


    //setting your animation here ...
    //...
}

void draw(){
    //drawing your animation here...
    //...
    
    //must be called at end!
    maker.process();
}


void keyPressed(){
    if(key == 'i'){
        maker.toggleIllsuion();
    }
    
    if(key == 's'){
        maker.toggleStripes();
    }
    
    if(key == ' '){
        maker.doIllusion();    
    }
}

