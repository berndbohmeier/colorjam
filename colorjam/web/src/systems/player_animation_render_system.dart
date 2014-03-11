part of colorjam;

class PlayerAnimationRenderSystem extends IntervalEntityProcessingSystem {
  
  ComponentMapper<PlayerControlComponent> playerMapper;
  ComponentMapper<PhysicsComponent> physicsMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  
  
  
  
  PlayerAnimationRenderSystem() : super(16, Aspect.getAspectForAllOf([PlayerControlComponent,SpriteComponent, PhysicsComponent]));
  
 
  
  void initialize() {
    playerMapper = new ComponentMapper<PlayerControlComponent>(PlayerControlComponent, world);
    physicsMapper = new ComponentMapper<PhysicsComponent>(PhysicsComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
  }
  
  
  void inserted(Entity entity){
   
  }
  
  void removed(Entity entity){
  }
  
  void processEntity(Entity entity){
    PlayerControlComponent player = playerMapper.get(entity);
    SpriteComponent spr = spriteMapper.get(entity);
    PhysicsComponent physics = physicsMapper.get(entity);
    
    FlipBook flipBook = spr.dbo as FlipBook;
    if(player.direction!=0 && !flipBook.playing && physics.onFloor){
      flipBook.play();
    }
    
    if((player.direction == 0 || !physics.onFloor) && flipBook.playing){
      flipBook.stop();
    }
    
  }
}