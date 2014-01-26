part of colorjam;



class Game {
  
  
  Game(this.stage);
  
 
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
    
    // loading
    
    resourceManager.addBitmapData("player1", "images/40x65Typ/Typ_1.png");
    resourceManager.addBitmapData("player2", "images/40x65Typ/Typ_2.png");
    resourceManager.addBitmapData("player3", "images/40x65Typ/Typ_3.png");
    resourceManager.addBitmapData("player4", "images/40x65Typ/Typ_4.png");

    resourceManager.addBitmapData("colorchanger1", "images/colorchanger/colorchanger1.png");
    resourceManager.addBitmapData("colorchanger2", "images/colorchanger/colorchanger2.png");
    resourceManager.addBitmapData("colorchanger3", "images/colorchanger/colorchanger3.png");
    
    resourceManager.addBitmapData("door", "images/door/door.png");
    
    resourceManager.addBitmapData("goal", "images/gate/gate0.png");
    
    
    levelManager = new LevelManager([
          """{
          "entities":[
            {
              "type":"Wall",
              "top":500,
              "left": 20,
              "bottom": 530,
              "right": 500,
              "color_r": 0,
              "color_g": 0,
              "color_b": 255,
              "bounciness":0
            },
            {
              "type":"Player",
              "${PositionComponent.ARG_X}":130,
              "${PositionComponent.ARG_Y}":130,
              "color_r":0,
              "color_g":0,
              "color_b":50
             },
            {
              "type":"Goal",
              "${PositionComponent.ARG_X}":430,
              "${PositionComponent.ARG_Y}":450,
              "color_r":0,
              "color_g":0,
              "color_b":255
            }
          ]}""",
          """{
          "entities":[
            {
              "type":"Circle",
              "${PositionComponent.ARG_X}":50,
              "${PositionComponent.ARG_Y}":300,
              "r":10,
              "vx":0.01,
              "vy":0,
              "color_r":255,
              "color_g":0,
              "color_b":0
            },
            {
              "type":"Circle",
              "${PositionComponent.ARG_X}":50,
              "${PositionComponent.ARG_Y}":300,
              "r":10,
              "vx":0.1,
              "vy":-0.5,
              "color_r":0,
              "color_g":255,
              "color_b":0
            },
            {
              "type":"Player",
              "${PositionComponent.ARG_X}":130,
              "${PositionComponent.ARG_Y}":130,
              "color_r":0,
              "color_g":0,
              "color_b":255
             },
              {
              "type":"ColorChanger",
              "${PositionComponent.ARG_X}":50,
              "${PositionComponent.ARG_Y}":450,
              "color_r":255,
              "color_g":0,
              "color_b":0
             },
              {
              "type":"ColorChanger",
              "${PositionComponent.ARG_X}":300,
              "${PositionComponent.ARG_Y}":450,
              "color_r":0,
              "color_g":0,
              "color_b":255
             },
            {
              "type":"Wall",
              "top":500,
              "left": 20,
              "bottom": 530,
              "right": 500,
              "color_r": 0,
              "color_g": 0,
              "color_b": 255,
              "bounciness":0
            }, 
            {
              "type":"Wall",
              "top":500,
              "left": 500,
              "bottom": 530,
              "right": 600,
              "color_r": 255,
              "color_g": 0,
              "color_b": 0,
              "bounciness":0
            },
             {
              "type":"Door",
              "${PositionComponent.ARG_X}":450,
              "${PositionComponent.ARG_Y}":450,
              "color_r": 255,
              "color_g": 0,
              "color_b": 0
            }


          ]
        }"""]);
    
    ///combine artemis and stage
    
    resourceManager.load().then((m) {
      scenes["gameoverscene"] = new GameOverScene(this, mainsprite);
      loadEditor();
      loadLevel(0);
      stage.onEnterFrame.listen(onEnterFrame);
    });
  }
  
  void loadNextLevel() {
    loadLevel(currentLevel+1);
  }
  
  void loadLevel(int id){
    currentLevel = id;
    if(scenes["level"]!=null){
      scenes["level"].deactivate();
    }
    scenes["level"] = new LevelScene(levelManager.getLevel(id), this, mainsprite,false);
    
    scenes["level"].init();
    switchToSzene("level");
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
    num time = event.passedTime*1000;
    simtime+=time;
    if(run){
      while(simtime>frametime){
        scene.update(frametime);
        simtime -= frametime;
      }
    }
  }
  
}