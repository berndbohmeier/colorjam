part of colorjam;




class ElevatorMovementSystem extends EntityProcessingSystem{
  
  
  ElevatorMovementSystem() : super(Aspect.getAspectForAllOf([VelocityComponent,ElevatorComponent, PositionComponent, WaypointComponent]));
  
  
 
  
  
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<ElevatorComponent> elevatorMapper;
  ComponentMapper<WaypointComponent> waypointMapper;
  ComponentMapper<PositionComponent> posMapper;
  
  
  
  void initialize() {
    elevatorMapper = new ComponentMapper<ElevatorComponent>(ElevatorComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    waypointMapper = new ComponentMapper<WaypointComponent>(WaypointComponent, world);
  }
  
  void processEntity(Entity entity){
    VelocityComponent vel = velMapper.get(entity);
    ElevatorComponent elevator = elevatorMapper.get(entity);
    PositionComponent position = posMapper.get(entity);
    WaypointComponent waypoint = waypointMapper.get(entity);
    
    if(waypoint.getCurrentWaypoint().distance(position.position).abs() <= elevator.speed*world.delta ){
      waypoint.nextWaypoint();
      vel.vx = 0;
      vel.vy = 0;
      return;
    }
    
    Vector velocity = waypoint.getCurrentWaypoint() - position.position;
    velocity = velocity.scaleLength(elevator.speed);
    
    vel.vx = velocity.x;
    vel.vy = velocity.y;
    
  }
}