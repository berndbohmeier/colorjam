part of colorjam;


class MonsterSystem extends InteractionSystem {
  onGoalReached callback;
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  MonsterSystem(CollectEntitiesSystem s, this.callback) : super(s, Aspect.getAspectForAllOf([MonsterComponent, ColorComponent]));
  
  void initialize() {
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
  }
  
  void processInteraction(Entity monster, Entity player) {
    ColorComponent monsterColor = colorMapper.get(monster);
    ColorComponent playerColor = colorMapper.get(player);
    if((monsterColor.nr > 0 && playerColor.r > 0) ||
       (monsterColor.ng > 0 && playerColor.g > 0) ||
       (monsterColor.nb > 0 && playerColor.b > 0)) {
      
      // monster has same color
      
      
        callback();
     }
      
    
  }
  
  void processNonInteraction(Entity goal, Entity player){
    
  }
}