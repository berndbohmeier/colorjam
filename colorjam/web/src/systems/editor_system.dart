part of colorjam;

class EditorSystem extends EntityProcessingSystem {
  
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  
  Map<Entity, EventStreamSubscription> subscriptionMap = new Map<Entity, EventStreamSubscription>();
  Entity selectedEntity;
  EditorSystem(this.stage) : super(Aspect.getAspectForAllOf([PositionComponent, GeometryComponent, SpriteComponent]));
  
  bool addWallActive = false;
  Entity created;
  
  Stage stage;
  
  bool inGame = false;
  
  
  
  void initialize() {
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    html.querySelector("#addwall").onClick.listen((e) {
      
      addWall();
    });
    html.querySelector("#playbutton").onClick.listen((e) {
      play();
    });
    
    Sprite overAll = new Sprite();
    overAll.width = 10000;
    overAll.height = 10000;
    overAll.x = -5000;
    overAll.y = -5000;
    overAll.graphics.rect(0, 0, 10000, 10000);
    overAll.graphics.fillColor(0xFF);
    stage.addChild(overAll);
    
    stage.onMouseDown.listen((e) {
      onMouseDown(e);
    });
    
    stage.onMouseUp.listen((e) {
      onMouseUp(e);
    });
    
  }
  
  void play() {
    inGame = !inGame;
    
  }
  
  void onMouseDown(MouseEvent e) {
    if(addWallActive) {
      if(created == null) {
        Vector clickPosition = new Vector(e.stageX, e.stageY);
        Sprite sprite = new Sprite();
        sprite.graphics.rect(0,0,300,300);
        sprite.graphics.fillColor(0xFF00FF00);
        
        created = world.createEntity()
            ..addComponent(new PositionComponent(clickPosition.x, clickPosition.y))
            ..addComponent(new VelocityComponent(0,0))
            ..addComponent(new SpriteComponent(sprite))
            ..addComponent(new ColliderComponent(bounciness: 0))
            ..addComponent(new GeometryComponent(300,300))
            ..addToWorld();
        
      }
    }
  }
  
  void onMouseUp(MouseEvent e) {
    if(addWallActive && created != null) {
      addWall();
      created = null;
      
    }
  }
  
  void addWall() {
    
    if(addWallActive) {
      Mouse.cursor = MouseCursor.AUTO;
      html.querySelector("#addwall").className = "";
    } else {
      Mouse.cursor = MouseCursor.BUTTON;
      html.querySelector("#addwall").className = "pressed";
    }
    addWallActive = !addWallActive;
  }
  
  void added(Entity e) {
    SpriteComponent spriteComponent = spriteMapper.get(e);
    PositionComponent pos = posMapper.get(e);
    Sprite sprite = spriteComponent.sprite;
    
    subscriptionMap[e] = sprite.onMouseDown.listen((MouseEvent event) {
      selectedEntity = e;
    });
    
    sprite.onMouseUp.listen((MouseEvent event) {
      selectedEntity = null;
    });
    
  }
  
  void removed(Entity e) {
    if(subscriptionMap[e] != null)
      subscriptionMap[e].cancel();
  }
  
  void begin() {
    if(selectedEntity != null) {
      SpriteComponent spriteComponent = spriteMapper.get(selectedEntity);
      PositionComponent pos = posMapper.get(selectedEntity);
      Sprite sprite = spriteComponent.sprite;
      pos.x = sprite.stage.mouseX;
      pos.y = sprite.stage.mouseY;
    }
    
    if(addWallActive && created != null) {
      PositionComponent pos = posMapper.get(created);
      GeometryComponent geom = geomMapper.get(created);
      SpriteComponent spriteComp = spriteMapper.get(created);
      
      geom.height = (stage.mouseY - pos.y).abs() * 2;
      geom.width = (stage.mouseX - pos.x).abs() * 2;
      
      spriteComp.sprite.graphics.clear();
      spriteComp.sprite.graphics.rect(0,0,geom.width, geom.height);
      spriteComp.sprite.graphics.fillColor(0xFF00FF00);
    }
  }
  
  void processEntity(Entity e) {
    
    
  }
  
  void processEntities(ReadOnlyBag<Entity> entities) {
    this.entities = entities;
  }
  
  ReadOnlyBag<Entity> entities;
  
  
  String toJson() {
    StringBuffer sb = new StringBuffer();
    entities.forEach((entity) {
      
    });
  }
}