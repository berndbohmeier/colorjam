part of colorjam;




abstract class Szene{
  
  
  DisplayObjectContainer headcontainer;
  DisplayObjectContainer container;
  
  Szene(this.headcontainer){
    container = new Sprite();
  }
  
  
  void activate(){
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