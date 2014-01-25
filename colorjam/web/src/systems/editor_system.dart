part of colorjam;

class EditorSystem extends EntityProcessingSystem {
  
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<TypeComponent> typeMapper;
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<ColliderComponent> colliderMapper;
  
  Map<Entity, EventStreamSubscription> subscriptionMap = new Map<Entity, EventStreamSubscription>();
  Entity selectedEntity;
  EditorSystem(this.container) : super(Aspect.getAspectForAllOf([TypeComponent, PositionComponent, GeometryComponent, SpriteComponent]));
  
  bool addWallActive = false;
  Entity created;
  
  DisplayObjectContainer container;
  
  bool inGame = false;
  
  
  
  void initialize() {
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    typeMapper = new ComponentMapper<TypeComponent>(TypeComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    colliderMapper = new ComponentMapper<ColliderComponent>(ColliderComponent, world);
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
    container.addChild(overAll);
    
    container.onMouseDown.listen((e) {
      onMouseDown(e);
    });
    
    container.onMouseUp.listen((e) {
      onMouseUp(e);
    });
    
  }
  
  void play() {
    inGame = !inGame;
    html.querySelector("#textout").text = toJson();
  }
  
  void onMouseDown(MouseEvent e) {
    if(addWallActive) {
      if(created == null) {
        Vector clickPosition = new Vector(e.stageX, e.stageY);
        Sprite sprite = new Sprite();
        sprite.graphics.rect(0,0,300,300);
        sprite.graphics.fillColor(0xFF00FF00);
        
        created = world.createEntity()
            ..addComponent(new TypeComponent("Wall"))
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
    entities.add(e);
  }
  
  void removed(Entity e) {
    if(subscriptionMap[e] != null)
      subscriptionMap[e].cancel();
    entities.remove(e);
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
      
      geom.height = (container.stage.mouseY - pos.y).abs() * 2;
      geom.width = (container.stage.mouseX - pos.x).abs() * 2;
      
      spriteComp.sprite.graphics.clear();
      spriteComp.sprite.graphics.rect(0,0,geom.width, geom.height);
      spriteComp.sprite.graphics.fillColor(0xFF00FF00);
    }
  }
  
  void processEntity(Entity e) {
    
    
  }
  
  
  
  Bag<Entity> entities = new Bag();
  
  
  String toJson() {
    StringBuffer sb = new StringBuffer();

    entities.forEach((entity) {
      
      String type = typeMapper.get(entity).type;
      
      switch(type) {
        case "Wall":
          
          ColorComponent cc = colorMapper.getSafe(entity);
          PositionComponent pos = posMapper.get(entity);
          GeometryComponent geom = geomMapper.get(entity);
          ColliderComponent collider = colliderMapper.get(entity);
          num top = pos.y - geom.height/2;
          num bottom = pos.y + geom.height/2;
          num left = pos.x - geom.width/2;
          num right = pos.x + geom.width/2;
          sb.writeln("\"type\":\"Wall\",");
          sb.writeln("\"top\":$top,");
          sb.writeln("\"left\":$left,");
          sb.writeln("\"bottom\":$bottom,");
          sb.writeln("\"right\":$right,");
          if(cc != null)
            sb.writeln(cc.toJson() + ",");
          sb.writeln("\"bounciness\":${collider.bounciness}");
          break;
        case "Player":
          
          ColorComponent cc = colorMapper.getSafe(entity);
          PositionComponent pos = posMapper.get(entity);
          sb.write(pos.toJson());
          if(cc != null)
            sb.writeln(",\n" + cc.toJson() + ",");
          
          break;
      }
    });
    
    return sb.toString();
  }
}