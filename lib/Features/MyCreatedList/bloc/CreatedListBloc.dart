import 'package:bloc/bloc.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/DataProvider/CreatedListDataProvider.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/Event/CreatedListEvent.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/Repository/CreatedListRepository.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/State/CreatedListState.dart';

import '../Model/CreatedListModel.dart';

class CreateListBloc extends Bloc<CreatedListEvent, CreatedListState> {
  final CreatedListRepository createdListRepo;

  CreateListBloc({required this.createdListRepo})
      : super(CreatedListState(status: CreateMovieListStatus.initial)) {
    on<GetCreatedListEvent>(getMovies);
  }

  void getMovies(
      GetCreatedListEvent event, Emitter<CreatedListState> emit) async {
    try {
      emit(state.copyWith(null, null, CreateMovieListStatus.loading));
      List<CreatedMovieResult> item = await createdListRepo.getCreatedList();
      print("Bloc called emit");

      var newstate = state.copyWith(item, null, CreateMovieListStatus.success);
      emit(newstate);
      //emit(state.copyWith(
      //error: null, movies: item, status: CreateMovieListStatus.success));
    } catch (error, stacktrace) {
      emit(state.copyWith(null, null, CreateMovieListStatus.error));
    }
  }
}
