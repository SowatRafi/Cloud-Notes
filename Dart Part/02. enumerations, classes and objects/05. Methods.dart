class Person {
  final String name;
  Person(this.name);

  void printName() {
    print("The current person name is ${name}.");
  }
}

void main(List<String> args) {
  final person = Person("Kaysan");
  person.printName();
}
