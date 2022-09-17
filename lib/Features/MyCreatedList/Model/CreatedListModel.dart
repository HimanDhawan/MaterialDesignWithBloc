// "description": "This section contains animated movies.",
//             "favorite_count": 0,
//             "id": 8215143,
//             "item_count": 2,
//             "iso_639_1": "en",
//             "list_type": "movie",
//             "name": "Animated movies",
//             "poster_path": null

import 'package:equatable/equatable.dart';

class CreatedListModel extends Equatable {
  final String description;
  final int id;
  final int itemCount;
  final String name;
  final String? posterPath;

  CreatedListModel(
      this.description, this.id, this.itemCount, this.name, this.posterPath);

  factory CreatedListModel.fromJson(Map<String, dynamic> json) {
    return CreatedListModel(json["description"], json["id"], json["item_count"],
        json["name"], json["poster_path"]);
  }

  @override
  List<Object?> get props => [];
}
