part of colorjam;

class RemoveEntitiesSystem extends IntervalEntityProcessingSystem {
  static const MAX_Y = 1000;
  
  ComponentMapper<PositionComponent> _posMapper;
  RemoveEntitiesSystem() : super(16, Aspect.getAspectForAllOf([PositionComponent]));
  
  void initialize() {
    _posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
  }
  void processEntity(Entity e) {
    if(_posMapper.get(e).position.y > MAX_Y) {
      e.deleteFromWorld();
    }
  }
}