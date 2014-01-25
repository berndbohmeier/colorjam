part of colorjam;

class PositionComponent extends Component {
  static final String ARG_X = "position.x";
  static final String ARG_Y = "position.y";
  Vector position;
  
  PositionComponent(num x, num y) {
    position = new Vector(x, y);
  }
  
  PositionComponent.fromVector(Vector pos) {
    position = pos;
  }
  
  PositionComponent.fromJson(Map<String, dynamic> args) {
    if(!args.containsKey(ARG_X))
        throw new ArgumentError("Missing argument $ARG_X");
    
    if(!args.containsKey(ARG_Y))
      throw new ArgumentError("Missing argument $ARG_Y");
    
    position = new Vector(args[ARG_X] as num, args[ARG_Y] as num);
  }
  
  String toJson() {
    StringBuffer sb = new StringBuffer();
    sb.writeln("\"$ARG_X\":$x,");
    sb.write("\"$ARG_Y\":$y");
    return sb.toString();
  }
  
  num get x => position.x;
  num get y => position.y;
  
  void set x (num nx) {
    position = new Vector(nx, y);
  }
  
  void set y (num ny) {
    position = new Vector(x, ny);
  }
}