part of colorjam;

class PlayerCollectSystem extends CollectEntitiesSystem {
  PlayerCollectSystem() : super(Aspect.getAspectForAllOf([PlayerComponent]));
}