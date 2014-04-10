part of colorjam;




class MonsterMovementSystem extends EntityProcessingSystem{
  
  
  MonsterMovementSystem() : super(Aspect.getAspectForAllOf([VelocityComponent,MonsterComponent, PositionComponent, WaypointComponent]));
  
  
 
  
  
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<MonsterComponent> monsterMapper;
  ComponentMapper<WaypointComponent> waypointMapper;
  ComponentMapper<PositionComponent> posMapper;
  
  
  
  void initialize() {
    monsterMapper = new ComponentMapper<MonsterComponent>(MonsterComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    waypointMapper = new ComponentMapper<WaypointComponent>(WaypointComponent, world);
  }
  
  void processEntity(Entity entity){
    VelocityComponent vel = velMapper.get(entity);
    MonsterComponent monster = monsterMapper.get(entity);
    PositionComponent position = posMapper.get(entity);
    WaypointComponent waypoint = waypointMapper.get(entity);
    
    if((waypoint.getCurrentWaypoint().x-position.position.x).abs() <= monster.speed*world.delta ){
      waypoint.nextWaypoint();
      vel.vx = 0;
      vel.vy = 0;
      return;
    }
    
    num v = waypoint.getCurrentWaypoint().x - position.position.x;
    
    vel.vx = monster.speed * v.sign;
  }
}