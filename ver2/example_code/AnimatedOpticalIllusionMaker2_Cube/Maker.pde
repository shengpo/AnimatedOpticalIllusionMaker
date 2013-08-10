public class Maker {
    private Stripes stripes = null;

    private PImage illusionImage = null;
    private int illusionFrameCount = 6;
    private int c = 0;    //for counter
    
    private PGraphics pg = null;            //for preview of illusion image
    private PGraphics stripesPDF = null;    //for pdf output of stripes
    private PGraphics illusionPDF = null;   //for pdf output of illusion image
    private boolean isCreateGraphics = false;

    private boolean isMakeIllusion = false;
    private boolean isShowIllusion = false;
    private boolean isShowStripes = false;
    
    
    
    public Maker(int stripeBlackWidth, int stripeGapWidth, float stripePanSpeed){
        this(width*2, height, stripeBlackWidth, stripeGapWidth, stripePanSpeed);
    }

    public Maker(int coverWidth, int coverHeight, int stripeBlackWidth, int stripeGapWidth, float stripePanSpeed){
        stripes = new Stripes(coverWidth, coverHeight, stripeBlackWidth, stripeGapWidth, stripePanSpeed);
    }

        
    
    public void process(){
        if(isMakeIllusion){
            makeIllusionImage();
        }
        
        if(isShowIllusion && illusionImage!=null){
            background(255);
            image(illusionImage, 0, 0);
        }
        
        if(isShowStripes){
            stripes.show();
        }
    }
    
    
    
    public void setIllusionFrameCount(int illusionFrameCount){
        this.illusionFrameCount = illusionFrameCount;
    }
    

    public void doIllusion(){
        c = 0;
        
        isCreateGraphics = false;
        isMakeIllusion = true;
        isShowIllusion = false;
        isShowStripes = false;
    }
    
    public void toggleIllsuion(){
        isShowIllusion = !isShowIllusion;
    }

    public void toggleStripes(){
        isShowStripes = !isShowStripes;
    }
    
    
    private void makeIllusionImage(){
        if(!isCreateGraphics){
            //make preview of illusion image
            pg = createGraphics(width, height);
            pg.beginDraw();
            pg.background(255);
            pg.endDraw();
            
            //make stripes PDF file
            stripesPDF = createGraphics(stripes.w, stripes.h, PDF, sketchPath("pdf/stripes.pdf"));
            stripesPDF.beginDraw();
            stripesPDF.background(255);
            stripesPDF.noStroke();
            stripesPDF.fill(0);
            for(int i=0; i<stripes.w; i=i+stripes.blackWidth+stripes.gapWidth){
                stripesPDF.rect(i, 0, stripes.blackWidth, stripes.h);
            }
            stripesPDF.dispose();
            stripesPDF.endDraw();

            //make optical illusion PDF file
            illusionPDF = createGraphics(width, height, PDF, sketchPath("pdf/illusion.pdf"));
            illusionPDF.beginDraw();
            illusionPDF.background(255);
            illusionPDF.endDraw();
    
            isCreateGraphics = true;
        }

        if(c < illusionFrameCount){
            PImage next = get();

            /***make preview of illusion image***/
            pg.beginDraw();
            //get the image in the gap
            for(int i=stripes.blackWidth+c*stripes.gapWidth; i<width; i=i+stripes.gapWidth+stripes.blackWidth){
                PImage gapImage = next.get(i, 0, stripes.gapWidth, stripes.h);
                parseGapLine(pg, gapImage, i, 0);
            }
            pg.endDraw();
            
            /***make optical illusion PDF file***/
            illusionPDF.beginDraw();
            //get the image in the gap
            for(int i=stripes.blackWidth+c*stripes.gapWidth; i<width; i=i+stripes.gapWidth+stripes.blackWidth){
                PImage gapImage = next.get(i, 0, stripes.gapWidth, stripes.h);
                parseGapLine(illusionPDF, gapImage, i, 0);
            }
            if(c == illusionFrameCount-1){
                illusionPDF.dispose();    //call dispose() at final frame
            }
            illusionPDF.endDraw();

            c = c + 1;
        }else{
            illusionImage = pg;
            isMakeIllusion = false;
            isShowIllusion = true;
        }
    }


    private void parseGapLine(PGraphics pg, PImage gapImage, int x, int y){
        int y1 = -1;
        int y2 = -1;
        boolean enter = false;
        boolean leave = false;
        
        for(int i=0; i<stripes.gapWidth; i++){
            for(int j=0; j<stripes.h; j++){
                if(enter==false && leave==false && gapImage.get(i, j)==color(0)){
                    y1 = j;
                    enter = true;
                }else if(enter==true && leave==false && gapImage.get(i, j)==color(255)){
                    y2 = j-1;
                    enter = false;
                    leave = true;
                }else if(enter==true && leave==false && j==stripes.h-1){
                    y2 = j;
                    enter = false;
                    leave = true;
                }
                
                if(enter==false && leave==true){
                    pg.stroke(0);
                    pg.line(x+i, y+y1, x+i, y+y2);
                    
                    y1 = -1;
                    y2 = -1;
                    leave = false;
                }
            }
        }
    }
}
