/*
void main(List<String> args) async {
  print("Line 01");
  await display(1);
  print("Line 03");
}

Future<void> display(int duration) async {
  Future.delayed(Duration(seconds: duration), () => print("Line 02"));
}
*/

//int multipliedByTwo(int a) => a * 2;
Future<int> heavyFutureThatMultipliesByTwo(int a) {
  return Future.delayed(const Duration(seconds: 300), () {
    return a * 2;
  });
}

void main(List<String> args) async {
  final result = await heavyFutureThatMultipliesByTwo(
      100); // without `await it will return Future`
  print(result);
  print("End of the program");
}
