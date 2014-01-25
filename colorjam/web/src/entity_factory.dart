part of colorjam;

class EntityFactory {
  static final Map<String, EntityFactory> _factories = {
    "Entity" : new EntityFactory._(),
    "Circle" : new CircleFactory._()
  };
  
  EntityFactory._() {} 
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
}