part of colorjam;




///NOT FINISHED!
class DelayedCallEntry{
  num timeToCall;
  Function function;
  
  DelayedCallEntry(this.function, this.timeToCall);
}

class DelayedCallSystem extends VoidEntitySystem{
  
  
  
  List<DelayedCallEntry> calls = new List<DelayedCallEntry>();
  
  
  void processSystem(){
    
  }
  
  
  void addDelayedCall(Function function, num timeToCall){
    calls.add(new DelayedCallEntry(function, timeToCall));
  }
  
}


