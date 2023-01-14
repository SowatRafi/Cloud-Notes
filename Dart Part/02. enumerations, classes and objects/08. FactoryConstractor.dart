class Person {
  final String name;
  const Person(this.name);
  /*
    Factory Constructor: This can return instances that are not of the same class!
  */
  factory Person.p1() {
    return Person("Sowad");
  }
}

void main(List<String> args) {
  final p1 = Person.p1();
  print(p1.name);
}
