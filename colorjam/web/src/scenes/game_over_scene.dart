part of colorjam;

class GameOverScene extends Scene {
  GameOverScene(Sprite headContainer, this.level) : super(headContainer);
  TextFormat textFormat = new TextFormat("Arial", 20, Color.Black);
  TextField textField, buttonLabel;
  SimpleButton button = new SimpleButton();
  LevelScene level;
  
  void init() {
    super.init();
    textField = new TextField("You failed!", textFormat);
    
    print("${textField.width} x ${textField.height}");
    
    buttonLabel = new TextField("Restart", textFormat);
    button = new SimpleButton(buttonLabel, buttonLabel, buttonLabel, buttonLabel);
    button.onMouseClick.listen(restartLevel);
    container.addChild(textField);
    container.addChild(button);
  }
  
  void update(num ms) {
    super.update(ms);
  }
  
  void restartLevel(MouseEvent e) {
    deactivate();
    level.init();
    level.activate();
  }
}