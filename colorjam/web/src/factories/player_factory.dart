part of colorjam;

class PlayerFactory extends EntityFactory {
  static const String TAG_PLAYER = "player";
  
  PlayerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    //sprite.graphics.rect(0, 0, 30, 30);
    //sprite.graphics.strokeColor(Color.Black, 2);
    //sprite.graphics.fillColor(0xFFFFFFFF);
    
    
    Bitmap bitmap = new Bitmap(resourceManager.getBitmapData("player1"));
    
    PlayerControlComponent pcc = new PlayerControlComponent();
    sprite.addChild(bitmap);
    sprite.width = bitmap.width.round();
    sprite.height = bitmap.height.round();
    int counter = 0;
    int img = 1;
    sprite.addEventListener(Event.ENTER_FRAME, (e) {
      
      counter = (counter + 1) % 5;
      if(counter == 0) {
        bitmap.bitmapData = resourceManager.getBitmapData("player${img + 1}");
        if(pcc.direction == 1)
          img = (img + 1) % 4;
        else if(pcc.direction == -1)
          img = (img + 3) % 4;
      }
    });
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Player"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0, 0))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new PhysicsComponent())
        ..addComponent(new GeometryComponent(bitmap.width, bitmap.height))
        ..addComponent(new ColorDecayComponent())
        ..addComponent(pcc)
        ..addComponent(new PlayerInputComponent(html.KeyCode.LEFT, html.KeyCode.RIGHT, html.KeyCode.UP));
    
    (world.getManager(TagManager) as TagManager).register(entity, TAG_PLAYER);    
    
    return entity;
  }
}