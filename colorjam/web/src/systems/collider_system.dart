part of colorjam;

class ColliderSystem extends EntitySystem {
  Iterable<Entity> entities;
  
  ColliderSystem() : super(Aspect.getAspectForAllOf([GeometryComponent, ColliderComponent, ColorComponent]));
  
  
  bool checkProcessing() => true;
  
  void processEntities(Iterable<Entity> bag) {
    entities = bag;
    Entity entity;
  }
}