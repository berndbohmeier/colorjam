part of colorjam;


class PortalSystem extends InteractionSystem {
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<PortalComponent> portalMapper;
  ComponentMapper<PositionComponent> posMapper;
  ComponentMapper<VelocityComponent> velMapper;

  
  CollectEntitiesSystem portals;
  
  static int d = 50;
  
  PortalSystem(CollectEntitiesSystem players, CollectEntitiesSystem portals) : super(players, Aspect.getAspectForAllOf([PortalComponent, ColorComponent, PositionComponent])), portals = portals;
  
  void initialize() {
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    portalMapper = new ComponentMapper<PortalComponent>(PortalComponent, world);
    velMapper = new ComponentMapper<VelocityComponent>(VelocityComponent, world);
    posMapper = new ComponentMapper<PositionComponent>(PositionComponent, world);
  }
  
  void processInteraction(Entity portal1, Entity player) {
    ColorComponent portal1Color = colorMapper.get(portal1);
    ColorComponent playerColor = colorMapper.get(player);
    PortalComponent portal1Comp = portalMapper.get(portal1);
    PositionComponent portal1Position = posMapper.get(portal1);
    PositionComponent playerPosition = posMapper.get(player);
    VelocityComponent playerVelocity = velMapper.get(player);
    
    Entity portal2 = null;
    
    List<List<int> >colors = [[0,playerColor.nr],[1,playerColor.nb], [2,playerColor.ng]];
    List<int> pcolors = [portal1Color.nr,portal1Color.nb, portal1Color.ng];
    
    
    colors.sort((e1,e2){ return e1[1].compareTo(e2[1]);} );
    
    int index = -1;
    
    
    for(List<int> color in colors.reversed){
      if(color[1]<=0){
        break;
      }
      if(pcolors[color[0]]>0){
        index = color[0];
        break;
      }
    }
    
    
    
    if(index < 0){
      return;
    }
    
    for(Entity portal in portals.entities){
      if(portal.uniqueId == portal1.uniqueId){
        continue;
      }
      ColorComponent portalColor = colorMapper.get(portal);
      if([portalColor.nr,portalColor.nb, portalColor.ng][index]>0){
        portal2 = portal;
        break;
      }
    }
    
    if(portal2==null){
      portal2 = portal1;
    }
    
    
    bool infront = false;
    
    
    switch(portal1Comp.direction){
      case PortalComponent.DIRECTION_LEFT:
        if(portal1Position.position.x > playerPosition.position.x) infront = true;
        break;
      case PortalComponent.DIRECTION_RIGHT:
        if(portal1Position.position.x < playerPosition.position.x) infront = true;
        break;
      case PortalComponent.DIRECTION_TOP:
        if(portal1Position.position.y > playerPosition.position.y) infront = true;
        break;
      case PortalComponent.DIRECTION_BOT:
        if(portal1Position.position.y < playerPosition.position.y) infront = true;
        break;
    }
    
    PortalComponent portal2Comp = portalMapper.get(portal2);
    PositionComponent portal2position = posMapper.get(portal2);
    
    
    
    num dx = 0;
    num dy = 0;
    
    switch(portal2Comp.direction){
          case PortalComponent.DIRECTION_LEFT:
            if(infront){
              dx =  d;
              
            }else{
              dx =  - d;
            }
            dy = playerPosition.y-portal1Position.y;
            break;
          case PortalComponent.DIRECTION_RIGHT:
            if(infront){
                        dx =  - d;
                          
                        }else{
                          dx =  d;
                        }
                        dy = playerPosition.y-portal1Position.y;
                        break;
          case PortalComponent.DIRECTION_TOP:
            if(infront){
                          dy = d;
                          
                        }else{
                          dy =  - d;
                        }
                        dx = playerPosition.x-portal1Position.x;
                        break;
          case PortalComponent.DIRECTION_BOT:
            if(infront){
                          dy = - d;
                          
                        }else{
                          dy = d;
                        }
                        dx = playerPosition.x-portal1Position.x;
                        break;
        }
    
    playerPosition.x = portal2position.x + dx;
    playerPosition.y = portal2position.y + dy;
    
    if((portal1Comp.direction == PortalComponent.DIRECTION_BOT && portal2Comp.direction == PortalComponent.DIRECTION_TOP) ||
      (portal2Comp.direction == PortalComponent.DIRECTION_BOT && portal1Comp.direction == PortalComponent.DIRECTION_TOP)){
      playerVelocity.vy = -playerVelocity.vy;    
    
    }
    
  }
  
  void processNonInteraction(Entity goal, Entity player){
    
  }
  
}