part of colorjam;






class LevelManager {
  List<String> _levels = new List<String>();
  
  
  LevelManager(this._levels);
  //LevelManager.empty();
  
  String getLevel(int index) => index >= _levels.length ? null : _levels[index];
}