import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';

class CreatedListDataProvider {
  final String session;
  String apiKey;
  CreatedListDataProvider(
      {required this.session,
      this.apiKey = "076c9dad29e213f91dbbe7a82aa1da1d"});

  Future<CreatedListModel> getCreatedList() async {
    final response = await http.get(Uri.parse(
        'http://api.themoviedb.org/3//account/13744211/lists?api_key=$apiKey&language=en-US&session_id=$session'));
    if (response.statusCode == 200) {
      CreatedListModel list =
          CreatedListModel.fromJson(jsonDecode(response.body));
      return list;
    } else {
      throw Exception("Unable to get created list");
    }
  }
}
