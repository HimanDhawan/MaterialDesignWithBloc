import 'dart:async';
import '../MovieProvider/movie_api_provider.dart';
import 'package:fluttersample/models/Item.dart';

class Repository {
  final movieProvider = MovieAPIProvider();

  Future<Item> fetchAllMovies() => movieProvider.fetchItems();
}
