part of colorjam;


class PlayerControlSystem extends EntityProcessingSystem{
  
  
  PlayerControlSystem() : super(Aspect.getAspectForAllOf([PlayerControlComponent, PlayerInputComponent]));
  
  ComponentMapper<PlayerControlComponent> controlMapper;
  ComponentMapper<PlayerInputComponent> inputMapper; 
  
  
  void processEntity(Entity entity){
    PlayerControlComponent control = controlMapper.get(entity);
    PlayerInputComponent input = inputMapper.get(entity);
    
    if(input.leftKeyPressed){
      control.direction = -1;
    }else{
      if(input.rightKeyPressed){
        control.direction = 1;
      }else{
        control.direction = 0;
      }
    }
    
    if(input.jumpKeyPressed){
      control.doJump();
    }
    
    input.leftKeyPressed = false;
    input.rightKeyPressed = false;
    input.jumpKeyPressed = false;
    
  }
  
  
  
}