library colorjam;


import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:dartemis/dartemis.dart';

part "src/entity_factory.dart";
part "src/game.dart";
part "src/components/position_component.dart";
part "src/components/velocity_component.dart";
part "src/components/physics_component.dart";
part "src/systems/render_system.dart";

part "src/components/geometry_component.dart";
part "src/components/sprite_component.dart";

part "src/systems/movement_system.dart";

void main() {
// setup the Stage and RenderLoop 
  var canvas = html.querySelector('#stage');
  Stage stage = new Stage('myStage', canvas);
  
  
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  Game game = new Game(stage);
  game.init();
  game.createSomeTestEntities();
  game.start();
  
  
  
}




