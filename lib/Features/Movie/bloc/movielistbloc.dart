import 'package:bloc/bloc.dart';
import 'package:fluttersample/Features/Movie/bloc/Events/MovieListEvent.dart';
import 'package:fluttersample/Features/Movie/bloc/Repository/repository.dart';
import 'package:fluttersample/Features/Movie/bloc/States/MovieListState.dart';
import 'dart:async';
import 'package:fluttersample/models/Item.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final Repository movieRepository;

  MovieListBloc({required this.movieRepository})
      : super(const MovieListState()) {
    on<GetMovies>(getMovies);
    on<GetMovieDetail>(getMoviesDetail);
  }

  void getMovies(GetMovies event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(status: MovieListStatus.loading));

      final Item item = await movieRepository.fetchAllMovies();
      var newstate = state.copyWith(
          movies: item.results, idSelected: 0, status: MovieListStatus.success);
      emit(newstate);
    } catch (error, stacktrace) {
      emit(state.copyWith(status: MovieListStatus.failure));
    }
  }

  void getMoviesDetail(GetMovieDetail event, Emitter<MovieListState> emit) {
    try {
      return emit(state.copyWith(
          idSelected: event.selected, status: MovieListStatus.showDetail));
    } catch (error, stacktrace) {
      return emit(state.copyWith(status: MovieListStatus.failure));
    }
  }
}
