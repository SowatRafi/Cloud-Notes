void main(List<String> args) {
  void test(String? firstName, String? middleName, String? lastName) {
    String? name = firstName;
    // if `name` is not `null` then assign value
    name ??= lastName;
    name ??= middleName;
    print(name);
  }

  test(null, "Hossain", null);
}
