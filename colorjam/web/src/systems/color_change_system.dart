part of colorjam;





class ColorChangeSystem extends InteractionSystem{
  
  ComponentMapper<ColorComponent> colorMapper;
  
  
  ColorChangeSystem(CollectEntitiesSystem system) : super(system, Aspect.getAspectForAllOf([ColorChangeComponent, ColorComponent]));
  
  
  void initialize(){
    super.initialize();
    colorMapper = new ComponentMapper<ColorComponent>(ColorComponent, world);
    
  }
  
  
  void processInteraction(Entity entity1, Entity entity2){
     ColorComponent col1 = colorMapper.get(entity1);
     ColorComponent col2 = colorMapper.get(entity2);
     col2.r=col1.r;
     col2.g=col1.g;
     col2.b=col1.b;
     
  }
}