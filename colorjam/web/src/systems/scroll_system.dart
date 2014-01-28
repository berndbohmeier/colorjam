part of colorjam;

class ScrollSystem extends EntityProcessingSystem {
  DisplayObject head;
  ComponentMapper<PositionComponent> posMapper;
  ScrollSystem(this.head) : super(Aspect.getAspectForAllOf([PlayerComponent,PositionComponent]));
  
  num left = 170;
  num right = 170;
  num top = 100;
  num bottom = 100;
  
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    
  }
  void processEntity(Entity player) {
    PositionComponent pos = posMapper.get(player);
    num centerx = -pos.x + 400;
    num centery = -pos.y + 300;
    
    if((centerx - head.x) > left) {
      head.x = centerx - left;
    
    }
    if(-(centerx - head.x) > right) {
      head.x = centerx + right;
    
    }
    if((centery - head.y) > top) {
      head.y = centery  -top;
    }
    if(-(centery - head.y) > bottom) {
      head.y = centery + bottom;
    }
  }
}