part of colorjam;

class DoorFactory extends EntityFactory {

  
  DoorFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.alpha = false;
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Door"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0,0))
        ..addComponent(new SpriteComponent(new Bitmap(resourceManager.getBitmapData("door"))))
        ..addComponent(cp)
        ..addComponent(new ColliderComponent.reversed())
        ..addComponent(new GeometryComponent(30, 100));
    
    return entity;
  }
}