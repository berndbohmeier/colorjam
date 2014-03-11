part of colorjam;



class BitmapHelper {
  
  
  
  static final num maxWidth = 1000;
  static final num maxHeight =1000; 
  
  static final BitmapData whiteBitmapData = new BitmapData(maxWidth, maxHeight, false, Color.White);
  static final BitmapData blackBitmapData = new BitmapData(maxWidth, maxHeight, false, Color.Black);
  
  static Sprite createRectangle(num width, num height, [Sprite sprite = null]){
    if(sprite==null){
      sprite = new Sprite();
    }else{
      sprite.removeChildren();
    }
    
    Rectangle wsize = new Rectangle(0, 0, width, height);
    Rectangle bsize = new Rectangle(0, 0, width+4, height+4);
    sprite.addChild(new Bitmap(new BitmapData.fromBitmapData(blackBitmapData, bsize))..x=-2..y=-2);
    sprite.addChild(new Bitmap(new BitmapData.fromBitmapData(whiteBitmapData,wsize)));
    return sprite;
  }
  
  
}