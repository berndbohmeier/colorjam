part of colorjam;

class ColorCollectSystem extends CollectEntitiesSystem {
  ColorCollectSystem() : super(Aspect.getAspectForAllOf([ColorDecayComponent]));
}