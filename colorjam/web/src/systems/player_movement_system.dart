part of colorjam;




class PlayerMovementSystem extends EntityProcessingSystem{
  
  
  PlayerMovementSystem() : super(Aspect.getAspectForAllOf([VelocityComponent, PlayerControlComponent, PhysicsComponent]));
  
  
  num jumpspeed = 0.7;
  num runspeed = 0.3;
  
  
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
    
    Vector correction = new Vector.zero();
    if(phys.velocity!=null){
      correction = phys.velocity;
    }
    
    
    
    switch(con.direction){
      case 0:
        vel.vx = 0+correction.x;
        break;
      case 1:
        vel.vx = runspeed+correction.x;
        break;
      case -1:
        vel.vx = -runspeed+correction.x;
        break;
      
    }
    
    if(con.jump && phys.onFloor){
      vel.vy = -jumpspeed + correction.y;
      con.jump = false;
    }
  }
}