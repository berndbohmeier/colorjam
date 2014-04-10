part of colorjam;

class PortalFactory extends EntityFactory {

  
  PortalFactory._(ResourceManager resourceManager) : super._(resourceManager);
  
  static const int width = 20;
  static const int height = 100;
  static const String ARG_DIRECTION = "direction";
  
  Entity build(World world, Map<String, dynamic> args) {
    
    
    int direction = args[ARG_DIRECTION] as num;
    
    ColorComponent colorComp = new ColorComponent.fromJson(args);
    
    
    
    
    
    int gwidth = 0;
    int gheight = 0;
    int iwidth = 0;
    int iheight = 0;
    
    switch(direction){
      case PortalComponent.DIRECTION_LEFT:
      case PortalComponent.DIRECTION_RIGHT:
        gwidth = width;
        iwidth = width+4;
        gheight = height;
        iheight = height-4;
        break;
      case PortalComponent.DIRECTION_TOP:
      case PortalComponent.DIRECTION_BOT:
        gwidth = height;
        iwidth = height-4;
        gheight = width;
        iheight = width+4;
        break;
    }
    
    Sprite sprite = BitmapHelper.createRectangle(gwidth, gheight);
    
    Entity entity = world.createEntity()
        ..addComponent(new TypeComponent("Portal"))
        ..addComponent(new PositionComponent.fromJson(args))
        ..addComponent(new SpriteComponent(sprite))
        ..addComponent(new ColorComponent.fromJson(args))
        ..addComponent(new ColliderComponent())
        ..addComponent(new PortalComponent(direction))
        ..addComponent(new InteractionComponent(iwidth, iheight));
        //..addComponent(new GeometryComponent(gwidth, gheight));
    
    return entity;
  }
}


