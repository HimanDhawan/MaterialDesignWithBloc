import 'package:flutter/material.dart';
import 'Features/Login/UI/Login.dart';

Stream<int> boatStream() async* {
  for (int i = 0; i <= 10; i++) {
    print("Sending boat number" + i.toString());
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
}

void main() {
  runApp(LoginScreen());
}
