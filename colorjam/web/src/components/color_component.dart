part of colorjam;

class ColorComponent extends Component {
  static const String ARG_R = "color_r";
  static const String ARG_G = "color_g";
  static const String ARG_B = "color_b";
  
  int colorcode;
  
  ColorComponent(int r, int g, int b) {
    colorcode = (255 << 24) | (r << 16) | (g << 8) | b;
  }
  
  ColorComponent.fromRGBA(int r, int g, int b, int a) {
    colorcode = (a << 24) | (r << 16) | (g << 8) | b;
  }
  
  ColorComponent.fromInt(this.colorcode);
  
  ColorComponent.fromJson(Map<String, dynamic> args) {
    if(!args.containsKey(ARG_R))
        throw new ArgumentError("Missing argument $ARG_R");
    
    if(!args.containsKey(ARG_G))
      throw new ArgumentError("Missing argument $ARG_G");
    
    if(!args.containsKey(ARG_B))
      throw new ArgumentError("Missing argument $ARG_B");
    
    colorcode = (255 << 24) | (args[ARG_R] << 16) | (args[ARG_G] << 8) | args[ARG_B];
  }
  
  String toJson() {
    StringBuffer sb = new StringBuffer();
    sb.writeln("\"$ARG_R\":$r,");
    sb.writeln("\"$ARG_G\":$g,");
    sb.write("\"$ARG_B\":$b");
    return sb.toString();
  }
  
  int get a => (colorcode >> 24) & 255;
  int get r => (colorcode >> 16) & 255;
  int get g => (colorcode >> 8) & 255;
  int get b => colorcode & 255;
  
  void set a (int na) {
    colorcode = (na << 24) | (colorcode & 0x00FFFFFF);
  }
  
  void set r (int nr) {
    colorcode = (nr << 16) | (colorcode & 0xFF00FFFF);
  }
  
  void set g (int ng) {
    colorcode = (ng << 8) | (colorcode & 0xFFFF00FF);
  }
  
  void set b (int nb) {
    colorcode = nb | (colorcode & 0xFFFFFF00);
  }
}