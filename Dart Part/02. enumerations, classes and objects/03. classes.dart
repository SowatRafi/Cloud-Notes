class Person {
  void run() {
    print("Running...");
  }

  void breath() {
    print("Breathing...");
  }
}

void main(List<String> args) {
  final person = Person();
  person.run();
  person.breath();
}
