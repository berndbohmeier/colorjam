part of colorjam;

typedef void loadNextScene();
class LevelScene extends WorldScene{
  String level;
  
  LevelScene(this.level, Game game, DisplayObjectContainer headcontainer) : super(game, headcontainer);
  
  void init(){
    super.init();
    ///dartemis
    EntitySystem colorCollectSystem = new ColorCollectSystem();
    EntitySystem playerCollectSystem = new PlayerCollectSystem();
    world
      ..addSystem(new InputControlSystem(headcontainer))
      ..addSystem(new PlayerControlSystem())
      ..addSystem(new PlayerMovementSystem())
      ..addSystem(new MovementSystem())
      ..addSystem(new ColliderSystem())
      ..addSystem(new PhysicsSystem())
      ..addSystem(new ColorDecaySystem())
      ..addSystem(colorCollectSystem)
      ..addSystem(new ColorChangeSystem(colorCollectSystem))
      ..addSystem(playerCollectSystem)
      ..addSystem(new GoalSystem(playerCollectSystem, game.loadNextLevel))
      ..addSystem(new GameOverSystem(onGameOver))
      ..addSystem(new ColorRenderSystem())
      ..addSystem(new ScrollSystem(headcontainer))
      ..addSystem(new SpriteRenderSystem(container))

      ..addManager(new TagManager());
    world.initialize();
    new LevelParser(world).parse(level);
  }
  
  void onGameOver() {
    game.switchToSzeneWithInit("gameoverscene");
  }
  
}