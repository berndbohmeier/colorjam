part of colorjam;

class ScrollSystem extends EntityProcessingSystem {
  DisplayObject head;
  ComponentMapper<PositionComponent> posMapper;
  ScrollSystem(this.head) : super(Aspect.getAspectForAllOf([PlayerComponent,PositionComponent]));
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    
  }
  void processEntity(Entity player) {
    PositionComponent pos = posMapper.get(player);
    num centerx = -pos.x + 400;
    num centery = -pos.y + 300;
    
    if((centerx - head.x).abs() > 200) {
      head.x = centerx + (centerx - head.x)/(centerx - head.x).abs() * 200;
    }
    if((centery - head.y).abs() > 200) {
      head.y = centery + (centery - head.y)/(centerx - head.x).abs() * 200;
    }
  }
}