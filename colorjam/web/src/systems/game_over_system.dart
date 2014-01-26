part of colorjam;

typedef void GameOverCallback();
class GameOverSystem extends EntityProcessingSystem {
  //int _count = 0;
  GameOverCallback onGameOver;
  ComponentMapper<ColorComponent> colorMapper;
  GameOverSystem(this.onGameOver) : super(Aspect.getAspectForAllOf([PlayerComponent, ColorComponent]));
  
  void initialize() {
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    super.initialize();
  }
  
  void processEntity(Entity e) {
    if((colorMapper.get(e).colorcode & 0xFFFFFF) == 0) {
      e.deleteFromWorld();
    }
  }
  /*
  void added(Entity e) {
    _count++;
    super.added(e);
  }*/
  
  void removed(Entity e) {
    super.removed(e);/*
    print("Game Over");
    print("removed $e, ${_count-1} players");
    if(--_count == 0)*/
      onGameOver();
  }
}