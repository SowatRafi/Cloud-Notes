class Person {
  final String name;
  Person(this.name);

  @override
  bool operator ==(covariant Person other) => other.name == name;
// These 2 methods `override` the `==` administration in this case
  @override
  int get hashCode => super.hashCode;
}

void main(List<String> args) {
  final p1 = Person("Foo");
  final p2 = Person("Foo");

  if (p1 == p2) {
    print("They are equal");
  } else {
    print("They are not equal.");
  }
}
