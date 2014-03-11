part of colorjam;




abstract class Scene{
  bool active = false;
  Game game;
  DisplayObjectContainer headcontainer;
  DisplayObjectContainer container;
  
  Scene(this.game, this.headcontainer){
  }
  
  
  /**
   * is called when switching to this scene
   * activate all stuff this szene need when it is displayed
   * dont forget to call super.activate() when overriding this method
   */
  void activate(){
    if(active)
      return;
    
    headcontainer.addChild(container);
    active = true;
  }
  
  /**
   * is called when switching to another scene
   * deactivate all stuff you activated in activate()
   * dont forget to call super.deactivate() when overriding this method
   */
  void deactivate(){
    if(!active)
      return;

    headcontainer.removeChild(container);
    active = false;
  }
  
  /**
   * add elements to the szene
   */
  void init(){
    container = new Sprite();
  }
  
  
  /**
   * update the szene
   */
  void update(num ms);
  
  
  
  
  
}