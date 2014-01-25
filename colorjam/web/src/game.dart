part of colorjam;



class Game {
  
  
  Game(this.stage);
  
 
  Scene szene;
  
  LevelManager levelManager;
  
  Stage stage;
  Sprite mainsprite;
  
  
  
  bool run = false;
  
  num frametime = 10;
  num simtime = 0;
  
  /**
   * inits the world and the stage
   */
  void init(){
    
    ///stagexl
    mainsprite = new Sprite();
    stage.addChild(mainsprite);
    stage.focus = mainsprite;
    
    
    
    levelManager = new LevelManager({"default":"""{
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
              "${PositionComponent.ARG_X}":100,
              "${PositionComponent.ARG_Y}":100,
              "color_r":150,
              "color_g":0,
              "color_b":150
             },
            {
              "type":"Wall",
              "top":500,
              "left": 20,
              "bottom": 530,
              "right": 500,
              "color_r": 0,
              "color_g": 255,
              "color_b": 255,
              "bounciness":0
            }
          ]
        }"""});
    
    
    
    
    
    ///combine artemis and stage
    
    stage.onEnterFrame.listen(onEnterFrame);
    
    
    loadLevel("default");
    
    
    
  }
  
  void loadLevel(String levelname){
    if(szene!=null)szene.deactivate();
    //szene = new LevelScene(levelManager.levelMap(levelname), mainsprite);
    szene = new EditorScene(levelManager.levelMap(levelname), mainsprite);
    szene.init();
    szene.activate();
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
        szene.update(frametime);
        simtime -= frametime;
      }
      
    }
  }
  
}