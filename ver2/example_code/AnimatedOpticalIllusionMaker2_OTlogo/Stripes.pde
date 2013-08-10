public class Stripes {
    public int w = 100;    //total width of stripes
    public int h = 100;    //total height of stripes
    public int blackWidth = 10;    //width of each black stripe
    public int gapWidth = 1;       //width of each gap
    
    private float panX = 0;
    private float panSpeed = 1;
    private int panDirection = -1;

    
    public Stripes(int w, int h, int blackWidth, int gapWidth, float panSpeed){
        this.w = w;
        this.h = h;
        this.blackWidth = blackWidth;
        this.gapWidth = gapWidth;
        this.panSpeed = panSpeed;
        
        panX = -w/4;
    }
    
    
    public void show(){
        noStroke();
        fill(0);
        
        pushMatrix();
        if(panSpeed == 0){
            translate(mouseX-w/2, 0);
        }else{
            translate(panX, 0);
        }
        //draw black stripe
        for(int i=0; i<w; i=i+blackWidth+gapWidth){
            rect(i, 0, blackWidth, h);
        }
        popMatrix();
        
        //update pan
        panX = panX + panDirection*panSpeed;
        if(panX<-w/2 || panX>0){
            panDirection = -panDirection;
        }
    }
}

