import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../../models/Item.dart';

enum MovieListStatus { initial, loading, success, failure, showDetail }

class MovieListState extends Equatable {
  final List<Result> movies;
  final MovieListStatus status;
  final int idSelected;

  const MovieListState(
      {this.status = MovieListStatus.initial,
      List<Result>? movies = const <Result>[],
      int idSelected = 0})
      : movies = movies ?? const [],
        idSelected = idSelected;

  MovieListState copyWith({
    List<Result>? movies,
    MovieListStatus? status,
    int? idSelected,
  }) {
    return MovieListState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      idSelected: idSelected ?? this.idSelected,
    );
  }

  @override
  List<Object?> get props => [movies, status, idSelected];
}
