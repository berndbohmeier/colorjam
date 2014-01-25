part of colorjam;

class MovementSystem extends EntityProcessingSystem {
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<VelocityComponent> velMapper;
  
  MovementSystem() : super(Aspect.getAspectForAllOf([PositionComponent, VelocityComponent]));
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
  }
  
  void processEntity(Entity e) {
    PositionComponent pos = posMapper.get(e);
    VelocityComponent vel = velMapper.get(e);
    
    pos.position += vel.velocity.scale(world.delta);
  }
}