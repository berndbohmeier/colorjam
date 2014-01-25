part of colorjam;

// Example Factory that creates a circle
class CircleFactory extends EntityFactory {
  static const String ARG_X = "x";
  static const String ARG_Y = "y";
  static const String ARG_VX = "vx";
  static const String ARG_VY = "vy";
  static const String ARG_RADIUS = "r";
  static const String ARG_COLOR_R = "cr";
  static const String ARG_COLOR_G = "cg";
  static const String ARG_COLOR_B = "cb";
  
  CircleFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    sprite.graphics.circle(0, 0, args[ARG_RADIUS]);
    sprite.graphics.fillColor(rgbToInt(
                    args[ARG_COLOR_R] as int,
                    args[ARG_COLOR_G] as int, 
                    args[ARG_COLOR_B] as int
    ));
    Entity entity = world.createEntity()
      ..addComponent(new PositionComponent(args[ARG_X], args[ARG_Y]))
      ..addComponent(new VelocityComponent(args[ARG_VX], args[ARG_VY]))
      ..addComponent(new SpriteComponent(sprite))
      ..addComponent(new PhysicsComponent())
      ..addComponent(new GeometryComponent(args[ARG_RADIUS], args[ARG_RADIUS]));
    
    return entity;
  }
  
  int rgbToInt(int r, int g, int b)
        => (0xFF << 24) | (r << 16) | (g << 8) | b;
}