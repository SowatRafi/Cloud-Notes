// Generator
Iterable<int> getOneTwoThree() sync* {
  yield 1;
  yield 8;
  yield 2;
  yield 3;
}

void main(List<String> agrs) async {
  for (final value in getOneTwoThree()) {
    print(value);
    if (value == 2) {
      break;
    } else {
      continue;
    }
  }
}
