part of colorjam;

class GameOverScene extends Scene {
  GameOverScene(Game game, Sprite headContainer) : super(game, headContainer);
  TextFormat textFormat = new TextFormat("Arial", 20, Color.Black);
  TextField textField, buttonLabel;
  Button button;
  LevelScene level;
  
  void init() {
    //print("GOS init");
    textField = new TextField("You failed!", textFormat);
    //print("${textField.width} x ${textField.height}");
    
    button = new Button("Restart");
    button.onMouseClick.listen(restartLevel);
    
    button.y = 50;
    container.addChild(textField);
    container.addChild(button);
    
    // 800x600
    container.x = 400 - container.width / 2;
    container.y = 300 - container.height / 2;
  }
  
  void activate() {
    super.activate();
  }
  
  void update(num ms) {}
  
  void restartLevel(MouseEvent e) {
    game.restartLevel();
  }
}