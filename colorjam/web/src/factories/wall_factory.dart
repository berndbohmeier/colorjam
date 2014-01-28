part of colorjam;

class WallFactory extends EntityFactory {
  static const String ARG_TOP = "top";
  static const String ARG_LEFT = "left";
  static const String ARG_RIGHT = "right";
  static const String ARG_BOTTOM = "bottom";
  static const String ARG_BOUNCINESS = "bounciness";

  
  WallFactory._() : super._();
  
  Entity build(World world, Map<String, dynamic> args) {
    ColorComponent colorComp = new ColorComponent.fromJson(args);
    num top = args[ARG_TOP] as num;
    num left = args[ARG_LEFT] as num;
    num right = args[ARG_RIGHT] as num;
    num bottom = args[ARG_BOTTOM] as num;
    Sprite sprite = new Sprite();
    sprite.graphics.rect(0,0,right - left, bottom - top);
    sprite.graphics.strokeColor(Color.Black, 2);
    sprite.graphics.fillColor(0xFFFFFFFF);
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Wall"))
        ..addComponent(new PositionComponent(left + (right-left)/2, top + (bottom-top)/2))
        ..addComponent(new VelocityComponent(0,0))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(new ColliderComponent(bounciness: args[ARG_BOUNCINESS]))
        ..addComponent(new GeometryComponent(right - left, bottom - top));
    
    return entity;
  }
}