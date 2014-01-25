part of colorjam;

class SpriteRenderSystem extends EntityProcessingSystem {
  
  DisplayObjectContainer dbc;
  
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  
  SpriteRenderSystem(this.dbc) : super(Aspect.getAspectForAllOf([PositionComponent, GeometryComponent, SpriteComponent]));
  
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
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
    spr.sprite.x = pos.x - geom.width/2;
    spr.sprite.y = pos.y - geom.height/2;
    
  }
}