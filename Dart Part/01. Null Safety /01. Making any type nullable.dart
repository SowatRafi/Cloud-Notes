void main(List<String> args) {
  String? name = null;
  print(name);
  name = "Rafi";
  print(name);

  /**
   * We have used `List<>? varName` as we want to declear that name could be nullable
   * We have use `<String?>` as we want to put `null` as a list value
   * `Optinal` => `?`
   */
  List<String?>? names = ["Sowad", "Rafi", null];
  print(names);
}
