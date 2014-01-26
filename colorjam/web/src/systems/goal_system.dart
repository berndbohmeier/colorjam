part of colorjam;

typedef void onGoalReached();
class GoalSystem extends InteractionSystem {
  onGoalReached callback;
  ComponentMapper<ColorComponent> colorMapper;
  GoalSystem(CollectEntitiesSystem s, this.callback) : super(s, Aspect.getAspectForAllOf([GoalComponent, ColorComponent]));
  
  void initialize() {
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
  }
  
  void processInteraction(Entity goal, Entity player) {
    ColorComponent goalColor = colorMapper.get(goal);
    ColorComponent playerColor = colorMapper.get(player);
    
    if((goalColor.nr == 0 || playerColor.r > 0) &&
       (goalColor.ng == 0 || playerColor.g > 0) &&
       (goalColor.nb == 0 || playerColor.b > 0)) {
      
      // reached goal
      callback();
    }
  }
}