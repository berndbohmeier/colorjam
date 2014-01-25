part of colorjam;



class PlayerControlComponent extends Component{
  
  ///direction to move
  int direction = 0;
  ///jump next frame
  bool jump = false;
  
  
  
  void doJump(){
    jump = true;
  }
  
  void runRight(){
    direction = 1;
  }
  
  void runLeft(){
    direction = -1;
  }
  
  void stop(){
    direction = 0;
  }
  
  
}