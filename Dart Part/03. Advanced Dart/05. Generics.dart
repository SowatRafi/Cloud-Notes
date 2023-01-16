/* 
  To avoid re-writing similar code
*/
class Pair<R, A> {
  final R value_1;
  final A value_2;
  Pair(this.value_1, this.value_2);
}

void main(List<String> args) {
  final names = Pair("Sowad", "Hossain");
  final personDetails = Pair("Rafi", 24);
  print(names.value_1);
  print(personDetails.value_2);
}
