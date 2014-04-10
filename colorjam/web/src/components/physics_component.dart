part of colorjam;

class PhysicsComponent extends Component {
  bool onFloor = false;
  //velocity of the Entity where this entiy is on top
  Vector velocity;
  
  num bounciness = 0;
}