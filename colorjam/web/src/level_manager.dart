part of colorjam;






class LevelManager {
  Map<String, String> levels = new Map<String, String>();
  
  
  LevelManager(this.levels);
  LevelManager.empty();
  
  String levelMap(String levelname) => levels[levelname];
}