part of colorjam;

class LevelParser {
  World world;
  LevelParser(this.world);
  
  /**
   * Create entities from a json object and
   * add them to the world.
   */
  void parse(String json) {
    List<Map<String, dynamic>> entities = JSON.decode(json)["entities"];
    for(Map<String, dynamic> data in entities) {
      new EntityFactory.forType(data["type"])
        .build(world, data)
        .addToWorld();
    }
  }
}