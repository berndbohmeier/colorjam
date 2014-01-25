part of colorjam;

class SpriteRenderSystem extends IntervalEntityProcessingSystem {
  DisplayObjectContainer dbc;
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<ColorComponent> colorMapper;
  
  SpriteRenderSystem(this.dbc) : super(16, Aspect.getAspectForAllOf([PositionComponent, GeometryComponent, SpriteComponent, ColorComponent]));
  
  List<List<num>> filterMatrixList = [
                    [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0],
                    [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0]];
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
  }
  
  
  void inserted(Entity entity){
    
    Sprite sprite = spriteMapper.get(entity).sprite;
    
    
    dbc.addChild(sprite);
    processEntity(entity);
    sprite.removeCache();
    sprite.applyCache(-5, -5, sprite.width.round()+5, sprite.height.round()+5);
  }
  
  void removed(Entity entity){
    Sprite sprite = spriteMapper.get(entity).sprite;
    dbc.removeChild(sprite);
  }
  
  void processEntity(Entity entity){
    PositionComponent pos = posMapper.get(entity);
    SpriteComponent spr = spriteMapper.get(entity);
    GeometryComponent geom = geomMapper.get(entity);
    
    spr.sprite.x = pos.x - geom.width/2;
    spr.sprite.y = pos.y - geom.height/2;
    
    ColorComponent color = colorMapper.get(entity);
    Entity player = (world.getManager(TagManager) as TagManager)
                        .getEntity(PlayerFactory.TAG_PLAYER);
    
      storeColorMatrix(filterMatrixList[0], color.nr,color.ng, color.nb, 255);
      
      if(spr.sprite.filters.isEmpty)
        spr.sprite.filters.add(new ColorMatrixFilter(filterMatrixList[0]));
      else
        spr.sprite.filters[0] = new ColorMatrixFilter(filterMatrixList[0]);
      
      if(player != null) {
        ColorComponent playerColor = colorMapper.get(player);
        int alpha = math.max(math.max(math.min(playerColor.r, color.r),
                                      math.min(playerColor.g, color.g)),
                                      math.min(playerColor.b, color.b)).round();
    
        storeColorMatrix(filterMatrixList[1], playerColor.nr, playerColor.ng,
                                              playerColor.nb, alpha);
        
        if(spr.sprite.filters.length < 2)
          spr.sprite.filters.add(new ColorMatrixFilter(filterMatrixList[1]));
        else
          spr.sprite.filters[1] = new ColorMatrixFilter(filterMatrixList[1]);
      }

    spr.sprite.refreshCache();
  }
  
  List<num> storeColorMatrix(List<num> matrix, int r, int g, int b, int a) {
    matrix[0] = r/255;
    matrix[6] = g/255;
    matrix[12] = b/255;
    matrix[18] = a/255;
  }
}