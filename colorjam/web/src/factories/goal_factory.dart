part of colorjam;

class GoalFactory extends EntityFactory {
  static const WIDTH = 60, HEIGHT = 60;
  GoalFactory._(ResourceManager resourceManager) : super._(resourceManager) {}
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.alpha = false;
    Entity e = super.build(world, args)
      ..addComponent(new TypeComponent("Goal"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(new ColliderComponent.reversed())
      ..addComponent(cp)
      ..addComponent(new GoalComponent())
      ..addComponent(new GeometryComponent(WIDTH, HEIGHT))
      ..addComponent(new SpriteComponent(new Bitmap(resourceManager.getBitmapData("goal"))));
    
    return e;
  }
}