part of colorjam;




abstract class WorldSzene extends Szene{
  
  World world;
  
  Bag<Entity> entities = new Bag<Entity>();
  
  WorldSzene(this.world, DisplayObjectContainer headcontainer) : super(headcontainer);
  
  
  void activate(){
    super.activate();
    entities.forEach((entity){
      entity.addToWorld();
    });
  }
  
  void deactivate(){
    super.deactivate();
    world.deleteAllEntities();
  }
  
  void update(num ms){
    world.delta = ms;
    world.process();
  }
  
  
}