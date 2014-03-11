part of colorjam;



class CollectEntitiesSystem extends EntitySystem{
  
  CollectEntitiesSystem(Aspect aspect) : super(aspect);
  Iterable<Entity>entities;
  
  void processEntities(Iterable<Entity> entities){
    this.entities = entities;
  }
  bool checkProcessing() => true;
}