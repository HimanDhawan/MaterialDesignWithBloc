// "description": "This section contains animated movies.",
//             "favorite_count": 0,
//             "id": 8215143,
//             "item_count": 2,
//             "iso_639_1": "en",
//             "list_type": "movie",
//             "name": "Animated movies",
//             "poster_path": null

import 'package:equatable/equatable.dart';

class CreatedMovieList extends Equatable {
  final int page;
  final List<CreatedMovieResult> results;

  CreatedMovieList(this.page, this.results);

  factory CreatedMovieList.fromJson(Map<String, dynamic> json) {
    List<CreatedMovieResult> resultModelList = [];
    for (var result in json["results"]) {
      CreatedMovieResult resultModel = CreatedMovieResult.fromJson(result);
      resultModelList.add(resultModel);
    }

    return CreatedMovieList(json["page"], resultModelList);
  }

  @override
  List<Object?> get props => [];
}

class CreatedMovieResult extends Equatable {
  final String description;
  final int id;
  final int itemCount;
  final String name;
  final String? posterPath;

  CreatedMovieResult(
      this.description, this.id, this.itemCount, this.name, this.posterPath);

  factory CreatedMovieResult.fromJson(Map<String, dynamic> json) {
    return CreatedMovieResult(json["description"], json["id"],
        json["item_count"], json["name"], json["poster_path"]);
  }

  @override
  List<Object?> get props => [];
}
