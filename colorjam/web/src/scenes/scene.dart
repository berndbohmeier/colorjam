part of colorjam;




abstract class Scene{
  
  Game game;
  DisplayObjectContainer headcontainer;
  DisplayObjectContainer container;
  
  Scene(this.game, this.headcontainer){
    container = new Sprite();
  }
  
  
  void activate(){
    print("activate");
    headcontainer.addChild(container);
  }
  
  void deactivate(){
    headcontainer.removeChild(container);
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