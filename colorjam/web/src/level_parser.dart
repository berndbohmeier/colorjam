part of colorjam;

class LevelParser {
  World world;
  LevelParser(this.world);
  
  /**
   * Create entities from a json object and
   * add them to the world.
   */
  void parse(String json) {
    try{
    
    List<Map<String, dynamic>> entities = JSON.decode(json)["entities"];
    for(Map<String, dynamic> data in entities) {
      new EntityFactory.forType(data["type"])
        .build(world, data)
        .addToWorld();
      }
    }on FormatException catch(e){
      print("${e.message}");
      html.window.alert("${e.message}");
    }on ArgumentError catch( e) {
      print("${e.message}");
      html.window.alert("${e.message}");
    }
    
  }
}