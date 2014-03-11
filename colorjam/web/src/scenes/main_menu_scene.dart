part of colorjam;

class MainMenuScene extends Scene {
  MainMenuScene(Game game, DisplayObjectContainer obj) : super(game, obj);
  Button playButton =   new Button("Play");
  Button editorButton = new Button("Level Editor");
  Sprite logo = new Sprite();
  
  void init() {
    super.init();
    editorButton.y = 50;
    logo.addChild(new Bitmap(game.resourceManager.getBitmapData("logo")));
    logo.scaleX = 1.3;
    logo.scaleY = 1.3;
    
    playButton.onMouseClick.listen((MouseEvent e) { game.restartLevel(); });
    editorButton.onMouseClick.listen((MouseEvent e) { game.loadEditor(); });
    
    logo.x = -120;
    logo.y = -120;
    container.addChild(playButton);
    container.addChild(editorButton);
    container.addChild(logo);
    
    container.x = 400 - playButton.width/2;
    container.y = 300 - 50;
  }
  
  void update(num ms) {}
}