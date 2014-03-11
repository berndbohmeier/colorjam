part of colorjam;




abstract class WorldScene extends Scene{
  
  World world;
  
  
  
  WorldScene(Game game, DisplayObjectContainer headcontainer) : super(game, headcontainer)  ;
  
  void init(){
    super.init();
    world = new World();
    world.addSystem(new RemoveEntitiesSystem());
  }
  
  
  void update(num ms){
    world.delta = ms;
    world.process();
  }
}