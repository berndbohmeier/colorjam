part of colorjam;

class PlayerFactory extends EntityFactory {
  static const String TAG_PLAYER = "player";
  
  PlayerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    //sprite.graphics.rect(0, 0, 30, 30);
    //sprite.graphics.strokeColor(Color.Black, 2);
    //sprite.graphics.fillColor(0xFFFFFFFF);
    
    SpriteComponent spriteComponent = new SpriteComponent(sprite);
    spriteComponent.bitMaps = new List<Bitmap>(4);
    for(int i = 0;i < 4; i++ ){
      Bitmap bitmap= new Bitmap( resourceManager.getBitmapData("player${i + 1}"));
      spriteComponent.bitMaps[i]=bitmap;
      sprite.addChild(bitmap);
      bitmap.visible = false;
      sprite.width = bitmap.width.round();
      sprite.height = bitmap.height.round();
      
    }

    spriteComponent.bitMaps[0].visible=true;
    PlayerControlComponent pcc = new PlayerControlComponent();
    int counter = 0;
    int img = 1;
    sprite.addEventListener(Event.ENTER_FRAME, (e) {
      
      
      
      if(pcc.direction!=0)counter = (counter + 1) % 5;
      if(counter == 0) {
        
        if(pcc.direction == 1)
          img = (img + 1) % 4;
        else if(pcc.direction == -1)
          img = (img + 3) % 4;
      }
      for(int i = 0;i < 4; i++ ){
        if(i==img){
          spriteComponent.bitMaps[img].visible=true;
        }else{
          spriteComponent.bitMaps[i].visible=false;
        }
        
        
      }
      
    });
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Player"))
        ..addComponent(new PlayerComponent())
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0, 0))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(spriteComponent)
        ..addComponent(new PhysicsComponent())
        ..addComponent(new GeometryComponent(sprite.width, sprite.height))
        ..addComponent(new ColorDecayComponent())
        ..addComponent(pcc)
        ..addComponent(new PlayerInputComponent(html.KeyCode.LEFT, html.KeyCode.RIGHT, html.KeyCode.UP));
    
    (world.getManager(TagManager) as TagManager).register(entity, TAG_PLAYER);    
    
    return entity;
  }
}