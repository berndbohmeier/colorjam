part of colorjam;

class ElevatorComponent extends Component {
  
  num speed = 0.3;
 
  
  static const String ARG_SPEED = "speed";
  
  
  
  
  
  
  
    
    
    
  ElevatorComponent.fromJson(Map<String, dynamic> args) {
     if(!args.containsKey(ARG_SPEED))
        throw new ArgumentError("Missing argument $ARG_SPEED");
      
     
     
     
      speed = args[ARG_SPEED];
      
      
  }
  
  String toJson() {
      StringBuffer sb = new StringBuffer();
      sb.write("\"$ARG_SPEED\":$speed");
      return sb.toString();
  }
  
  
  
  ElevatorComponent(this.speed);
  
  
  
}