part of colorjam;


class PlayerInputComponent extends Component{
  
  bool leftKeyPressed = false;
  bool rightKeyPressed = false;
  bool jumpKeyPressed = false;
  
  int leftCode;
  int rightCode;
  int jumpCode;
  
  PlayerInputComponent(this.leftCode, this.rightCode,this.jumpCode);
}