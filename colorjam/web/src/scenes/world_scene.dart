part of colorjam;




abstract class WorldScene extends Scene{
  
  World world;
  
  
  WorldScene(DisplayObjectContainer headcontainer) : super(headcontainer);
  
  void init(){
    world = new World();
    world.addSystem(new RemoveEntitiesSystem());
  }
  
  
  void update(num ms){
    world.delta = ms;
    world.process();
  }
}