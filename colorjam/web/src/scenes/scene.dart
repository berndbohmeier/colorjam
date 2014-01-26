part of colorjam;




abstract class Scene{
  
  
  DisplayObjectContainer headcontainer;
  DisplayObjectContainer container;
  
  Scene(this.headcontainer){
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