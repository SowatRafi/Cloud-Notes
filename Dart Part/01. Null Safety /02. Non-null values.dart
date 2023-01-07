void main(List<String> args) {
  // Pick the first null value
  const String? firstName = null;
  const String? middleName = null;
  const String? lastName = "Rafi";
  // use the `??` operator
  const firstNonNullValue = firstName ?? middleName ?? lastName;

  print("First non null value is ${firstNonNullValue}.");
}
