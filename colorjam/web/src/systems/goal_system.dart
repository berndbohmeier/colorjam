part of colorjam;

typedef void onGoalReached();
class GoalSystem extends InteractionSystem {
  onGoalReached callback;
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<GoalComponent> goalMapper;
  ComponentMapper<SpriteComponent> spriteMapper;
  GoalSystem(CollectEntitiesSystem s, this.callback) : super(s, Aspect.getAspectForAllOf([GoalComponent, ColorComponent]));
  
  void initialize() {
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    goalMapper = new ComponentMapper<GoalComponent>(GoalComponent, world);
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
  }
  
  void processInteraction(Entity goal, Entity player) {
    ColorComponent goalColor = colorMapper.get(goal);
    ColorComponent playerColor = colorMapper.get(player);
    GoalComponent goalGoal = goalMapper.get(goal);
    SpriteComponent spr = spriteMapper.get(goal);
    if((goalColor.nr == 0 || playerColor.r > 0) &&
       (goalColor.ng == 0 || playerColor.g > 0) &&
       (goalColor.nb == 0 || playerColor.b > 0)) {
      
      // reached goal
      goalGoal.timeToOpen-=world.delta/1000;
      FlipBook flipBook = spr.dbo as FlipBook;
      if(!flipBook.playing){
        flipBook.play();
      }
      if(goalGoal.timeToOpen<=0){
        callback();
      }
      
    }
  }
  
  void processNonInteraction(Entity goal, Entity player){
    SpriteComponent spr = spriteMapper.get(goal);
    GoalComponent goalGoal = goalMapper.get(goal);
    goalGoal.reset();
    FlipBook flipBook = spr.dbo as FlipBook;
       
       
       if(flipBook.playing){
         flipBook.gotoAndStop(0);
       }
  }
  
}