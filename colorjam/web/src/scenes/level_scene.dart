part of colorjam;

typedef void loadNextScene();
class LevelScene extends WorldScene{
  loadNextScene callback;
  String level;
  
  LevelScene(this.level, this.callback, DisplayObjectContainer headcontainer) : super(headcontainer);
  
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
      ..addSystem(new GoalSystem(playerCollectSystem, callback))
      ..addSystem(new ColorRenderSystem())
      ..addSystem(new SpriteRenderSystem(container))

      ..addManager(new TagManager());
    world.initialize();
    new LevelParser(world).parse(level);
  }
  
  
}