public class Stripes {
    private int w = 100;    //total width of stripes
    private int h = 100;    //total height of stripes
    private int blackWidth = 10;    //width of each black stripe
    private int gapWidth = 1;       //width of each gap
    
    private float panX = 0;
    private float panSpeed = 1;
    private int panDirection = -1;

    
    public Stripes(int w, int h, int blackWidth, int gapWidth, float panSpeed){
        this.w = w;
        this.h = h;
        this.blackWidth = blackWidth;
        this.gapWidth = gapWidth;
        this.panSpeed = panSpeed;
    }
    
    
    public void show(){
        noStroke();
        fill(0);
        
        pushMatrix();
        if(panSpeed <= 0){
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
        if(panX<-w/2 && panDirection==-1){
            panDirection = 1;
        }else if(panX>0 && panDirection==1){
            panDirection = -1;
        }
    }
    
    public PImage getIllusionImage(ImageSource source){
        int maxFrameNumber = source.getTotalIllusionFrame();
        PGraphics pg = createGraphics(width, height);

        pg.beginDraw();
        pg.background(255);

        for(int c=0; c<maxFrameNumber; c++){
            background(255);
            PImage next = source.getNextFrame();

            //get the image in the gap
            for(int i=blackWidth+c*gapWidth; i<width; i=i+gapWidth+blackWidth){
                PImage gapImage = next.get(i, 0, gapWidth, h);
                parseGapLine(pg, gapImage, i, 0);
            }
        }        

        pg.endDraw();
        
        return pg;
    }
    
    
    public void makeIllusionStripesPDF(ImageSource source, String filePath, String fileName){
        //make stripes PDF file
        PGraphics pg = createGraphics(w, h, PDF, completePath(filePath)+noExt(fileName)+"_stripes.pdf");

        pg.beginDraw();
        pg.background(255);
        pg.noStroke();
        pg.fill(0);

        for(int i=0; i<w; i=i+blackWidth+gapWidth){
            pg.rect(i, 0, blackWidth, h);
        }

        pg.dispose();
        pg.endDraw();

        
        //make optical illusion PDF file
        int maxFrameNumber = source.getTotalIllusionFrame();
        pg = createGraphics(width, height, PDF, completePath(filePath)+noExt(fileName)+"_illusion.pdf");

        pg.beginDraw();
        pg.background(255);

        for(int c=0; c<maxFrameNumber; c++){
            background(255);
            PImage next = source.getNextFrame();

            //get the image in the gap
            for(int i=blackWidth+c*gapWidth; i<width; i=i+gapWidth+blackWidth){
                PImage gapImage = next.get(i, 0, gapWidth, h);
                parseGapLine(pg, gapImage, i, 0);
            }
        }        

        pg.dispose();
        pg.endDraw();
    }
    
    
    private void parseGapLine(PGraphics pg, PImage gapImage, int x, int y){
        int y1 = -1;
        int y2 = -1;
        boolean enter = false;
        boolean leave = false;
        
        for(int i=0; i<gapWidth; i++){
            for(int j=0; j<h; j++){
                if(enter==false && leave==false && gapImage.get(i, j)==color(0)){
                    y1 = j;
                    enter = true;
                }else if(enter==true && leave==false && gapImage.get(i, j)==color(255)){
                    y2 = j-1;
                    enter = false;
                    leave = true;
                }else if(enter==true && leave==false && j==h-1){
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
    
    
    private String completePath(String path){
        if(path.lastIndexOf("/") == path.length()-1){
            return path;
        }else{
            path = path+"/";
            return path;
        }
    }
    
    
    private String noExt(String fileName){
        if(fileName.lastIndexOf(".") == 0){
            fileName = "sample";
        }else if(fileName.lastIndexOf(".") > 0){
            fileName = fileName.substring(0, fileName.lastIndexOf("."));
        }
        
        return fileName;
    }
}

