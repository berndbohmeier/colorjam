part of colorjam;




class PlayerMovementSystem extends EntityProcessingSystem{
  
  
  PlayerMovementSystem() : super(Aspect.getAspectForAllOf([VelocityComponent, PlayerControlComponent, PhysicsComponent]));
  
  
  num jumpspeed = 0.02;
  num runspeed = 0.02;
  
  
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<PlayerControlComponent> controlMapper;
  ComponentMapper<PhysicsComponent> physicsMapper; 
  
  
  void initialize() {
    controlMapper = new ComponentMapper<PlayerControlComponent>(PlayerControlComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    physicsMapper = new ComponentMapper<PhysicsComponent>(PhysicsComponent, world);
    
  }
  
  void processEntity(Entity entity){
    VelocityComponent vel = velMapper.get(entity);
    PlayerControlComponent con = controlMapper.get(entity);
    PhysicsComponent phys = physicsMapper.get(entity);
    
    switch(con.direction){
      case 0:
        vel.vx = 0;
        break;
      case 1:
        vel.vx = runspeed;
        break;
      case -1:
        vel.vx = -runspeed;
        break;
      
    }
    
    if(con.jump && phys.onFloor){
      vel.vy = -jumpspeed;
    }
  }
}