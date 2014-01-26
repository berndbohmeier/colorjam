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
    container.addChild(textField);
    container.addChild(button);
    centerInParent(textField);
  }
  
  void update(num ms) {}
  
  void restartLevel(MouseEvent e) {
    game.restartLevel();
  }
  
  void centerInParent(DisplayObject obj) {
    DisplayObjectContainer parent = obj.parent;
    obj.x = parent.x + parent.width/2 -obj.width/2;
    obj.y = parent.y + parent.height/2 -obj.height/2;
  }
}