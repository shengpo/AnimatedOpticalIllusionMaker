public interface ImageSourceInterface {

    public void update();
    
    public void show();
    
    public void reset();
    
    public void previewAnimation();
    
    public PImage getNextFrame();
    
    public int getTotalIllusionFrame();
}
