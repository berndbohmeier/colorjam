part of colorjam;

class SpriteRenderSystem extends IntervalEntityProcessingSystem {
  DisplayObjectContainer dbc;
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<ColorComponent> colorMapper;
  
  SpriteRenderSystem(this.dbc) : super(16, Aspect.getAspectForAllOf([PositionComponent, GeometryComponent, SpriteComponent, ColorComponent]));
  
  
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
  }
  
  void removed(Entity entity){
    Sprite sprite = spriteMapper.get(entity).sprite;
    dbc.removeChild(sprite);
  }
  
  void processEntity(Entity entity){
    PositionComponent pos = posMapper.get(entity);
    SpriteComponent spr = spriteMapper.get(entity);
    GeometryComponent geom = geomMapper.get(entity);
    ColorComponent color = colorMapper.get(entity);
    ColorComponent playerColor =
        colorMapper.get((world.getManager(TagManager) as TagManager)
                                .getEntity(PlayerFactory.TAG_PLAYER));
    
    spr.sprite.x = pos.x - geom.width/2;
    spr.sprite.y = pos.y - geom.height/2;
    
    int alpha = math.max(
                      math.max(playerColor.nr/255*color.nr,
                               playerColor.ng/255*color.ng),
                               playerColor.nb/255*color.nb).round();

    spr.sprite.filters = [
                new ColorMatrixFilter(
                      getColorMatrix(color.nr,color.nb, color.ng, 255)),
                new ColorMatrixFilter(
                      getColorMatrix(playerColor.nr,
                                     playerColor.nb,
                                     playerColor.ng,
                                     alpha))
    ];
    spr.sprite.removeCache();
    spr.sprite.applyCache(-5, -5, spr.sprite.width+5, spr.sprite.height+5);
  }
  
  List<num> getColorMatrix(int r, int g, int b, int a) {
    return [r/255, 0, 0, 0, 0,
            0, g/255, 0, 0, 0,
            0, 0, b/255, 0, 0,
            0, 0, 0, a/255, 0];
  }
}