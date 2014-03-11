part of colorjam;

class SpriteComponent extends Component {
  num width = 0;
  num height = 0;
  
  

  DisplayObject dbo;
  
  
  
  SpriteComponent(this.dbo){
    
    width = dbo.width;
    height = dbo.height;
  }
  
}