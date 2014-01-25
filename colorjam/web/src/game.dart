part of colorjam;



class Game {
  
  
  Game(this.stage);
  
  World world;
  
  
  Stage stage;
  Sprite mainsprite;
  
  
  
  bool run = false;
  
  /**
   * inits the world and the stage
   */
  void init(){
    
    ///stagexl
    mainsprite = new Sprite();
    stage.addChild(mainsprite);
    
    
    
    ///dartemis
    world = new World()
            ..addSystem(new MovementSystem())
            ..addSystem(new ColliderSystem())
            ..addSystem(new PhysicsSystem())
            ..addSystem(new SpriteRenderSystem(mainsprite));
    
    
    world.initialize();
    
    
    ///combine artemis and stage
    
    stage.onEnterFrame.listen(onEnterFrame);
    
  }
  
  /**
   * only for testing
   */
  void createSomeTestEntities(){
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
        """{
          "entities":[
            {
              "type":"Circle",
              "${PositionComponent.ARG_X}":50,
              "${PositionComponent.ARG_Y}":300,
              "r":10,
              "vx":0.01,
              "vy":0,
              "cr":255,
              "cg":0,
              "cb":0
            },
            {
              "type":"Circle",
              "${PositionComponent.ARG_X}":50,
              "${PositionComponent.ARG_Y}":300,
              "r":10,
              "vx":0.1,
              "vy":-0.5,
              "cr":0,
              "cg":255,
              "cb":0
            },
            {
              "type":"Wall",
              "top":500,
              "left": 20,
              "bottom": 530,
              "right": 200,
              "color_r": 0,
              "color_g": 255,
              "color_b": 255,
              "bounciness":0
            }
          ]
        }"""
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
  
  /**
   * starts the world system
   */
  void start(){
    run = true;
  }
  
  void stop(){
    run = false;
  }
  
  
  void onEnterFrame(EnterFrameEvent event){
    world.delta = event.passedTime*1000;
    if(run){
      world.process();
    }

   }
  
}