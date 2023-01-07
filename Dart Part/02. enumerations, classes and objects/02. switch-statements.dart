enum AnimalType { Lion, Tiger, Cat }

void main(List<String> args) {
  // function
  void test(AnimalType animalType) {
    switch (animalType) {
      case AnimalType.Tiger:
        print("${animalType.name} is our national animal.");
        break;
      case AnimalType.Lion:
        print("Bangladesh doesn't have any ${animalType.name}");
        break;
      case AnimalType.Cat:
        print("${animalType.name}s are classified as domestic animals.");
        break;
    }
    print("Switched finished!");
  }

  test(AnimalType.Tiger);
}
