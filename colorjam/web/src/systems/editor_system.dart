part of colorjam;

class EditorSystem extends EntityProcessingSystem {
  
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<TypeComponent> typeMapper;
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<ColliderComponent> colliderMapper;
  ComponentMapper<VelocityComponent> velMapper;
  
  
  Game game;
  
  Map<Entity, EventStreamSubscription> subscriptionMap = new Map<Entity, EventStreamSubscription>();
  Entity selectedEntity;
  EditorSystem(this.game, this.container) : super(Aspect.getAspectForAllOf([TypeComponent, PositionComponent, GeometryComponent, SpriteComponent]));
  
  bool addWallActive = false;
  
  Entity created;
  
  DisplayObjectContainer container;
 
  
  int clickTime = 0;
  
  void initialize() {
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    typeMapper = new ComponentMapper<TypeComponent>(TypeComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    colliderMapper = new ComponentMapper<ColliderComponent>(ColliderComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    html.querySelector("#addwall").onClick.listen((e) {
      
      addWall();
    });
    html.querySelector("#addcolorchanger").onClick.listen((e) {
      addColorChanger();
    });
    html.querySelector("#playbutton").onClick.listen((e) {
      play();
    });
    html.querySelector("#adddoor").onClick.listen((e) {
      addDoor();
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
    game.loadLevelCode(toJson());
  }
  
  void update() {
    html.querySelector("#textout").text = toJson();
  }
  
  void onMouseDown(MouseEvent e) {
    if(addWallActive) {
      if(created == null) {
        Vector clickPosition = new Vector(e.stageX, e.stageY);
        
        created = new EntityFactory.forType("Wall")
          .build(world, {"left": clickPosition.x, "top": clickPosition.y, "right" : clickPosition.x + 30, "bottom" : clickPosition.y + 30, "color_r": 255, "color_g" : 255, "color_b" : 255, "bounciness": 0});
        created.addToWorld();
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
  
  void addColorChanger() {
    new EntityFactory.forType("ColorChanger")
      .build(world, {"position.x": 200, "position.y": 200, "color_r": 255, "color_g" : 0, "color_b" : 0})
      .addToWorld();
  }
  
  void addDoor() {
    new EntityFactory.forType("Door")
      .build(world, {"position.x": 200, "position.y": 200, "color_r": 0, "color_g" : 255, "color_b" : 0})
      .addToWorld();
  }
  
  void added(Entity e) {
    SpriteComponent spriteComponent = spriteMapper.get(e);
    PositionComponent pos = posMapper.get(e);
    TypeComponent type = typeMapper.get(e);
    ColorComponent color = colorMapper.get(e);
    ColliderComponent collider = colliderMapper.get(e);
    VelocityComponent vel = velMapper.get(e);
    Sprite sprite = spriteComponent.sprite;
    
    
    
    subscriptionMap[e] = sprite.onMouseDown.listen((MouseEvent event) {
      selectedEntity = e;
      
      clickTime = new DateTime.now().millisecondsSinceEpoch;
      
      html.querySelector("#typeInput").attributes["value"] = type.type;
      html.ElementList res = html.querySelectorAll(".removable");
      res.forEach((element) => element.remove());
      
      Map<String, Function> setter = new Map<String, Function>();
      Map<String, String> values = new Map<String, String>();
      switch(type.type) {
        case "Wall":
          values["color_r"] = color.r.toString();
          setter["color_r"] = (s) {
            color.r = int.parse(s);
          };
          values["color_g"] = color.g.toString();
          setter["color_g"] = (s) {
            color.g = int.parse(s);
          };
          values["color_b"] = color.b.toString();
          setter["color_b"] = (s) {
            color.b = int.parse(s);
          };
          values["bounciness"] = collider.bounciness.toString();
          setter["bounciness"] = (s) {
            collider.bounciness = int.parse(s);
          };
          break;
        case "Player": case "Goal":
          values["color_r"] = color.r.toString();
          setter["color_r"] = (s) {
            color.r = int.parse(s);
          };
          values["color_g"] = color.g.toString();
          setter["color_g"] = (s) {
            color.g = int.parse(s);
          };
          values["color_b"] = color.b.toString();
          setter["color_b"] = (s) {
            color.b = int.parse(s);
          };
          break;
        case "ColorChanger": case "Door":
          values["color_r"] = color.r.toString();
          setter["color_r"] = (s) {
            color.r = int.parse(s);
          };
          values["color_g"] = color.g.toString();
          setter["color_g"] = (s) {
            color.g = int.parse(s);
          };
          values["color_b"] = color.b.toString();
          setter["color_b"] = (s) {
            color.b = int.parse(s);
          };
          break;
        case "Circle":
          values["color_r"] = color.r.toString();
          setter["color_r"] = (s) {
            color.r = int.parse(s);
          };
          values["color_g"] = color.g.toString();
          setter["color_g"] = (s) {
            color.g = int.parse(s);
          };
          values["color_b"] = color.b.toString();
          setter["color_b"] = (s) {
            color.b = int.parse(s);
          };
          values["velocity_x"] = vel.vx.toString();
          setter["velocity_x"] = (s) {
            vel.vx = double.parse(s);
          };
          values["velocity_y"] = vel.vy.toString();
          setter["velocity_y"] = (s) {
            vel.vy = double.parse(s);
          };
          break;
      }
      
      values.forEach((key, value) {
        html.querySelector("#inspector table").appendHtml("<tr class='removable'><th>$key</th><td><input id='prop_$key' value='$value' /></td></tr>");
        html.querySelector("#prop_$key").onChange.listen((e) {
          
          setter[key]((html.querySelector("#prop_$key") as html.InputElement).value);
          update();
        });
      });
      
      html.querySelector("#inspector").appendHtml("<button id='removeEntity' class='removable'>Remove Item</button>");
      
      if(type.type == "Player" || type.type == "Goal")
        html.querySelector("#removeEntity").hidden = true;
      else {
        html.querySelector("#removeEntity").hidden = false;
        
        html.querySelector("#removeEntity").onClick.listen((event) {
          
          subscriptionMap[e].cancel();
          subscriptionMap[e] = null;
          selectedEntity = null;
          clickTime = 0;
          world.deleteEntity(e);
          entities.remove(e);
          update();
      });
      }
    });
    
    sprite.onMouseUp.listen((MouseEvent event) {
      selectedEntity = null;
      clickTime = 0;
      update();
    });
    entities.add(e);
   
  }
  
  void removed(Entity e) {
    if(subscriptionMap[e] != null)
      subscriptionMap[e].cancel();
    entities.remove(e);
    update();
  }
  
  void begin() {
    if(selectedEntity != null && new DateTime.now().millisecondsSinceEpoch - clickTime > 200) {
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
      spriteComp.sprite.width = geom.width;
      spriteComp.sprite.height = geom.height;
      spriteComp.width = geom.width;
      spriteComp.height = geom.height;
      spriteComp.sprite.removeCache();
      spriteComp.sprite.applyCache(-7, -5, spriteComp.sprite.width.round()+7, spriteComp.sprite.height.round()+5);
      
      spriteComp.sprite.graphics.clear();
      spriteComp.sprite.graphics.rect(0,0,geom.width, geom.height);
      spriteComp.sprite.graphics.fillColor(0xFFFFFFFF);
      spriteComp.sprite.graphics.strokeColor(Color.Black, 3);
    }
  }
  
  void processEntity(Entity e) {
    
    
  }
  
  
  
  Bag<Entity> entities = new Bag();
  
  
  String toJson() {
    StringBuffer sb = new StringBuffer();

    sb.writeln("{)
    entities.forEach((entity) {
      
      String type = typeMapper.get(entity).type;
      if(!type.contains(new RegExp("(Wall)|(Player)|(ColorChanger)|(Door)|(Goal)")))
          return;
      sb.writeln("{");
      
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
       case "Player": case "Goal":
          
          ColorComponent cc = colorMapper.getSafe(entity);
          PositionComponent pos = posMapper.get(entity);
          if(type == "Player")
            sb.writeln("\"type\":\"Player\",");
          else
            sb.writeln("\"type\":\"Goal\",");
          sb.write(pos.toJson());
          if(cc != null)
            sb.writeln(",\n" + cc.toJson());
          
          break;
       case "ColorChanger": case "Door":
           ColorComponent cc = colorMapper.getSafe(entity);
           PositionComponent pos = posMapper.get(entity);
           if(type == "Door")
             sb.writeln("\"type\":\"Door\",");
           else
             sb.writeln("\"type\":\"ColorChanger\",");
           sb.write(pos.toJson());
           if(cc != null)
             sb.writeln(",\n" + cc.toJson());
         break;
      }
      sb.writeln("},");
    });
    String output = sb.toString();
    return output.substring(0, output.length - 2);
  }
}