part of colorjam;




class InputControlSystem extends EntitySystem{
  
  
  DisplayObjectContainer dbc;
  
  InputControlSystem(this.dbc): super(Aspect.getAspectForAllOf([PlayerControlComponent, PlayerInputComponent]));
  
  
  List<int> keycodesdown = new List<int>();
  List<int> keycodesup = new List<int>();
  
  ComponentMapper inputMapper;
  
  void initialize() {
    dbc.onKeyDown.listen(_onKeyDown);
    dbc.onKeyUp.listen(_onKeyUp);
    
    
   inputMapper = new ComponentMapper<PlayerInputComponent>(PlayerInputComponent, world);
    
    
  }
  
  void processEntities(Iterable<Entity> entities){
    
    
    
    
    keycodesdown.forEach((int code){
      entities.forEach((Entity entity){
        PlayerInputComponent input = inputMapper.get(entity);
        if(input.leftCode == code){
          input.leftKeyPressed = true;
        }
        if(input.rightCode == code){
          input.rightKeyPressed = true;
        }
        if(input.jumpCode1 == code || input.jumpCode2 == code){
          input.jumpKeyPressed = true;
        }
      });
    });
    
    keycodesup.forEach((int code){
      entities.forEach((Entity entity){
        PlayerInputComponent input = inputMapper.get(entity);
        if(input.leftCode == code){
          input.leftKeyPressed = false;
        }
        if(input.rightCode == code){
          input.rightKeyPressed = false;
        }
        if(input.jumpCode1 == code || input.jumpCode2 == code){
          input.jumpKeyPressed = false;
        }
      });
    });
    
    keycodesdown.clear();
    keycodesup.clear();
  }
  
  void _onKeyDown(KeyboardEvent kevent){
    kevent.stopPropagation();
    keycodesdown.add(kevent.keyCode);
  }
  
  void _onKeyUp(KeyboardEvent kevent){
    kevent.stopPropagation();
    keycodesup.add(kevent.keyCode);
    
   
  }
  
  bool checkProcessing() => true;
}