void main(List<String> args) {
  // function
  void test(List<String>? names) {
    // OLD SCHOOL
    final int len;
    if (names != null) {
      len = names.length;
    } else {
      len = 0;
    }
    print(len);

    // Mordern way
    final length = names?.length ?? 0;
    print(length);

    // We cannot add value without mentioning `?.` as your list maybe `OPTIONAL`
    names?.add("Sowad");
    names?.add("Hossain");
    names?.add("Rafi");

    print(names);
  }

  test(null);
}
