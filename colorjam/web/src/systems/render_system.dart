part of colorjam;

class SpriteRenderSystem extends IntervalEntityProcessingSystem {
  DisplayObjectContainer dbc;
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  
  
  
  
  SpriteRenderSystem(this.dbc) : super(16, Aspect.getAspectForAllOf([PositionComponent, GeometryComponent, SpriteComponent, ColorComponent]));
  
 
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    
    
   
  }
  
  
  void inserted(Entity entity){
    
    DisplayObject dbo = spriteMapper.get(entity).dbo;
    
    
    if(dbo.parent==null){
      dbc.addChild(dbo);
    }
    processEntity(entity);
  }
  
  void removed(Entity entity){
    DisplayObject dbo = spriteMapper.get(entity).dbo;
    dbo.removeFromParent();
  }
  
  void processEntity(Entity entity){
    PositionComponent pos = posMapper.get(entity);
    SpriteComponent spr = spriteMapper.get(entity);
    GeometryComponent geom = geomMapper.get(entity);
    
    
    if(spr.dbo is Animatable){
      (spr.dbo as Animatable).advanceTime(world.delta/1000.0);
    }
    
    spr.dbo.x = pos.x - spr.width/2;
    spr.dbo.y = pos.y - spr.height/2;
    
  }
}