part of colorjam;

class ElevatorFactory extends EntityFactory {

  
  ElevatorFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  static const int width = 100;
  static const int height = 20;
  static const String ARG_BOUNCINESS = "bounciness";
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    
    
    ColorComponent colorComp = new ColorComponent.fromJson(args);
    
    
    Sprite sprite = BitmapHelper.createRectangle(width, height);
    
    
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Elevator"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0,0))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(new ColliderComponent(bounciness: args[ARG_BOUNCINESS]))
        ..addComponent(new ElevatorComponent.fromJson(args))
        ..addComponent(new GeometryComponent(width, height));
    
    return entity;
  }
}


