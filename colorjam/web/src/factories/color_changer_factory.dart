part of colorjam;

class ColorChangerFactory extends EntityFactory {
  
  ColorChangerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    Bitmap bitmap = new Bitmap(resourceManager.getBitmapData("colorchanger1"));
    sprite.addChild(bitmap);
    sprite.width = bitmap.width.round();
    sprite.height = bitmap.height.round();
    int counter = 0;
    int img = 1;
    sprite.addEventListener(Event.ENTER_FRAME, (e) {
      
      counter = (counter + 1) % 5;
      if(counter == 0) {
        bitmap.bitmapData = resourceManager.getBitmapData("colorchanger${img + 1}");
       
        img = (img + 1) % 3;
        
      }
    });
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.vanishing = false;
    cp.alpha = false;
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("ColorChanger"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(cp)
        ..addComponent(new ColorChangeComponent())
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new GeometryComponent(60, 80));
    
    return entity;
  }
}