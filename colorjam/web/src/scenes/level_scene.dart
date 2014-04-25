part of colorjam;

typedef void loadNextScene();


class LevelScene extends WorldScene{
  String level;
  bool toEditor = false;
  LevelScene(this.level, Game game, DisplayObjectContainer headcontainer, this.toEditor) : super(game, headcontainer);
  
  void init(){
    super.init();
    ///dartemis
    EntitySystem colorCollectSystem = new ColorCollectSystem();
    EntitySystem playerCollectSystem = new PlayerCollectSystem();
    EntitySystem portalCollectSystem = new PortalCollectSystem();
    world
      ..addSystem(new InputControlSystem(headcontainer))
      ..addSystem(new PlayerControlSystem())
      ..addSystem(new PlayerMovementSystem())
      ..addSystem(new ElevatorMovementSystem())
      ..addSystem(new MonsterMovementSystem())
      ..addSystem(new MovementSystem())
      ..addSystem(portalCollectSystem)
      ..addSystem(playerCollectSystem)
      ..addSystem(new PortalSystem(playerCollectSystem,portalCollectSystem))
      ..addSystem(new ColliderSystem())
      ..addSystem(new PhysicsSystem())
      ..addSystem(new ColorDecaySystem())
      ..addSystem(colorCollectSystem)
      ..addSystem(new ColorChangeSystem(colorCollectSystem))
      ..addSystem(new GoalSystem(playerCollectSystem, toEditor?game.loadEditor:game.loadNextLevel))
      ..addSystem(new MonsterSystem(playerCollectSystem, onGameOver))
      ..addSystem(new GameOverSystem(onGameOver))
      ..addSystem(new ColorRenderSystem())
      ..addSystem(new PlayerAnimationRenderSystem())
      ..addSystem(new SpriteRenderSystem(container))
      ..addSystem(new ScrollSystem(container))
      

      ..addManager(new TagManager());
    world.initialize();
    new LevelParser(world, game.resourceManager).parse(level);
  }
  
  void onGameOver() {
    if(toEditor){
      game.loadEditor();
    }else{
      game.switchToSzene("gameoverscene");
    }
  }
  
}