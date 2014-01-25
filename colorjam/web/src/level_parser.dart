part of colorjam;

class LevelParser {
  World world;
  LevelParser(this.world);
  
  /**
   * Create entities from a json object and
   * add them to the world.
   */
  void parse(String json) {
    Map data = JSON.decode(json);
    new EntityFactory.forType(data["type"])
      .build(world, data)
      .addToWorld();
  }
}