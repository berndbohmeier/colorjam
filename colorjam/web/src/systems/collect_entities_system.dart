part of colorjam;



class CollectEntitiesSystem extends EntitySystem{
  
  CollectEntitiesSystem(Aspect aspect) : super(aspect);
  ReadOnlyBag<Entity>entities;
  
  void processEntities(ReadOnlyBag<Entity> entities){
    this.entities = entities;
  }
  bool checkProcessing() => true;
}