part of colorjam;

class ElevatorComponent extends Component {
  
  num speed = 0.3;
  bool loop = true;
  int currentWaypoint = 0;
  
  static const String ARG_SPEED = "speed";
  static const String ARG_LOOP = "loop";
  static const String ARG_WAYPOINTS = "waypoints";
  
  final List<Vector> waypoints = new List<Vector>();
  
  
  
  
    
    
    
  ElevatorComponent.fromJson(Map<String, dynamic> args) {
     if(!args.containsKey(ARG_SPEED))
        throw new ArgumentError("Missing argument $ARG_SPEED");
      
     if(!args.containsKey(ARG_LOOP))
        throw new ArgumentError("Missing argument $ARG_LOOP");
     
     if(!args.containsKey(ARG_WAYPOINTS))
             throw new ArgumentError("Missing argument $ARG_WAYPOINTS");
      speed = args[ARG_SPEED];
      loop = args[ARG_LOOP];
      List<List> list= args[ARG_WAYPOINTS];
      for(List v in list){
        if(v.length!=2){
          throw new ArgumentError("$ARG_WAYPOINTS shall be a list of lists with length 2");
        }
        waypoints.add(new Vector(v.elementAt(0), v.elementAt(1)));
      }
  }
  
  String toJson() {
      StringBuffer sb = new StringBuffer();
      sb.writeln("\"$ARG_SPEED\":$speed,");
      sb.writeln("\"$ARG_LOOP\":$loop,");
      sb.write("\"$ARG_WAYPOINTS\":${JSON.encode(new List.from(waypoints.map((v) => [v.x,v.y]))) }");
      return sb.toString();
  }
  
  
  
  ElevatorComponent(this.speed, this.loop);
  
  
  void addWaypoint(num x, num y){
    waypoints.add(new Vector(x, y));
    
  }
  
  void clearWaypoints(){
    waypoints.clear();
  }
  
}