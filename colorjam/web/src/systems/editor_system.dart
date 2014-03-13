part of colorjam;

class EditorSystem extends EntityProcessingSystem {
  
  ComponentMapper<SpriteComponent> spriteMapper;
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<GeometryComponent> geomMapper;
  ComponentMapper<TypeComponent> typeMapper;
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<ColliderComponent> colliderMapper;
  ComponentMapper<VelocityComponent> velMapper;
  ComponentMapper<ElevatorComponent> elevatorMapper;
  
  
  Game game;
  
  Map<Entity, EventStreamSubscription> subscriptionMap = new Map<Entity, EventStreamSubscription>();
  Entity selectedEntity;
  EditorSystem(this.game, this.container) : super(Aspect.getAspectForAllOf([TypeComponent, PositionComponent, GeometryComponent, SpriteComponent]));
  
  bool addWallActive = false;
  
  Entity created;
  
  DisplayObjectContainer container;
  
  html.DivElement div;
  
  html.TextAreaElement textArea;
 
  
  int clickTime = 0;
  
  List subscriptions = new List();
  
  
  void setUpInputs(){
    subscriptions.add(html.querySelector("#addwall").onClick.listen((e) {
          
          addWall();
        }));
    subscriptions.add(html.querySelector("#addcolorchanger").onClick.listen((e) {
          addColorChanger();
        }));
    subscriptions.add(html.querySelector("#playbutton").onClick.listen((e) {
          play();
        }));
    subscriptions.add(html.querySelector("#adddoor").onClick.listen((e) {
          addDoor();
        }));
    subscriptions.add(html.querySelector("#addelevator").onClick.listen((e) {
              addElevator();
            }));
    subscriptions.add(html.querySelector("#recreate").onClick.listen((e) {
          recreate();
        }));
        
    subscriptions.add(container.onMouseDown.listen((e) {
             onMouseDown(e);
        }));
    subscriptions.add(container.onMouseUp.listen((e) {
           onMouseUp(e);
        }));
  }
  
  void cancelInputs(){
    subscriptions.forEach((sub){sub.cancel();});
  }
  
