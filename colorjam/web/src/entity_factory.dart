part of colorjam;

class EntityFactory {
  static final Map<String, EntityFactory> _factories = {
    "Entity" : new EntityFactory._()
  };
  
  EntityFactory._() {}
  
  factory EntityFactory.forType(String entityType) {
    if(_factories.containsKey(entityType))
      return _factories[entityType];
    
    throw new ArgumentError("No factory for ${entityType} found.");
  }
  
  Entity build(World world, Map<String, dynamic> args)
    => world.createEntity();
}