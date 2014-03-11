part of colorjam;

class ColorChangerFactory extends EntityFactory {
  
  ColorChangerFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    
    
    
    
    int counter = 0;
    int img = 1;
    List<BitmapData> bitmapDatas = new List<BitmapData>();
    for(int i = 0; i < 3; i++){
      bitmapDatas.add(resourceManager.getBitmapData("colorchanger${i + 1}"));
    }
    FlipBook flipBook = new FlipBook(bitmapDatas,10,true);
    flipBook.play();
    SpriteComponent sc = new SpriteComponent(flipBook);
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.vanishing = false;
    cp.alpha = false;
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("ColorChanger"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(cp)
        ..addComponent(new ColorChangeComponent())
        ..addComponent(sc)
        ..addComponent(new GeometryComponent(60, 80));
    
    return entity;
  }
}