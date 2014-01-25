part of colorjam;

class PlayerFactory extends EntityFactory {
  static const String ARG_X = "x";
  static const String ARG_Y = "y";
  
  PlayerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    sprite.graphics.rect(0, 0, 30, 30);
    sprite.graphics.fillColor(0x00FFFF);
    
    Entity entity = world.createEntity()
        ..addComponent(new PositionComponent(args[ARG_X], args[ARG_Y]))
        ..addComponent(new VelocityComponent(0, 0))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new PhysicsComponent())
        ..addComponent(new GeometryComponent(30, 30))
        ..addComponent(new PlayerControlComponent())
        ..addComponent(new PlayerInputComponent(html.KeyCode.LEFT, html.KeyCode.RIGHT, html.KeyCode.UP));
        ..addToWorld();
    
    return entity;
  }
}