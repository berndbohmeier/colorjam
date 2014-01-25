part of colorjam;




abstract class WorldScene extends Scene{
  
  World world;
  
  
  WorldScene(DisplayObjectContainer headcontainer) : super(headcontainer);
  
  void init(){
    world = new World();
  }
  
  
  void update(num ms){
    world.delta = ms;
    world.process();
  }
  
  
}