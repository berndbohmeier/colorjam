part of colorjam;

class ColliderSystem extends EntitySystem {
  ReadOnlyBag<Entity> entities;
  
  ColliderSystem() : super(Aspect.getAspectForAllOf([GeometryComponent, ColliderComponent, ColorComponent]));
  
  
  bool checkProcessing() => true;
  
  void processEntities(ReadOnlyBag<Entity> bag) {
    entities = bag;
  }
}