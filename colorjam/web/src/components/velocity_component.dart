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
  
}