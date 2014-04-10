part of colorjam;

// Example Factory that creates a circle
class MonsterFactory extends EntityFactory {
  static const String ARG_VX = "vx";
  static const String ARG_VY = "vy";
  static const String ARG_COLOR_R = "cr";
  static const String ARG_COLOR_G = "cg";
  static const String ARG_COLOR_B = "cb";
  
  static int width = 48, height = 48;
  
  MonsterFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  Entity build(World world, Map<String, dynamic> args) {
    ColorComponent cc = new ColorComponent.fromJson(args);
    
    Bitmap bitmap = new Bitmap(resourceManager.getBitmapData("monster"));
    
    //sprite.applyCache(0, 0, (radius*2).round(), (radius*2).round());
    
    Entity entity = world.createEntity()
      ..addComponent(new TypeComponent("Monster"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(new VelocityComponent(args[ARG_VX], args[ARG_VY]))
      ..addComponent(new PhysicsComponent()..bounciness=0.5)
      ..addComponent(new InteractionComponent(width, height))
      ..addComponent(new GeometryComponent(width, height))
      ..addComponent(new WaypointComponent.fromJson(args))
      ..addComponent(new MonsterComponent())
      ..addComponent(cc)
      ..addComponent(new SpriteComponent(bitmap));
    
    return entity;
  }
  
  int rgbToInt(int r, int g, int b)
        => (0xFF << 24) | (r << 16) | (g << 8) | b;
}