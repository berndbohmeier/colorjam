part of colorjam;

class PlayerFactory extends EntityFactory {
  static const String TAG_PLAYER = "player";
  
  PlayerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    sprite.graphics.rect(0, 0, 30, 30);
    sprite.graphics.strokeColor(Color.Black, 2);
    sprite.graphics.fillColor(0xFFFFFFFF);
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Player"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0, 0))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new PhysicsComponent())
        ..addComponent(new GeometryComponent(30, 30))
        ..addComponent(new PlayerControlComponent())
        ..addComponent(new PlayerInputComponent(html.KeyCode.LEFT, html.KeyCode.RIGHT, html.KeyCode.UP));
    
    (world.getManager(TagManager) as TagManager).register(entity, TAG_PLAYER);    
    
    return entity;
  }
}