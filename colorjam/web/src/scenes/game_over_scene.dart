part of colorjam;

class GameOverScene extends Scene {
  GameOverScene(Game game, Sprite headContainer) : super(game, headContainer);
  TextFormat textFormat = new TextFormat("Arial", 20, Color.Black);
  TextField textField, buttonLabel;
  SimpleButton button = new SimpleButton();
  LevelScene level;
  
  void init() {
    //print("GOS init");
    textField = new TextField("You failed!", textFormat);
    //print("${textField.width} x ${textField.height}");
    
    buttonLabel = new TextField("Restart", textFormat);
    button = new SimpleButton(buttonLabel, buttonLabel, buttonLabel, buttonLabel);
    button.onMouseClick.listen(restartLevel);
    
    button.y = 50;
    container.addChild(textField);
    container.addChild(button);
  }
  
  void activate() {
    super.activate();
    centerInParent(container);
  }
  
  void update(num ms) {}
  
  void restartLevel(MouseEvent e) {
    game.restartLevel();
  }
  
  void centerInParent(DisplayObject obj) {
    DisplayObjectContainer parent = obj.parent;
    print("container: ${obj.x}, ${obj.y}, ${obj.width}, ${obj.height}");
    print("parent: ${parent.x}, ${parent.y}, ${parent.width}, ${parent.height}");
    
    obj.x = parent.width/2 -obj.width/2;
    obj.y = parent.height/2 -obj.height/2;
    
    print("container: ${obj.x}, ${obj.y}, ${obj.width}, ${obj.height}");
  }
}