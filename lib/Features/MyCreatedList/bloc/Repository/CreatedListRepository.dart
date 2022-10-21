import 'package:equatable/equatable.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/DataProvider/CreatedListDataProvider.dart';

class CreatedListRepository {
  final String session;
  late CreatedListDataProvider dataProvider;

  CreatedListRepository({required this.session}) {
    dataProvider = CreatedListDataProvider(session: session);
  }

  Future<List<CreatedMovieResult>> getCreatedList() {
    print("getCreatedList 1");
    return dataProvider.getCreatedList();
  }
}
