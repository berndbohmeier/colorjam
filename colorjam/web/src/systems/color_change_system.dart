part of colorjam;





class ColorChangeSystem extends InteractionSystem{
  
  ComponentMapper<ColorComponent> colorMapper;
  ComponentMapper<ColorChangeComponent> colorChangeMapper;
  
  
  ColorChangeSystem(CollectEntitiesSystem system) : super(system, Aspect.getAspectForAllOf([ColorChangeComponent, ColorComponent]));
  
  
  void initialize(){
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    colorChangeMapper = new ComponentMapper<ColorChangeComponent>(ColorChangeComponent, world);
    
  }
  
  
  void processInteraction(Entity entity1, Entity entity2){
     ColorComponent col1 = colorMapper.get(entity1);
     ColorChangeComponent colchange = colorChangeMapper.get(entity1);
     ColorComponent col2 = colorMapper.get(entity2);
     col2.r+=col1.r*colchange.rate*world.delta;
     col2.b+=col1.b*colchange.rate*world.delta;
     col2.g+=col1.g*colchange.rate*world.delta;
     
  }
}