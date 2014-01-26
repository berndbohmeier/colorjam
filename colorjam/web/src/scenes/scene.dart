part of colorjam;




abstract class Scene{
  bool active = false;
  Game game;
  DisplayObjectContainer headcontainer;
  DisplayObjectContainer container;
  
  Scene(this.game, this.headcontainer){
    container = new Sprite();
  }
  
  
  void activate(){
    if(active)
      return;
    
    headcontainer.addChild(container);
    active = true;
  }
  
  void deactivate(){
    if(!active)
      return;

    headcontainer.removeChild(container);
    active = false;
  }
  
  /**
   * add elements to the szene
   */
  void init();
  
  
  /**
   * update the szene
   */
  void update(num ms);
  
  
  
  
  
}