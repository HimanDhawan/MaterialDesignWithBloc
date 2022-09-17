import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample/Features/Movie/bloc/Repository/repository.dart';
import 'package:fluttersample/Features/Movie/bloc/movielistbloc.dart';
import 'ui/ListAndColumnView/ListColumnView/DynamicList.dart';
import 'ui/ListAndColumnView/GridView/MovieGridTile.dart';
import 'ui/ListAndColumnView/GridView/MovieTileGrid.dart';

class MovieScreen extends StatefulWidget {
  String dropdownValue = 'List view';
  MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreen();
}

class _MovieScreen extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MovieListBloc>(
        create: (context) => MovieListBloc(movieRepository: Repository()),
      )
    ], child: getMovieScreen());
  }

  Widget getMovieScreen() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
              ),
              value: widget.dropdownValue,
              items: <String>['List view', 'Grid View', 'Column view']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  print("Drop down $widget.dropdownValue");
                  widget.dropdownValue = value as String;
                  print("Drop down after $widget.dropdownValue");
                });
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: getView(widget.dropdownValue),
          )
        ],
      ),
    );
  }

  Widget getView(String viewSelected) {
    if (viewSelected == 'List view') {
      print("list view");
      return MyApp(isHorizontal: true);
    } else if (viewSelected == 'Column view') {
      print("Column view");
      return MyApp(isHorizontal: false);
    } else {
      print("Grid view");
      return MovieGridListView();
    }
  }
}
