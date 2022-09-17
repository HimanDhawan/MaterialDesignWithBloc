import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int page;
  final List<Result> results;

  const Item({
    required this.page,
    required this.results,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    var results = json['results'];
    List<Result> resultModelList = [];
    for (var result in results) {
      Result resultModel = Result.fromJson(result);
      resultModelList.add(resultModel);
    }
    return Item(page: json['page'], results: resultModelList);
  }

  @override
  List<Object?> get props => [page, results];
}

class Result extends Equatable {
  final int id;
  final bool adult;
  final String originalTitle;
  final String overview;
  final String title;
  final String? posterPath;
  final String releaseDate;
  final int voteAverage;

  const Result({
    required this.id,
    required this.adult,
    required this.originalTitle,
    required this.overview,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Result.fromJson(json) {
    //print("Result $json");
    return Result(
        id: json['id'],
        adult: json['adult'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        title: json['title'],
        voteAverage: json['vote_count'],
        releaseDate: json['release_date'],
        posterPath: json['poster_path']);
  }

  @override
  List<Object?> get props => [id];
}
