import 'package:equatable/equatable.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';

enum CreateMovieListStatus { initial, loading, success, error }

class CreatedListState extends Equatable {
  final CreateMovieListStatus status;
  final List<CreatedListModel> createdList;
  final String? error;
  CreatedListState(
      {this.error,
      this.status = CreateMovieListStatus.initial,
      this.createdList = const []});

  CreatedListState copyWith({
    List<CreatedListModel>? movies,
    CreateMovieListStatus? status,
    String? error,
  }) {
    return CreatedListState(
      createdList: createdList,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [];
}
