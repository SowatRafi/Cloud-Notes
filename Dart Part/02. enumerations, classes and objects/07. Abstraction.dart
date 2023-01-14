abstract class LivingThing {
  void breath(String? thing) {
    thing = thing ?? "Nothing";
    print("${thing} is breathing.");
  }

  void move(String? thing) {
    thing = thing ?? "Nothing";
    print("${thing} thing is moving...");
  }
}

class Cat extends LivingThing {}

void main(List<String> args) {
  // final fluffer = LivingThing;
  /*
   Abstract class cannot be instantiated.
  */

  final fluffers = Cat();
  fluffers.move("Vutu");
  fluffers.breath("Vutu");
}
