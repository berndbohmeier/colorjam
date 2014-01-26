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
    
    resourceManager.addBitmapData("logo", "images/logo.png");
    
    
    levelManager = new LevelManager([
          /* flat level */
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
              "color_b":255
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
          /* simon0 */
          """{"entities":[
{ 
"type":"Player",
"position.x":166,
"position.y":425.6666717529297,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":740,
"position.y":412.6666717529297,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":462.6666717529297,
"left":97,
"bottom":508.6666717529297,
"right":811,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":342.6666717529297,
"left":-113,
"bottom":388.6666717529297,
"right":503,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":117,
"position.y":291.6666717529297,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":260.6666717529297,
"left":806,
"bottom":508.6666717529297,
"right":844,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
 ]} 

""",
/* simon1 */
"""{"entities":[
{
"type":"Player",
"position.x":165,
"position.y":796.6666870117188,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":911,
"position.y":554.6666717529297,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"Wall",
"top":831.6666870117188,
"left":124,
"bottom":877.6666870117188,
"right":838,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":712.6666717529297,
"left":-29,
"bottom":758.6666717529297,
"right":587,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":104,
"position.y":660.6666717529297,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":260.6666717529297,
"left":771,
"bottom":508.6666717529297,
"right":809,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":604.6666717529297,
"left":521,
"bottom":638.6666717529297,
"right":953,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":308,
"position.y":459.6666717529297,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"Door",
"position.x":788,
"position.y":554.6666717529297,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"Wall",
"top":510.6666717529297,
"left":136,
"bottom":530.6666717529297,
"right":528,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
 ]} 

""",
/* simon2 */
"""{"entities":[
{
"type":"Player",
"position.x":148,
"position.y":882.6666870117188,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":440,
"position.y":539.6666870117188,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":915.6666870117188,
"left":125,
"bottom":951.6666870117188,
"right":349,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":807.6666870117188,
"left":302,
"bottom":843.6666870117188,
"right":554,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":699.6666870117188,
"left":25,
"bottom":733.6666870117188,
"right":329,
"color_r":0,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":589.6666870117188,
"left":291,
"bottom":627.6666870117188,
"right":497,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":498,
"position.y":755.6666717529297,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":74,
"position.y":647.6666870117188,
"color_r":0,
"color_g":0,
"color_b":255
}
 ]} 

""",
/* sebi1 */
"""
{"entities":[
{
"type":"Player",
"position.x":50,
"position.y":300,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":630.8888874053955,
"position.y":353.27777779102325,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"ColorChanger",
"position.x":313.8888874053955,
"position.y":354.27777779102325,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":405.83333587646484,
"left":-29.111112594604492,
"bottom":481.83333587646484,
"right":370.8888874053955,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":405.83333587646484,
"left":364.8888874053955,
"bottom":481.83333587646484,
"right":832.8888874053955,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
 ]} """,
 /* sebi2 *//*
 """{"entities":[
{
"type":"Player",
"position.x":50,
"position.y":300,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":123.88888740539551,
"position.y":471.27777779102325,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":340.7222213745117,
"left":18.888887405395508,
"bottom":373.8333342075348,
"right":620.8888874053955,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":521.9444580078125,
"left":66.88888740539551,
"bottom":607.9444580078125,
"right":1156.8888874053955,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":168.8888874053955,
"position.y":290.83333587646484,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":277.7222213745117,
"left":468.888916015625,
"bottom":310.8333342075348,
"right":1084.888916015625,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":375.83333671092987,
"left":17.888887405395508,
"bottom":540.9444495439529,
"right":65.88888740539551,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
 ]} 

""",*/
/* sebi3 */
"""{"entities":[
{
"type":"Player",
"position.x":97.66666603088379,
"position.y":868.8333435058594,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":707.6666660308838,
"position.y":865.8333435058594,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":244.16668701171875,
"left":406.6666660308838,
"bottom":918.1666870117188,
"right":436.6666660308838,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":917.1666870117188,
"left":-55.33333396911621,
"bottom":953.1666870117188,
"right":1168.6666660308838,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":801.1666870117188,
"left":278.6666660308838,
"bottom":825.1666870117188,
"right":408.6666660308838,
"color_r":0,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":692.1666870117188,
"left":31.66666603088379,
"bottom":726.1666870117188,
"right":191.6666660308838,
"color_r":0,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":571.8333435058594,
"left":239.6666660308838,
"bottom":605.8333435058594,
"right":409.6666660308838,
"color_r":0,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":462.8333333283663,
"left":-45.33333396911621,
"bottom":500.8333333283663,
"right":192.6666660308838,
"color_r":0,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":336.8333333283663,
"left":174.6666660308838,
"bottom":368.8333333283663,
"right":400.6666660308838,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":176.6666660308838,
"position.y":864.8333435058594,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":228.6666660308838,
"position.y":283.8333333283663,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":308.16666412353516,
"left":340.6666660308838,
"bottom":335.5000025331974,
"right":404.6666660308838,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
 ]} 
""",
/* bernd1 */
"""{"entities":[
{
"type":"Player",
"position.x":58,
"position.y":489.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":694,
"position.y":508.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":929.5,
"left":18,
"bottom":973.5,
"right":772,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":69,
"position.y":876.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":719,
"position.y":877.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":812.5,
"left":448,
"bottom":854.5,
"right":560,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":705.5,
"left":278,
"bottom":753.5,
"right":388,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":617.5,
"left":453,
"bottom":667.5,
"right":565,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
 ]} 

""",
/* bernd2 */
"""{"entities":[
{
"type":"Player",
"position.x":49,
"position.y":84.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":714,
"position.y":561.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":620.5,
"left":-340,
"bottom":660.5,
"right":870,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":54,
"position.y":566.5,
"color_r":255,
"color_g":0,
"color_b":0
}
 ]} 
""",
/* bernd3 */
"""
{"entities":[
{
"type":"Player",
"position.x":52,
"position.y":624.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":407,
"position.y":609.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":663.5,
"left":12,
"bottom":689.5,
"right":786,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":60,
"position.y":610.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":61,
"position.y":475.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":528.5,
"left":6,
"bottom":560.5,
"right":382,
"color_r":0,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":528.5,
"left":435,
"bottom":560.5,
"right":809,
"color_r":0,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":521.5,
"left":376,
"bottom":559.5,
"right":438,
"color_r":255,
"color_g":255,
"color_b":0,
"bounciness":0
}
,
{
"type":"Door",
"position.x":209,
"position.y":476.5,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"Wall",
"top":384.5,
"left":5,
"bottom":426.5,
"right":287,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":451.5,
"left":453,
"bottom":481.5,
"right":517,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":382.5,
"left":536,
"bottom":416.5,
"right":594,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":395.5,
"left":-11,
"bottom":685.5,
"right":15,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":560.5,
"left":288,
"bottom":598.5,
"right":360,
"color_r":255,
"color_g":0,
"color_b":0,
"bounciness":0
}
,
{
"type":"Wall",
"top":314.5,
"left":605,
"bottom":342.5,
"right":703,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":651,
"position.y":260.5,
"color_r":0,
"color_g":255,
"color_b":0
}
 ]} 

""",
/* max0 */
          """{"entities":[
{
"type":"Player",
"position.x":236,
"position.y":414.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Goal",
"position.x":539,
"position.y":390.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":236,
"position.y":395.5,
"color_r":255,
"color_g":0,
"color_b":0
}
,
{
"type":"Wall",
"top":450.5,
"left":193,
"bottom":474.5,
"right":597,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Door",
"position.x":464,
"position.y":398.5,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"Wall",
"top":315.5,
"left":451,
"bottom":337.5,
"right":591,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":330.5,
"left":600,
"bottom":464.5,
"right":618,
"color_r":255,
"color_g":255,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":619.5,
"left":255,
"bottom":649.5,
"right":743,
"color_r":255,
"color_g":0,
"color_b":255,
"bounciness":0
}
,
{
"type":"ColorChanger",
"position.x":683,
"position.y":564.5,
"color_r":0,
"color_g":255,
"color_b":0
}
,
{
"type":"ColorChanger",
"position.x":342,
"position.y":567.5,
"color_r":0,
"color_g":0,
"color_b":255
}
,
{
"type":"Wall",
"top":520.5,
"left":771,
"bottom":556.5,
"right":809,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
,
{
"type":"Wall",
"top":413.5,
"left":638,
"bottom":447.5,
"right":674,
"color_r":0,
"color_g":0,
"color_b":255,
"bounciness":0
}
 ]} """]);
    
    ///combine artemis and stage
    
    resourceManager.load().then((m) {
      scenes["mainmenu"] = new MainMenuScene(this, mainsprite);
      scenes["gameoverscene"] = new GameOverScene(this, mainsprite);
      loadEditor();
      //loadLevel(0);
      //loadLevel(0);
      switchToSzeneWithInit("mainmenu");
      stage.onEnterFrame.listen(onEnterFrame);
      mainsprite.onKeyDown.listen((KeyboardEvent e) { if(e.keyCode == html.KeyCode.ESC)  switchToSzene("mainmenu");});
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