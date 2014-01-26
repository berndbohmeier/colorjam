part of colorjam;





class EditorScene extends WorldScene{
  String level;
  
  
  EditorScene(this.level, DisplayObjectContainer headcontainer) : super(headcontainer);
  
  
  void init(){
    super.init();
    ///dartemis
    world
            ..addSystem(new EditorSystem(container))
            ..addSystem(new ColorRenderSystem(globalVanishing: false) )
            ..addSystem(new SpriteRenderSystem(container))
            ..addManager(new TagManager());
    
    
    world.initialize();
    
   
      /*
      Sprite sprite = new Sprite();
      sprite.graphics.circle(0, 0, 20 );
      sprite.graphics.fillColor(Color.Red);
      Entity entity = world.createEntity()
      ..addComponent(new PositionComponent(50, 50))
      ..addComponent(new VelocityComponent(0.1, 0))
      ..addComponent(new SpriteComponent(sprite))
      ..addComponent(new PhysicsComponent())
      ..addComponent(new GeometryComponent(20, 20))
      ..addToWorld();*/
    new LevelParser(world)
      ..parse(
        level
    );
    /*
    Sprite sprite2 = new Sprite();
    sprite2.graphics.rect(0, 0, 250, 40);
    sprite2.graphics.fillColor(Color.Aqua);
    Entity ground = world.createEntity()
        ..addComponent(new PositionComponent(130, 250))
        ..addComponent(new SpriteComponent(sprite2))
        ..addComponent(new ColliderComponent(bounciness: 0.4))
        ..addComponent(new GeometryComponent(250, 40))
        ..addToWorld();
    
    Sprite wallSprite = new Sprite();
    wallSprite.graphics.rect(0, 0, 40, 100);
    wallSprite.graphics.fillColor(Color.Blue);
    Entity wall = world.createEntity()
        ..addComponent(new PositionComponent(210, 170))
        ..addComponent(new SpriteComponent(wallSprite))
        ..addComponent(new ColliderComponent())
        ..addComponent(new GeometryComponent(40,100))
        ..addToWorld();
        
    */
  
  }
  
  
}