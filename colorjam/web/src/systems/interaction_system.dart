part of colorjam;

abstract class InteractionSystem extends EntitySystem{
  CollectEntitiesSystem system;
  
  InteractionSystem(this.system,Aspect aspect) : super(aspect);
  
  
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<InteractionComponent> interactionMapper;
  ComponentMapper<GeometryComponent> geometryMapper;
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geometryMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    interactionMapper = new ComponentMapper<InteractionComponent>(InteractionComponent, world);
  }
  
  
  void processEntities(Iterable<Entity> entities){
    entities.forEach((entity1){
      
      PositionComponent pos1 = posMapper.get(entity1);
      InteractionComponent inter1 = interactionMapper.get(entity1);
      
     
      Rectangle rect1 = new Rectangle(pos1.x - inter1.width/2,
          pos1.y - inter1.height/2,
          inter1.width,
          inter1.height);
   
      system.entities.forEach((entity2){
        // check for collision
        PositionComponent pos2 = posMapper.get(entity2);
        GeometryComponent geom2 = geometryMapper.get(entity2);
        
        Rectangle rect2 = new Rectangle(pos2.x - geom2.width/2,
            pos2.y - geom2.height/2,
            geom2.width,
            geom2.height);
        
        if(rect1.intersects(rect2)){
          processInteraction(entity1, entity2);
        }else {
          processNonInteraction(entity1, entity2);
        }
          
      });
      
    });
  }
  
  
  void processInteraction(Entity entity1, Entity entity2);
  void processNonInteraction(Entity entity1,Entity entity2){}
  
  bool checkProcessing() => true;
}