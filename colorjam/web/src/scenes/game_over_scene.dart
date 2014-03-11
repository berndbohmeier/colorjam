part of colorjam;

class GameOverScene extends Scene {
  GameOverScene(Game game, Sprite headContainer) : super(game, headContainer);
  TextFormat textFormat = new TextFormat("Arial", 40, Color.Black, align: "center");
  TextField textField, buttonLabel;
  Button button;
  LevelScene level;
  
  int keyCodeRestartLevel = html.KeyCode.SPACE;
  EventStreamSubscription restartLevelStream = null;
  void init() {
    super.init();
    //print("GOS init");
    textField = new TextField("You failed!", textFormat);
    textField.width = 300;
    //print("${textField.width} x ${textField.height}");
    
    button = new Button("Restart");
    
    button.onMouseClick.listen(restartLevel);
    
    button.y = 80;
    container.addChild(textField);
    container.addChild(button);
    
    // 800x600
    container.x = 400 - container.width / 2;
    container.y = 300 - container.height / 2;
  }
  
  void activate() {
    super.activate();
    restartLevelStream = headcontainer.onKeyDown.listen((e){if(e.keyCode==keyCodeRestartLevel)game.restartLevel();});
    
    
  }
  
  
  void deactivate(){
    super.deactivate();
    if(restartLevelStream!=null){
      restartLevelStream.cancel();
    }
  }
  
  void update(num ms) {}
  
  void restartLevel(MouseEvent e) {
    game.restartLevel();
  }
}