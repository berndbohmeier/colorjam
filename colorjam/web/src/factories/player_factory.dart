part of colorjam;

class PlayerFactory extends EntityFactory {
  static const String TAG_PLAYER = "player";
  
  PlayerFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    
    
    
    
    int counter = 0;
    int img = 1;
    
    PlayerControlComponent pcc = new PlayerControlComponent();
    
    
    List<BitmapData> bitmapDatas = new List<BitmapData>();
    
    for(int i = 0; i < 4; i++){
      bitmapDatas.add(resourceManager.getBitmapData("player${i + 1}"));
    }
    
    
    
    
    
    FlipBook flipBook = new FlipBook(bitmapDatas,20,true);
    SpriteComponent sc = new SpriteComponent(flipBook);
    
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Player"))
        ..addComponent(new PlayerComponent())
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0, 0))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(sc)
        ..addComponent(new PhysicsComponent())
        ..addComponent(new GeometryComponent(sc.width, sc.height))
        ..addComponent(new ColorDecayComponent())
        ..addComponent(pcc)
        ..addComponent(new PlayerInputComponent(html.KeyCode.LEFT, html.KeyCode.RIGHT, html.KeyCode.UP, html.KeyCode.SPACE));
    
    (world.getManager(TagManager) as TagManager).register(entity, TAG_PLAYER);    
    
    return entity;
  }
}