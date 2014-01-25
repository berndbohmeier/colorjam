part of colorjam;

class VelocityComponent extends Component {
  Vector velocity;
  
  VelocityComponent(num vx, num vy) {
    velocity = new Vector(vx, vy);
  }
  
  VelocityComponent.fromVector(Vector vel) {
    velocity = vel;
  }
  
  num get vx => velocity.x;
  num get vy => velocity.y;
  
  void set vx (num nvx) {
    velocity = new Vector(nvx, vy);
  }
  
  void set vy (num nvy) {
    velocity = new Vector(vx, nvy);
  }
}