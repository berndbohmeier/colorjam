library colorjam;


import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:dartemis/dartemis.dart';

part "src/entity_factory.dart";
part "src/components/position_component.dart";
part "src/components/velocity_component.dart";
part "src/components/physics_component.dart";
part "src/components/color_component.dart";
part "src/components/geometry_component.dart";
part "src/components/sprite_component.dart";

part "src/systems/movement_system.dart";

void main() {
// setup the Stage and RenderLoop 
  var canvas = html.querySelector('#stage');
  Stage stage = new Stage('myStage', canvas);
  
  
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  ColorComponent cc = new ColorComponent.fromRGBA(255, 255, 0, 66);
  // draw a red circle
  var shape = new Shape();
  shape.graphics.circle(100, 100, 60);
  shape.graphics.fillColor(cc.colorcode);
  
  Sprite gamesprite = new Sprite();
  stage.addChild(gamesprite);
  gamesprite.addChild(shape);
  
  
  
}




