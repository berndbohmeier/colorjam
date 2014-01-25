part of colorjam;

class Position extends Component {
  Vector position;
  
  Position(num x, num y) {
    position = new Vector(x, y);
  }
  
  Position.fromVector(Vector pos) {
    position = pos;
  }
  
  num get x => position.x;
  num get y => position.y;
}