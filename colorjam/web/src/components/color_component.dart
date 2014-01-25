part of colorjam;

class ColorComponent extends Component {
  static const String ARG_R = "color_r";
  static const String ARG_G = "color_g";
  static const String ARG_B = "color_b";
  
  bool vanishing = true;
  
  int get colorcode => (255 << 24) | (nr.round() << 16) | (ng << 8) | nb;
  
  num _r = 0, _b = 0, _g = 0;
  
  ColorComponent(int r, int g, int b) {
    _r=r;_g=g;_b=b;
  }
  
  
  
  ColorComponent.fromInt(int colorcode){
    _r= (colorcode >> 16) & 255;
    _g= (colorcode >> 8) & 255;
    _b=colorcode & 255;
    
  }
  
  ColorComponent.fromJson(Map<String, dynamic> args) {
    if(!args.containsKey(ARG_R))
        throw new ArgumentError("Missing argument $ARG_R");
    
    if(!args.containsKey(ARG_G))
      throw new ArgumentError("Missing argument $ARG_G");
    
    if(!args.containsKey(ARG_B))
      throw new ArgumentError("Missing argument $ARG_B");
    
    _r=args[ARG_R]; _g=args[ARG_G];_b=args[ARG_B];
  }
  
  String toJson() {
    StringBuffer sb = new StringBuffer();
    sb.writeln("\"$ARG_R\":$nr,");
    sb.writeln("\"$ARG_G\":$ng,");
    sb.write("\"$ARG_B\":$nb");
    return sb.toString();
  }
  
  int get nr => _r.round();
  int get ng => _g.round();
  int get nb => _b.round();
  
  num get r => _r;
  num get g => _g;
  num get b => _b;
  
  
  
  
 
  
  void set r (num r) {
    if(r<0)r=0;
    _r=r;
  }
  
  void set g (num g) {
    if(g<0)g=0;
    _g=g;
  }
  
  void set b (num b) {
    if(b<0)b=0;
    _b=b;
  }
}