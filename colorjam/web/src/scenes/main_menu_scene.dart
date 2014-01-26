part of colorjam;

class MainMenuScene extends Scene {
  MainMenuScene(Game game, DisplayObjectContainer obj) : super(game, obj);
  Button playButton =   new Button("       Play");
  Button editorButton = new Button("Level Editor");
  
  void init() {
    editorButton.y = 30;
    
    playButton.onMouseClick.listen((MouseEvent e) { game.restartLevel(); });
    editorButton.onMouseClick.listen((MouseEvent e) { game.loadEditor(); });
    
    container.addChild(playButton);
    container.addChild(editorButton);
    
    container.x = 400 - container.width / 2;
    container.y = 300 - container.height / 2;
  }
  
  void update(num ms) {}
}