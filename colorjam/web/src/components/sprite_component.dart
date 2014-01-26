part of colorjam;

class SpriteComponent extends Component {
  num width = 0;
  num height = 0;
  
  
  Sprite sprite;
  List<Bitmap> bitMaps; 
  SpriteComponent(this.sprite){
    width = sprite.width;
    height = sprite.height;
  }
}