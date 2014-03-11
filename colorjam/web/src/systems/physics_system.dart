part of colorjam;

class PhysicsSystem extends EntityProcessingSystem {
  Vector _gravity = new Vector(0, 0.001981);
  
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<PhysicsComponent> physicsMapper;
  ComponentMapper<ColliderComponent> collMapper;
  ComponentMapper<ColorComponent> colorMapper;
  
  ColliderSystem colliderSystem;
  
  PhysicsSystem() : super(Aspect.getAspectForAllOf([PositionComponent, VelocityComponent, GeometryComponent, PhysicsComponent]));
  
  void initialize() {
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    physicsMapper = new ComponentMapper<PhysicsComponent>(PhysicsComponent, world);
    collMapper = new ComponentMapper<ColliderComponent>(ColliderComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    
    colliderSystem = world.getSystem(ColliderSystem);
  }
  
  void processEntity(Entity e) {
    physicsMapper.get(e).onFloor = false;
    VelocityComponent vel = velMapper.get(e);
    
    
    PositionComponent pos = posMapper.get(e);
    GeometryComponent geom = geomMapper.get(e);
    ColorComponent color = colorMapper.get(e);
    
    Rectangle rect = new Rectangle(pos.x - geom.width/2,
        pos.y - geom.height/2,
        geom.width,
        geom.height);
    
    if(colliderSystem.entities != null) {
      colliderSystem.entities.forEach((other) {
        
        
        // check color
        ColorComponent otherColor = colorMapper.get(other);
        if(!((otherColor.nr > 0 && color.nr > 0) || (otherColor.ng > 0 && color.ng > 0) || (otherColor.nb > 0 && color.nb > 0)) != collMapper.get(other).reverse)
          return;
        
        // check for collision
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
          if(r1 > r2 && r2 > l1 && l1 > l2)
            distX = r2 - l1;
          else if(l2 > l1 && l2 < r1 && r1 < r2)
            distX = l2 - r1;
          if(b1 < b2 && b1 > t2 && t2 > t1)
            distY = t2 - b1;
          else if(b1 > b2 && b2 > t1 && t1 > t2)
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
          if(distY > 0) {
            physicsMapper.get(e).onFloor = true;
          }
          
          if(distY != 0) {
            if(vel.vy.abs() < 0.001)
              vel.vy = 0;
            if(vel.vy*distY>0){
              vel.vy *= -1 * collMapper.get(other).bounciness;
            }
           
          }
          if(distX != 0) {
            if(vel.vx.abs() < 0.001)
              vel.vx = 0;
            if(vel.vx*distX>0){
              vel.vx *= -1 * collMapper.get(other).bounciness;
            }
            
          }
        }
      });
      
      
    }
    vel.velocity += _gravity.scale(world.delta);
  }
}