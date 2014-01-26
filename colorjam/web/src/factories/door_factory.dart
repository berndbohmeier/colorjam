part of colorjam;

class DoorFactory extends EntityFactory {

  
  DoorFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    Bitmap bitmap = new Bitmap(resourceManager.getBitmapData("door"));
    sprite.addChild(bitmap);
    sprite.width = bitmap.width.round();
    sprite.height = bitmap.height.round();
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.alpha = false;
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Door"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new VelocityComponent(0,0))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(cp)
        ..addComponent(new ColliderComponent.reversed())
        ..addComponent(new GeometryComponent(30, sprite.height));
    
    return entity;
  }
}