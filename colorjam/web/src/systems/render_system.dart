part of colorjam;

class SpriteRenderSystem extends EntityProcessingSystem {
  
  DisplayObjectContainer dbc;
  
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  
  SpriteRenderSystem(this.dbc) : super(Aspect.getAspectForAllOf([PositionComponent,SpriteComponent]));
  
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
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
    spr.sprite.x = pos.x;
    spr.sprite.y = pos.y;
    
  }
}