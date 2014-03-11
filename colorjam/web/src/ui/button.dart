part of colorjam;

class Button extends Sprite {
  static final TextFormat STANDART_FORMAT = new TextFormat("Arial", 40, Color.Black, strokeWidth: 2, strokeColor: Color.Blue, align: "center");
  static final TextFormat OVER_FORMAT = new TextFormat("Arial", 40, Color.Black, strokeWidth: 2, strokeColor: Color.Red, align: "center");
  SimpleButton _button;
  
  Button(String text) : super() {
    TextField label = new TextField(text, STANDART_FORMAT);
    label.border=true;
    label.borderColor=Color.Black;
    label.width = 300;
    label.height = 50;
    TextField label2 = new TextField(text, OVER_FORMAT);
    label2.border=true;
    label2.borderColor=Color.Black;
    label2.width = 300;
    label2.height = 50;
    _button = new SimpleButton(label, label2, label, label);
    addChild(_button);/*
    graphics.rect(x, y, _button.width, _button.height);
    graphics.strokeColor(Color.Black, 2);
    addChild(_button);
    applyCache(-2, -2, (width+2).round(), (height+2).round());*/
  }
}