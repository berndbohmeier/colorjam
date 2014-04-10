part of colorjam;

class PortalComponent extends Component {
  static const int DIRECTION_LEFT = 1, DIRECTION_RIGHT = 2, DIRECTION_TOP = 3, DIRECTION_BOT = 4;
  
  int direction;
  PortalComponent(this.direction);
  
}