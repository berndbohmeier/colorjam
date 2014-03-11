part of colorjam;

// Example Factory that creates a circle
class CircleFactory extends EntityFactory {
  static const String ARG_VX = "vx";
  static const String ARG_VY = "vy";
  static const String ARG_RADIUS = "r";
  static const String ARG_COLOR_R = "cr";
  static const String ARG_COLOR_G = "cg";
  static const String ARG_COLOR_B = "cb";
  
  CircleFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  Entity build(World world, Map<String, dynamic> args) {
    
    Entity entity = world.createEntity()
      ..addComponent(new TypeComponent("Circle"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(new VelocityComponent(args[ARG_VX], args[ARG_VY]))
      ..addComponent(new PhysicsComponent())
      ..addComponent(new GeometryComponent(args[ARG_RADIUS]*2, args[ARG_RADIUS]*2))
      ..addComponent(new ColorComponent.fromJson(args));
    
    return entity;
  }
  
  int rgbToInt(int r, int g, int b)
        => (0xFF << 24) | (r << 16) | (g << 8) | b;
}