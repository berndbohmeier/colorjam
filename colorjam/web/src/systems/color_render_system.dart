part of colorjam;

class ColorRenderSystem extends IntervalEntityProcessingSystem {
  
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<ColorComponent> colorMapper;
  
  
  bool globalVanishing = true;
  
  
  bool effectsOn = true;
  
  ColorRenderSystem({this.globalVanishing : true}) : super(16, Aspect.getAspectForAllOf([PositionComponent,SpriteComponent, ColorComponent]));
  
  List<List<num>> filterMatrixList = [
                    [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],
                    [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]];
  List<num> offset = [0,0,0,0]; 
  
  void initialize() {
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
   
  }
  
  
  void inserted(Entity entity){
    
    //Sprite sprite = spriteMapper.get(entity).sprite;
    
    
    //sprite.removeCache();
    //sprite.applyCache(-2, -2, sprite.width.round()+4, sprite.height.round()+4 ,debugBorder:false);
    
    
    
    
  }
  
  void removed(Entity entity){
  }
  
  void processEntity(Entity entity){
    SpriteComponent spr = spriteMapper.get(entity);
    
    
    
    ColorComponent color = colorMapper.get(entity);
    Entity player = (world.getManager(TagManager) as TagManager)
                        .getEntity(PlayerFactory.TAG_PLAYER);
    
      storeColorMatrix(filterMatrixList[0], color.nr,color.ng, color.nb, 255);
      
      if(spr.dbo.filters.isEmpty)
        spr.dbo.filters.add(new ColorMatrixFilter(filterMatrixList[0],offset));
      else
        spr.dbo.filters[0] = new ColorMatrixFilter(filterMatrixList[0],offset);
      
      if(player != null && globalVanishing){
        ColorComponent playerColor = colorMapper.get(player);
        
        int alpha = 255;
        if(color.alpha){
          alpha = math.max(math.max(math.min(playerColor.r, color.r),math.min(playerColor.g, color.g)),
              math.min(playerColor.b, color.b)).round();
        }else{
          alpha = 255;//math.max(playerColor.r, math.max(playerColor.g,playerColor.b)).round();
        }
        
        if(color.vanishing) {
          
          storeColorMatrix(filterMatrixList[1], playerColor.nr, playerColor.ng,
              playerColor.nb, alpha);
        }else{
          storeAlphaMatrixMatrix(filterMatrixList[1], alpha);
        }
        if(spr.dbo.filters.length < 2)
          spr.dbo.filters.add(new ColorMatrixFilter(filterMatrixList[1],offset));
        else
          spr.dbo.filters[1] = new ColorMatrixFilter(filterMatrixList[1],offset);
      
      
      
      
      }
      
      
      
      
      
     

    //spr.sprite.refreshCache();
    
  }
  
  List<num> storeColorMatrix(List<num> matrix, int r, int g, int b, int a) {
    matrix[0] = r/255;
    matrix[5] = g/255;
    matrix[10] = b/255;
    matrix[15] = a/255;
  }
  List<num> storeAlphaMatrixMatrix(List<num> matrix, int a) {
    matrix[0] = 1;
    matrix[5] = 1;
    matrix[10] = 1;
    matrix[15] = a/255;
  }
  
}