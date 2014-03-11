part of colorjam;

class EntityFactory {
  static Map<String, EntityFactory> _factories;
  
  ResourceManager resourceManager;
  
  EntityFactory._(this.resourceManager) {} 
  /**
   *  Returns an EntityFactory that can
   *  create entities of type entityType.
   *  
   *  If no such EntityFactory is found
   *  an ArgumentError is thrown.
   */
  factory EntityFactory.forType(String entityType) {
    if(_factories.containsKey(entityType))
      return _factories[entityType];
    
    throw new ArgumentError("No factory for ${entityType} found.");
  }
  
  /**
   * Create an entity with the given arguments.
   */
  Entity build(World world, Map<String, dynamic> args)
    => world.createEntity();
  
  static void createFactories(ResourceManager rm){
    _factories =  {
      "Entity" : new EntityFactory._(rm),
      "Circle" : new CircleFactory._(rm),
      "Wall" : new WallFactory._(rm),
      "Player" : new PlayerFactory._(rm),
      "ColorChanger" : new ColorChangerFactory._(rm),
      "Door" : new DoorFactory._(rm),
      "Goal" : new GoalFactory._(rm)
    };
  }
}