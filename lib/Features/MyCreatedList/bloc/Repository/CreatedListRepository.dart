import 'package:equatable/equatable.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/DataProvider/CreatedListDataProvider.dart';

class CreatedListRepository {
  final CreatedListDataProvider dataProvider;
  CreatedListRepository({required this.dataProvider});

  Future<CreatedListModel> getCreatedList() => dataProvider.getCreatedList();
}
