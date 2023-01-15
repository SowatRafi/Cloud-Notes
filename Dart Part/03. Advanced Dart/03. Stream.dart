Stream<String> getName() {
  //return Stream.value(name);
  return Stream.periodic(const Duration(seconds: 1), (name) {
    return "Sowad";
  });
}

void main(List<String> args) async {
  await for (final value in getName()) {
    print(value);
  }
}
