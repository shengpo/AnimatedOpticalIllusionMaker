/*
this class must to implement <ImageSourceInterface>'s methods.
class ImageSource's constructor and methods can be implemented by your needs.

class ImageSource必須implements <ImageSourceInterface>
透過實作ImageSource這個class的建構式跟方法來呈現想要的動畫內容
*/

public class ImageSource implements ImageSourceInterface {
    private PImage img = null;    
    private float degree = 0;
    private float deltaDegree = 60;

    private int totalIllusionFrame = int(360/deltaDegree);

    private boolean isReset = false;

    
    public ImageSource(PImage img){
        this.img = img;
        img.resize(250, 250);
    }

    public void update(){
        degree = degree + deltaDegree;
    }
    
    public void show(){
        pushMatrix();
        translate(width/2, height/2);
        rotate(radians(degree));
//        fill(0);
//        rect(-100, -100, 200, 200);
        image(img, -img.width/2, -img.height/2);
        popMatrix();
    }
    
    public void reset(){
        degree = 0;
    }

    public void previewAnimation(){
        update();
        show();
    }
    
    public PImage getNextFrame(){
        if(isReset == false){
            reset();
            isReset = true;
        }
        
        previewAnimation();
        PImage tmp = get();

        return tmp;
    }
    
    public int getTotalIllusionFrame(){
        return totalIllusionFrame;
    }
}
