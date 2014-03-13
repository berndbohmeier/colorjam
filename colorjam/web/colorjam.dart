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
part "src/bitmap_helper.dart";

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
part "src/components/color_change_component.dart";
part "src/components/color_decay_component.dart";
part "src/components/goal_component.dart";
part "src/components/player_component.dart";
part "src/components/elevator_component.dart";

// Factories
part "src/factories/circle_factory.dart";
part "src/factories/player_factory.dart";
part "src/factories/wall_factory.dart";
part "src/factories/door_factory.dart";
part "src/factories/color_changer_factory.dart";
part "src/factories/goal_factory.dart";
part "src/factories/elevator_factory.dart";

// Systems
part "src/systems/movement_system.dart";
part "src/systems/physics_system.dart";
part "src/systems/collider_system.dart";
part "src/systems/render_system.dart";
part "src/systems/color_render_system.dart";
part "src/systems/player_control_system.dart";
part "src/systems/player_input_system.dart";
part "src/systems/player_movement_system.dart";
part "src/systems/editor_system.dart";
part "src/systems/interaction_system.dart";
part "src/systems/collect_entities_system.dart";
part "src/systems/color_decay_system.dart";
part "src/systems/remove_entities_system.dart";
part "src/systems/color_change_system.dart";
part "src/systems/goal_system.dart";
part "src/systems/player_collect_system.dart";
part "src/systems/color_collect_system.dart";
part "src/systems/scroll_system.dart";
part "src/systems/game_over_system.dart";
part "src/systems/player_animation_render_system.dart";
part "src/systems/delayed_call_system.dart";
part "src/systems/elevator_movement_system.dart";

//scenes
part "src/scenes/scene.dart";
part "src/scenes/level_scene.dart";
part "src/scenes/world_scene.dart";
part "src/scenes/editor_scene.dart";
part "src/scenes/game_over_scene.dart";
part "src/scenes/main_menu_scene.dart";

// ui
part "src/ui/button.dart";



void main() {
  // setup the Stage and RenderLoop 
  html.Element canvas = html.querySelector('#stage');
  Stage stage = new Stage( canvas,  webGL:true, frameRate: 60);
  
  canvas.focus();

  
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  Game game = new Game(stage);
  game.init();
  game.start();
  
  
  
}




