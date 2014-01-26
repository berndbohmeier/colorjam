part of colorjam;

class GoalFactory extends EntityFactory {
  static const WIDTH = 60, HEIGHT = 60;
  GoalFactory._() : super._() {}
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();

    Bitmap bitmap = new Bitmap(resourceManager.getBitmapData("goal"));
    sprite.addChild(bitmap);
    sprite.width = bitmap.width.round();
    sprite.height = bitmap.height.round();
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.alpha = false;
    Entity e = super.build(world, args)
      ..addComponent(new TypeComponent("Goal"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(cp)
      ..addComponent(new GoalComponent())
      ..addComponent(new GeometryComponent(WIDTH, HEIGHT))
      ..addComponent(new SpriteComponent(sprite));
    
    return e;
  }
}