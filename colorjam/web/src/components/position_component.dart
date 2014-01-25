part of colorjam;

class PositionComponent extends Component {
  Vector position;
  
  PositionComponent(num x, num y) {
    position = new Vector(x, y);
  }
  
  PositionComponent.fromVector(Vector pos) {
    position = pos;
  }
  
  num get x => position.x;
  num get y => position.y;
}