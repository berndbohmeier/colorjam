part of colorjam;




class ColorDecaySystem extends EntityProcessingSystem{
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<ColorDecayComponent> coldecayMapper;
  
  ColorDecaySystem() : super(Aspect.getAspectForAllOf([ColorComponent, ColorDecayComponent ]));
  
  void initialize() {
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    coldecayMapper = new ComponentMapper<ColorDecayComponent>(ColorDecayComponent, world);
  }
  
  void processEntity(Entity e) {
    ColorComponent col = colorMapper.get(e);
    ColorDecayComponent coldecay = coldecayMapper.get(e);
    
    col.r = (col.r-world.delta/coldecay.time);
    col.g = (col.g-world.delta/coldecay.time);
    col.b = (col.b-world.delta/coldecay.time);
    
  }
}