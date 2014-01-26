part of colorjam;

class GoalFactory extends EntityFactory {
  static const WIDTH = 50, HEIGHT = 50;
  GoalFactory._() : super._() {}
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    sprite.graphics.rect(0,0,WIDTH, HEIGHT);
    sprite.graphics.strokeColor(0x55FFFFFF, 3);
    sprite.graphics.fillColor(0xFFFFFFFF);
    
    Entity e = super.build(world, args)
      ..addComponent(new TypeComponent("Goal"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(new ColorComponent.fromJson(args))
      ..addComponent(new GoalComponent())
      ..addComponent(new GeometryComponent(WIDTH, HEIGHT))
      ..addComponent(new SpriteComponent(sprite));
    
    return e;
  }
}