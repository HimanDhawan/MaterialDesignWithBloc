import 'dart:async';
import 'dart:convert';
import 'package:fluttersample/models/Item.dart';
import 'package:http/http.dart' as http;

import '../../Model/RequestModel.dart';

class LoginDataProvider {
  String apiKey;

  LoginDataProvider({this.apiKey = '076c9dad29e213f91dbbe7a82aa1da1d'});

  Future<Session> login(String username, String password) async {
    print("LoginDataProvider login");
    final RequestTokenModel requestToken =
        await createRequestToken(username, password);
    print("requestToken" + requestToken.requestToken);
    final SessionWithLoginPassWordTokenModel loginPasswordModel =
        await loginWithUserNameAndPassword(
            username, password, requestToken.requestToken);
    final Session session = await createSession(
        username, password, loginPasswordModel.requestToken);
    return session;
  }

  Future<RequestTokenModel> createRequestToken(
      String username, String password) async {
    final response = await http.get(Uri.parse(
        "http://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return RequestTokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create request token');
    }
  }

  Future<SessionWithLoginPassWordTokenModel> loginWithUserNameAndPassword(
      String username, String password, String requestToken) async {
    final response = await http.post(
      Uri.parse(
          'http://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'request_token': requestToken
      }),
    );

    if (response.statusCode == 200) {
      return SessionWithLoginPassWordTokenModel.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to create session with loging and password');
    }
  }

  Future<Session> createSession(
      String username, String password, String requestToken) async {
    final response = await http.get(Uri.parse(
        "http://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey" +
            "&" +
            "request_token=$requestToken"));
    if (response.statusCode == 200) {
      return Session.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create session');
    }
  }
}



// class MovieAPIProvider {
//   String apiKey;

//   MovieAPIProvider({this.apiKey = '076c9dad29e213f91dbbe7a82aa1da1d'});

//   Future<Item> fetchItems() async {
//     print("Fetch item");
//     final response = await http.get(
//         Uri.parse('http://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));

//     if (response.statusCode == 200) {
//       return Item.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }

//   Future<Item> fetchSimilarItems(int movieID) async {
//     print("Fetch item");
//     final response = await http.get(Uri.parse(
//         'http://api.themoviedb.org/3/movie/$movieID/similar?api_key=$apiKey'));

//     if (response.statusCode == 200) {
//       return Item.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
// }