import 'package:flutter/material.dart';

class CodeRepeat {
  hintText(String txt) {
    return InputDecoration(hintText: txt);
  }

  waiting(int time) async {
    return await Future.delayed(Duration(seconds: time));
  }
}
