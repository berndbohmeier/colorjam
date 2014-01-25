part of colorjam;




abstract class WorldSzene extends Scene{
  
  World world;
  
  
  WorldSzene(DisplayObjectContainer headcontainer) : super(headcontainer);
  
  void init(){
    world = new World();
  }
  
  
  void update(num ms){
    world.delta = ms;
    world.process();
  }
  
  
}