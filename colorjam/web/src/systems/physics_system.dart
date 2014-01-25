part of colorjam;

class PhysicsSystem extends EntityProcessingSystem {
  Vector _gravity = new Vector(0, 0.000981);
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<PhysicsComponent> physicsMapper;
  ColliderSystem colliderSystem;
  
  PhysicsSystem() : super(Aspect.getAspectForAllOf([PositionComponent, VelocityComponent, GeometryComponent, PhysicsComponent]));
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    physicsMapper = new ComponentMapper<PhysicsComponent>(PhysicsComponent, world);
    colliderSystem = world.getSystem(ColliderSystem);
  }
  
  void processEntity(Entity e) {
    VelocityComponent vel = velMapper.get(e);
    vel.velocity += _gravity.scale(world.delta);
    
    PositionComponent pos = posMapper.get(e);
    GeometryComponent geom = geomMapper.get(e);
    
    
    Rectangle rect = new Rectangle(pos.x - geom.width/2,
        pos.y - geom.height/2,
        geom.width,
        geom.height);
    
    if(colliderSystem.entities != null) {
      colliderSystem.entities.forEach((other) {
        
        
        PositionComponent otherPos = posMapper.get(other);
        GeometryComponent otherGeom = geomMapper.get(other);
        
        Rectangle otherRect = new Rectangle(otherPos.x - otherGeom.width/2,
            otherPos.y - otherGeom.height/2,
            otherGeom.width,
            otherGeom.height);
        
        if(rect.intersects(otherRect)) {
          // bottom, top, left und right vom anderen Objekt
          num b1 = otherRect.y + otherRect.height;
          num t1 = otherRect.y;
          num l1 = otherRect.x;
          num r1 = otherRect.x + otherRect.width;
          
          // bottom, top, left und right vom Spieler
          num b2 = rect.y + rect.height;
          num t2 = rect.y;
          num l2 = rect.x;
          num r2 = rect.x + rect.width;
          
          num distX = 0;
          num distY = 0;
          if(r2 > l1)
            distX = r2 - l1;
          else if(l2 < r1)
            distX = l2 - r1;
          if(b1 > t2)
            distY = b1 - t2;
          else if(b2 > t1)
            distY = b2 - t1;
          
          // distX und distY sind 0, wenn es keine Überschneidung in dieser Richtung gibt
          // ansonsten enthalten sie den Abstand der Objekte in dieser Richtung.
          if(distX != 0 && distY != 0) {
            if(distX.abs() < distY.abs()) {
              distY = 0;
            } else {
              distX = 0;
            }
          }
          
          pos.x -= distX;
          pos.y -= distY;
          
          // Wenn das Objekt auf dem Boden ist, onFloor setzen
          if(distY > 0)
            physicsMapper.get(e).onFloor = true;
        }
      });
    }
  }
}