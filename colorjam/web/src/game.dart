part of colorjam;



class Game {
  Game(this.stage);
  
  ResourceManager resourceManager = new ResourceManager();
 
  Map<String, Scene> scenes = new Map<String, Scene>();
  Scene scene;
  
  LevelManager levelManager;
  
  Stage stage;
  Sprite mainsprite;
  
  
  
  bool run = false;
  
  num frametime = 10;
  num simtime = 0;
  
  int currentLevel = 0;
  
  /**
   * inits the world and the stage
   */
  void init(){
    
    ///stagexl
    mainsprite = new Sprite();
    stage.addChild(mainsprite);
    stage.focus = mainsprite;
    
    /// loading resources
    
    resourceManager
    
      ///images
      ..addBitmapData("player1", "images/40x65Typ/Typ_1.png")
      ..addBitmapData("player2", "images/40x65Typ/Typ_2.png")
      ..addBitmapData("player3", "images/40x65Typ/Typ_3.png")
      ..addBitmapData("player4", "images/40x65Typ/Typ_4.png")
    
      ..addBitmapData("colorchanger1", "images/colorchanger/colorchanger1.png")
      ..addBitmapData("colorchanger2", "images/colorchanger/colorchanger2.png")
      ..addBitmapData("colorchanger3", "images/colorchanger/colorchanger3.png")
    
      ..addBitmapData("door", "images/door/door.png")
    
      ..addBitmapData("goal0", "images/gate/gate0.png")
      ..addBitmapData("goal1", "images/gate/gate1.png")
      ..addBitmapData("goal2", "images/gate/gate2.png")
      ..addBitmapData("goal3", "images/gate/gate3.png")
      
      
      ..addBitmapData("monster", "images/monster/monster.png")
    
      ..addBitmapData("logo", "images/logo.png")
    
      
    
      ///levels
      ..addTextFile("flat.lvl", "levels/flat.lvl")
      ..addTextFile("bernd1.lvl", "levels/bernd1.lvl")
      ..addTextFile("bernd2.lvl", "levels/bernd2.lvl")
      ..addTextFile("bernd3.lvl", "levels/bernd3.lvl")
      ..addTextFile("bernd4.lvl", "levels/bernd4.lvl")
      ..addTextFile("bernd5.lvl", "levels/bernd5.lvl")
      ..addTextFile("bernd6.lvl", "levels/bernd6.lvl")
      ..addTextFile("bernd7.lvl", "levels/bernd7.lvl")
      ..addTextFile("bernd8.lvl", "levels/bernd8.lvl")
      ..addTextFile("max0.lvl", "levels/max0.lvl")
      ..addTextFile("sebi1.lvl", "levels/Sebi1.lvl")
      ..addTextFile("sebi2.lvl", "levels/Sebi2.lvl")
      ..addTextFile("sebi3.lvl", "levels/Sebi3.lvl")
      ..addTextFile("sebi4.lvl", "levels/Sebi4.lvl")
      ..addTextFile("simon0.lvl", "levels/simon0.lvl")
      ..addTextFile("simon1.lvl", "levels/simon1.lvl")
      ..addTextFile("simon2.lvl", "levels/simon2.lvl")
      ..addTextFile("elevator1.lvl", "levels/elevator1.lvl")
      ..addTextFile("portallevel.lvl", "levels/portallevel.lvl")
      
      ;//resourcemanager
      ///finish loading resources
    
    
    
    List<String> levels = ["flat","simon0","simon1","simon2", "sebi1", "sebi3", "bernd1","bernd2", "bernd3","bernd5","bernd6", "max0","bernd4" ,"bernd7", "bernd8", "elevator1", "portallevel"];
    
    
    levelManager = new LevelManager(levels,resourceManager);
    
    
    
    resourceManager.load().then((m) {
      scenes["mainmenu"] = new MainMenuScene(this, mainsprite)..init();
      scenes["gameoverscene"] = new GameOverScene(this, mainsprite)..init();
      //loadEditor();
      //loadLevel(0);
      //loadLevel(0);
      switchToSzene("mainmenu");
      stage.onEnterFrame.listen(onEnterFrame);
      mainsprite.onKeyDown.listen((KeyboardEvent e) { if(e.keyCode == html.KeyCode.ESC)  switchToSzene("mainmenu");});
    });
  }
  
  void loadNextLevel() {
    loadLevel(currentLevel+1);
  }
  
  void loadLevel(int id){
    currentLevel = id;
    String level = levelManager.getLevel(id);
    if(scenes["level"]!=null){
      scenes["level"].deactivate();
    }
    if(level!=null){
      scenes["level"] = new LevelScene(level, this, mainsprite,false);
          
      scenes["level"].init();
      switchToSzene("level");
    }else{
      currentLevel=0;
      switchToSzene("mainmenu");
    }
    
  }
  
  
  void loadLevelCode(String code){
    if(scenes["level"]!=null){
      scenes["level"].deactivate();
    }
    scenes["level"] = new LevelScene(code, this, mainsprite,true);
    
    scenes["level"].init();
    switchToSzene("level");
  }
  
  void loadEditor(){
    if(scenes["editor"]==null){
      scenes["editor"] = new EditorScene(this,mainsprite);
      scenes["editor"].init();
    }
      
    
    switchToSzene("editor");
  }
  
  void loadEditorFromCode(String code){
    
    if(scenes["editor"]!=null)scenes["editor"].deactivate();
    
    scenes["editor"] = new EditorScene.fromCode(this,mainsprite, code);
    
    switchToSzeneWithInit("editor");
    
  }
  
  
  
  
  void switchToSzene(String scenename){
    if(scene!=null){

      scene.deactivate();
    }
    scene = scenes[scenename];
    scene.activate();
  }
  
  
  void switchToSzeneWithInit(String scenename){
    if(scene!=null){

      scene.deactivate();
    }
    scene = scenes[scenename];
    scene.init();
    scene.activate();
  }
  
  void restartLevel() {
    loadLevel(currentLevel);
    
  }
  
  /**
   * starts the world system
   */
  void start(){
    run = true;
  }
  
  void stop(){
    run = false;
  }
  
  void onEnterFrame(EnterFrameEvent event){
    
    if(run){
      num time = event.passedTime*1000;
      simtime+=time;
      while(simtime>frametime){
        scene.update(frametime);
        simtime -= frametime;
      }
    }
  }
  
}