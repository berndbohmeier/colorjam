part of colorjam;

class LevelParser {
  World world;
  LevelParser(this.world);
  
  void parse(String json) {
    Map data = JSON.decode(json);
    new EntityFactory.forType(data["type"])
      .build(world, data)
      .addToWorld();
  }
}