import 'dart:async';
import 'package:fluttersample/Features/Login/Model/RequestModel.dart';
import 'package:fluttersample/models/Item.dart';
import '../LoginDataProvider/LoginDataProvider.dart';

class LoginRepository {
  final movieProvider = LoginDataProvider();

  Future<Session> login(String username, String password) =>
      movieProvider.login(username, password);
}
