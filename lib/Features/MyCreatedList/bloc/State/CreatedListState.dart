import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';

enum CreateMovieListStatus { initial, loading, success, error }

class CreatedListState extends Equatable {
  final CreateMovieListStatus status;
  final List<CreatedMovieResult> createdList;
  final String? error;

  const CreatedListState(
      {required this.status,
      this.error,
      List<CreatedMovieResult>? movies = const <CreatedMovieResult>[]})
      : createdList = movies ?? const [];

  CreatedListState copyWith(List<CreatedMovieResult>? movie, String? error,
      CreateMovieListStatus status) {
    return CreatedListState(error: error, movies: movie, status: status);
  }

  @override
  List<Object?> get props => [createdList, error];
}
