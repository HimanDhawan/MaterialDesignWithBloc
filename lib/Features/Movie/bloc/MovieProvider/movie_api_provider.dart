import 'dart:async';
import 'dart:convert';
import 'package:fluttersample/models/Item.dart';
import 'package:http/http.dart' as http;

class MovieAPIProvider {
  String apiKey;

  MovieAPIProvider({this.apiKey = '076c9dad29e213f91dbbe7a82aa1da1d'});

  Future<Item> fetchItems() async {
    print("Fetch item");
    final response = await http.get(
        Uri.parse('http://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Item> fetchSimilarItems(int movieID) async {
    print("Fetch item");
    final response = await http.get(Uri.parse(
        'http://api.themoviedb.org/3/movie/$movieID/similar?api_key=$apiKey'));

    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
