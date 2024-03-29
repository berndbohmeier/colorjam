part of colorjam;





class EditorScene extends WorldScene{
  
  String levelcode =  """{
      "entities":[
      {
      "type":"Player",
      "${PositionComponent.ARG_X}":300,
  "${PositionComponent.ARG_Y}":800,
  "color_r":255,
  "color_g":0,
  "color_b":0
  },
  {
  "type":"Goal",
  "${PositionComponent.ARG_X}":400,
  "${PositionComponent.ARG_Y}":800,
  "color_r":0,
  "color_g":0,
  "color_b":255
  }
      ]
    }
    """
  ;
  
  bool fromCod = false;
  
  EditorSystem editorsystem;
  
  EditorScene(Game game, DisplayObjectContainer headcontainer) : super(game, headcontainer);
  EditorScene.fromCode(Game game, DisplayObjectContainer headcontainer, this.levelcode) : super(game, headcontainer){
    fromCod = true;
  }
  
  void init(){
    super.init();
    editorsystem= new EditorSystem(game, container);
    ///dartemis
    world
            ..addSystem(editorsystem)
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
    new LevelParser(world,game.resourceManager)
      ..parse(levelcode);
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
    
    if(fromCod){
      print("init from code");
    }
  
  }
  
  void activate() {
    super.activate();
    html.querySelectorAll(".editor").forEach((e) => (e as html.Element).style.visibility = "visible");
    html.querySelector("#sample_container_id").style.overflow = "scroll";
    html.querySelector("#sample_container_id").scrollTop = 800;
    html.querySelector("#sample_container_id").scrollLeft = 0;
    editorsystem.setUpInputs();
    
  }
  
  void deactivate() {
    super.deactivate();
    html.querySelectorAll(".editor").forEach((e) => (e as html.Element).style.visibility = "hidden");

    html.querySelector("#sample_container_id").style.overflow = "hidden";
    html.querySelector("#sample_container_id").scrollTop = 0;
    html.querySelector("#sample_container_id").scrollLeft = 0;
    editorsystem.cancelInputs();
  }
  
}