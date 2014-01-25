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
      ..addComponent(new VelocityComponent(0.01, 0))
      ..addComponent(new SpriteComponent(sprite))
      ..addToWorld();*/
    new LevelParser(world)
      ..parse(
        """{
          "entities":[
            {
              "type":"Circle",
              "x":50,
              "y":300,
              "r":10,
              "vx":0.01,
              "vy":0,
              "cr":255,
              "cg":0,
              "cb":0
            },
            {
              "type":"Circle",
              "x":100,
              "y":300,
              "r":10,
              "vx":0.1,
              "vy":-0.5,
              "cr":0,
              "cg":255,
              "cb":0
            }
          ]
        }"""
    );
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