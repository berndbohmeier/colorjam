library colorjam;


import 'dart:html' as html;
import 'dart:convert';
import 'dart:math' as math;
import 'package:stagexl/stagexl.dart';
import 'package:dartemis/dartemis.dart';

part "src/entity_factory.dart";
part "src/game.dart";
part "src/level_parser.dart";
part "src/level_manager.dart";

// Components
part "src/components/position_component.dart";
part "src/components/velocity_component.dart";
part "src/components/physics_component.dart";
part "src/components/collider_component.dart";
part "src/components/geometry_component.dart";
part "src/components/sprite_component.dart";
part "src/components/player_control_component.dart";
part "src/components/player_input_component.dart";
part "src/components/color_component.dart";
part "src/components/type_component.dart";
// Factories
part "src/factories/circle_factory.dart";
part "src/factories/player_factory.dart";
part "src/factories/wall_factory.dart";
// Systems
part "src/systems/movement_system.dart";
part "src/systems/physics_system.dart";
part "src/systems/collider_system.dart";
part "src/systems/render_system.dart";
part "src/systems/player_control_system.dart";
part "src/systems/player_input_system.dart";
part "src/systems/player_movement_system.dart";
part "src/systems/editor_system.dart";
//scenes
part "src/scenes/scene.dart";
part "src/scenes/level_scene.dart";
part "src/scenes/world_scene.dart";
part "src/scenes/editor_scene.dart";



void main() {
// setup the Stage and RenderLoop 
  var canvas = html.querySelector('#stage');
  Stage stage = new Stage('myStage', canvas);
  
  
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  Game game = new Game(stage);
  game.init();
  game.start();
  
  
  
}




