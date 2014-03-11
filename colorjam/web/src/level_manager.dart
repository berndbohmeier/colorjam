part of colorjam;






class LevelManager {
  
  List<String> _levels = new List<String>();
  ResourceManager rm;
  
  LevelManager(this._levels, this.rm);
  //LevelManager.empty();
  
  String getLevel(int index) => index >= _levels.length ? null : getLevelByName(_levels[index]);
  
  String getLevelByName(String name){
    return rm.getTextFile("${name}.lvl");
  }
}