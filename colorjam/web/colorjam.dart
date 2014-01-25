library colorjam;


import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:dartemis/dartemis.dart';

part "src/entity_factory.dart";

void main() {
// setup the Stage and RenderLoop 
  var canvas = html.querySelector('#stage');
  Stage stage = new Stage('myStage', canvas);
  
  
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // draw a red circle
  var shape = new Shape();
  shape.graphics.circle(100, 100, 60);
  shape.graphics.fillColor(Color.Red);
  
  Sprite gamesprite = new Sprite();
  stage.addChild(gamesprite);
  gamesprite.addChild(shape);
  
  
  
}




