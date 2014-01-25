part of colorjam;

class ColorChangerFactory extends EntityFactory {
  
  ColorChangerFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    Sprite sprite = new Sprite();
    sprite.graphics.rect(0, 0, 30, 30);
    sprite.graphics.strokeColor(Color.Black, 2);
    sprite.graphics.fillColor(0xFFFFFFFF);
    
    ColorComponent cp = new ColorComponent.fromJson(args);
    cp.vanishing = false;
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("ColorChanger"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(cp)
        ..addComponent(new ColorChangeComponent())
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new GeometryComponent(40, 40));
    
    return entity;
  }
}