class LivingThings {
  void breath(String? thing) {
    thing = thing ?? "Nothing";
    print("${thing} is breathing.");
  }

  void move(String? thing) {
    thing = thing ?? "Nothing";
    print("${thing} thing is moving...");
  }
}

class Man extends LivingThings {
  // simply using the LivingThings class
}

void main(List<String> args) {
  final human = Man();
  human.move(null);
  human.move("Sanaf");
}
