part of colorjam;

class PortalCollectSystem extends CollectEntitiesSystem {
  PortalCollectSystem() : super(Aspect.getAspectForAllOf([PortalComponent]));
}