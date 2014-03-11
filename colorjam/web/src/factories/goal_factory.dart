part of colorjam;

class GoalFactory extends EntityFactory {
  static const WIDTH = 60, HEIGHT = 60;
  GoalFactory._(ResourceManager resourceManager) : super._(resourceManager) {}
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    
    
    List<BitmapData> bitmapDatas = new List<BitmapData>();
           
           for(int i = 0; i < 4; i++){
             bitmapDatas.add(resourceManager.getBitmapData("goal${i}"));
           }
           
           
           
           
           
    FlipBook flipBook = new FlipBook(bitmapDatas,40,false);
    SpriteComponent sc = new SpriteComponent(flipBook);
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.alpha = false;
    Entity e = super.build(world, args)
      ..addComponent(new TypeComponent("Goal"))
      ..addComponent(new PositionComponent.fromJson(args))
      ..addComponent(new ColliderComponent.reversed())
      ..addComponent(cp)
      ..addComponent(new GoalComponent())
      ..addComponent(new GeometryComponent(WIDTH, HEIGHT))
      ..addComponent(sc);
    
    return e;
  }
}