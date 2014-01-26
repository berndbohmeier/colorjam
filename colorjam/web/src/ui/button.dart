part of colorjam;

class Button extends Sprite {
  static final TextFormat STANDART_FORMAT = new TextFormat("Arial", 30, Color.Black);
  SimpleButton _button;
  
  Button(String text) : super() {
    TextField label = new TextField(text, STANDART_FORMAT);
    label.width = 300;
    _button = new SimpleButton(label, label, label, label);
    addChild(_button);/*
    graphics.rect(x, y, _button.width, _button.height);
    graphics.strokeColor(Color.Black, 2);
    addChild(_button);
    applyCache(-2, -2, (width+2).round(), (height+2).round());*/
  }
}