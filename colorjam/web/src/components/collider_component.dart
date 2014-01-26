part of colorjam;

class ColliderComponent extends Component {
  num bounciness = 0;
  //true for door
  bool reverse = false;
  ColliderComponent({this.bounciness : 0});
  ColliderComponent.reversed(){this.reverse=true;}
}