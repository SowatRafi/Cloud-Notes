class Cat extends Object {
  final String name;
  Cat(this.name);
}

class Person {
  final String firstName;
  final String lastName;

  Person(this.firstName, this.lastName);
}

extension Run on Cat {
  void run() {
    print("${name} is running");
  }
}

extension FullName on Person {
  String get fullName => '$firstName $lastName';
}

void main(List<String> args) {
  final meow = Cat("Vutu");
  meow.run();
  final person01 = Person("Sowad", "Rafi");
  print("The full name of this person is ${person01.fullName}");
}
