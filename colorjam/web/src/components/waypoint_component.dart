part of colorjam;

class WaypointComponent extends Component {
  
  int currentWaypoint = 0;
  bool loop = true;
  
  static const String ARG_WAYPOINTS = "waypoints";
  static const String ARG_LOOP = "loop";
  
  final List<Vector> waypoints = new List<Vector>();
  
  
  
  
    
    
    
  WaypointComponent.fromJson(Map<String, dynamic> args) {
     
     
     if(!args.containsKey(ARG_WAYPOINTS))
             throw new ArgumentError("Missing argument $ARG_WAYPOINTS");
     if(!args.containsKey(ARG_LOOP))
             throw new ArgumentError("Missing argument $ARG_LOOP");
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
      sb.writeln("\"$ARG_WAYPOINTS\":${JSON.encode(new List.from(waypoints.map((v) => [v.x,v.y]))) },");
      sb.write("\"$ARG_LOOP\":$loop");
      return sb.toString();
  }
  
  
  
  WaypointComponent();
  
  
  void addWaypoint(num x, num y){
    waypoints.add(new Vector(x, y));
    
  }
  
  Vector getCurrentWaypoint(){
    return waypoints.elementAt(currentWaypoint);
  }
  
  void clearWaypoints(){
    waypoints.clear();
  }
  
  void nextWaypoint(){
    currentWaypoint++;
    if(currentWaypoint >= waypoints.length){
          if(loop){
            currentWaypoint = 0;
          }
    }
  }
  
  
}