  void initialize() {
    spriteMapper = new ComponentMapper<SpriteComponent>(SpriteComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
    geomMapper = new ComponentMapper<GeometryComponent>(GeometryComponent, world);
    typeMapper = new ComponentMapper<TypeComponent>(TypeComponent, world);
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    colliderMapper = new ComponentMapper<ColliderComponent>(ColliderComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    elevatorMapper = new ComponentMapper<ElevatorComponent>(ElevatorComponent, world);
    
    div = html.querySelector("#sample_container_id");
    
    textArea = html.querySelector("#textout");
    Sprite overAll = new Sprite();
    overAll.width = 2000;
    overAll.height = 2000;
    overAll.x = 0;
    overAll.y = 0;
    overAll.graphics.rect(0, 0, 2000, 2000);
    overAll.graphics.fillColor(0xFF);
    container.addChild(overAll);
    
   
    
  }
  
  void play() {
    game.loadLevelCode(textArea.value);
    html.Element canvas = html.querySelector('#stage');
    canvas.focus();
  }
  
  void recreate() {
    game.loadEditorFromCode(textArea.value);
  }
  
  
  
  void update() {
    textArea = html.querySelector("#textout");
    textArea.value = toJson();
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
      .build(world, {"position.x": div.scrollLeft+ 200, "position.y": div.scrollTop + 200, "color_r": 255, "color_g" : 0, "color_b" : 0})
      .addToWorld();
  }
  
  void addDoor() {
    new EntityFactory.forType("Door")
      .build(world, {"position.x": div.scrollLeft+ 200, "position.y": div.scrollTop + 200, "color_r": 0, "color_g" : 255, "color_b" : 0})
      .addToWorld();
  }
  
  void addElevator(){
    new EntityFactory.forType("Elevator")
          .build(world, {"position.x": div.scrollLeft+ 200, "position.y": div.scrollTop + 200, "color_r": 0,
            "color_g" : 255, "color_b" : 0, "bounciness":0, "loop" : true, "speed":0.1, "waypoints":[[div.scrollLeft+ 200,div.scrollTop + 200]]})
          .addToWorld();
  }
  
  void inserted(Entity e) {
    SpriteComponent spriteComponent = spriteMapper.getSafe(e);
    PositionComponent pos = posMapper.getSafe(e);
    TypeComponent type = typeMapper.getSafe(e);
    ColorComponent color = colorMapper.getSafe(e);
    ColliderComponent collider = colliderMapper.getSafe(e);
    VelocityComponent vel = velMapper.getSafe(e);
    ElevatorComponent elevator = elevatorMapper.getSafe(e);
    Sprite sprite = new Sprite();
    spriteComponent.dbo.removeFromParent();
    sprite.addChild(spriteComponent.dbo);
    container.addChild(sprite);
    
    
    
    subscriptionMap[e] = sprite.onMouseDown.listen((MouseEvent event) {
      selectedEntity = e;
      
      clickTime = new DateTime.now().millisecondsSinceEpoch;
      
      html.querySelector("#typeInput").attributes["value"] = type.type;
      html.ElementList res = html.querySelectorAll(".removable");
      res.forEach((element) => element.remove());
      
      Map<String, Function> setter = new Map<String, Function>();
      Map<String, dynamic> values = new Map<String, dynamic>();
      
      if(color!=null){
        
      
        values["color_r"] = color.r.toString();
        setter["color_r"] = (s) {color.r = int.parse(s);};
        
        values["color_g"] = color.g.toString();
        setter["color_g"] = (s) {color.g = int.parse(s);};
        
        values["color_b"] = color.b.toString();
        setter["color_b"] = (s) {color.b = int.parse(s);};
      }
      
      if(collider!=null){
        values["bounciness"] = collider.bounciness.toString();
        setter["bounciness"] = (s) {collider.bounciness = double.parse(s);};
      }
                
      if(elevator!=null){
        values["speed"] = elevator.speed.toString();
        setter["speed"] = (s) {elevator.speed = double.parse(s);  };
        
        values["loop"] = elevator.loop;
        setter["loop"] = (b) {elevator.loop = b;  };
                  
        values["waypoints"] = elevator.waypoints;
        setter["waypoints"] = (i) {elevator.currentWaypoint = i;pos.position = new Vector(elevator.waypoints.elementAt(elevator.currentWaypoint).x, elevator.waypoints.elementAt(elevator.currentWaypoint).y) ; };            
                    
      }
      
      
      values.forEach((key, value) {
        if(value is String){
          html.querySelector("#inspector table tr.first").insertAdjacentHtml("afterEnd","<tr class='removable'><th>$key</th><td><input id='prop_$key' value='$value' /></td></tr>");
          html.querySelector("#prop_$key").onChange.listen((e) {
                              setter[key]((html.querySelector("#prop_$key") as html.InputElement).value);
                              update();
                            });
          
          
        }
        if(value is bool){
          html.querySelector("#inspector table tr.first").insertAdjacentHtml("afterEnd","<tr class='removable'><th>$key</th><td><input type='checkbox' id='prop_$key' name='$key'value='$key' ${value?"checked":""}/></td></tr>");
          html.querySelector("#prop_$key").onChange.listen((e) {
                                       setter[key]((html.querySelector("#prop_$key") as html.InputElement).checked);
                                       update();
                                     });
        }
        if(value is List){
          StringBuffer sb = new StringBuffer();
          for(int i = 0; i < (value as List).length; i++){
            sb.write("<option value='$i' ${(i==elevator.currentWaypoint)?"selected":""} >$i</option>");  
          }
          html.querySelector("#inspector table tr.first").insertAdjacentHtml("afterEnd","<tr class='removable'><th>$key</th><td><select id='prop_$key'>${sb.toString()}</select><button id='prop_$key"+"_add' >+</button><button id='prop_$key"+"_del' >-</button></td></tr>");
          html.querySelector("#prop_$key").onChange.listen((e) {
                                                 setter[key]((html.querySelector("#prop_$key") as html.SelectElement).selectedIndex);
                                               });
          html.querySelector("#prop_$key"+"_add").onClick.listen((e){elevator.waypoints.add(new Vector(pos.x, pos.y));
                                                                  elevator.currentWaypoint = elevator.waypoints.length-1;
                                                                  (html.querySelector("#prop_$key") as html.SelectElement).children.add(new html.OptionElement(data:elevator.currentWaypoint.toString(), value : elevator.currentWaypoint.toString()));
                                                                  (html.querySelector("#prop_$key") as html.SelectElement).selectedIndex = elevator.currentWaypoint;});
          html.querySelector("#prop_$key"+"_del").onClick.listen((e){elevator.waypoints.removeLast();
                                                                      elevator.currentWaypoint = elevator.waypoints.length-1;
                                                                      (html.querySelector("#prop_$key") as html.SelectElement).children.removeLast();
                                                                      (html.querySelector("#prop_$key") as html.SelectElement).selectedIndex = elevator.currentWaypoint;});
          
        }
        
        
        
      });
      
      html.querySelector("#inspector table").insertAdjacentHtml("afterEnd","<button id='removeEntity' class='removable'>Remove Item</button>");
      
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
      DisplayObject dbo = spriteComponent.dbo;
      
      pos.x = dbo.stage.mouseX;
      pos.y = dbo.stage.mouseY;
      
      ElevatorComponent elevator = elevatorMapper.getSafe(selectedEntity);
      if(elevator!=null){
        elevator.waypoints[elevator.currentWaypoint] = new Vector(pos.x, pos.y);
    
      }
    }
    
    if(addWallActive && created != null) {
      PositionComponent pos = posMapper.get(created);
      GeometryComponent geom = geomMapper.get(created);
      SpriteComponent spriteComp = spriteMapper.get(created);
      
      geom.height = (container.stage.mouseY - pos.y).abs() * 2;
      geom.width = (container.stage.mouseX - pos.x).abs() * 2;
  
      
      BitmapHelper.createRectangle(geom.width.round(), geom.height.round(), spriteComp.dbo as Sprite);
     
      spriteComp.width = geom.width;
      spriteComp.height = geom.height;
      
      
      
    }
  }
  
  void processEntity(Entity e) {
    
    
  }
  
  
  
  Bag<Entity> entities = new Bag();
  
  
  String toJson() {
    bool firstEntity = true;
    StringBuffer sb = new StringBuffer();


    sb.writeln("""{"entities":[""");

    entities.forEach((entity) {
      
      String type = typeMapper.get(entity).type;
      if(!type.contains(new RegExp("(Wall)|(Player)|(ColorChanger)|(Door)|(Goal)|Elevator")))
          return;
      if(firstEntity){
        firstEntity=false;
      }else {
        sb.writeln(",");
      }
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
         case "Elevator":
             ColorComponent cc = colorMapper.getSafe(entity);
             PositionComponent pos = posMapper.get(entity);
             ColliderComponent collider = colliderMapper.get(entity);
             ElevatorComponent elevator = elevatorMapper.getSafe(entity);
             sb.writeln("\"type\":\"Elevator\",");
             sb.write(pos.toJson());
             sb.writeln(",\n" + cc.toJson()+",");
             sb.writeln("\"bounciness\":${collider.bounciness},");
             sb.writeln(elevator.toJson());
             break;
                  
         
      }
      sb.writeln("}");
    });
    sb.writeln( " ]} ");
    return sb.toString();
  }
}