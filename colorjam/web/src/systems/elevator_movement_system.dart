part of colorjam;




class ElevatorMovementSystem extends EntityProcessingSystem{
  
  
  ElevatorMovementSystem() : super(Aspect.getAspectForAllOf([VelocityComponent,ElevatorComponent, PositionComponent]));
  
  
 
  
  
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<ElevatorComponent> elevatorMapper;
  ComponentMapper<PositionComponent> posMapper;
  
  
  
  void initialize() {
    elevatorMapper = new ComponentMapper<ElevatorComponent>(ElevatorComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
  }
  
  void processEntity(Entity entity){
    VelocityComponent vel = velMapper.get(entity);
    ElevatorComponent elevator = elevatorMapper.get(entity);
    PositionComponent position = posMapper.get(entity);
    if(elevator.currentWaypoint >= elevator.waypoints.length){
      if(elevator.loop){
        elevator.currentWaypoint = 0;
      }
      return;
    }
    
    if(elevator.waypoints.elementAt(elevator.currentWaypoint).distance(position.position).abs() <= elevator.speed*world.delta ){
      elevator.currentWaypoint++;
      vel.vx = 0;
      vel.vy = 0;
      return;
    }
    
    Vector velocity = elevator.waypoints.elementAt(elevator.currentWaypoint) - position.position;
    velocity = velocity.scaleLength(elevator.speed);
    
    vel.vx = velocity.x;
    vel.vy = velocity.y;
    
  }
}