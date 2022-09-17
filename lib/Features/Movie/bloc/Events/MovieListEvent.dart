import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Events that can be triggered by user
/// Get movies
class GetMovies extends MovieListEvent {
  GetMovies();
}

/// Show movie detail
class GetMovieDetail extends MovieListEvent {
  final int selected;
  GetMovieDetail({required this.selected});
}
