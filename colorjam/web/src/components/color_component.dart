part of colorjam;

class ColorComponent extends Component {
  int colorcode;
  
  ColorComponent(int r, int g, int b) {
    colorcode = (255 << 24) | (r << 16) | (g << 8) | b;
  }
  
  ColorComponent.fromRGBA(int r, int g, int b, int a) {
    colorcode = (a << 24) | (r << 16) | (g << 8) | b;
  }
  
  ColorComponent.fromInt(this.colorcode);
  
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