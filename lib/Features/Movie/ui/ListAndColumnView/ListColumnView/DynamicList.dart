import 'package:flutter/material.dart';
import 'package:fluttersample/Features/Movie/bloc/States/MovieListState.dart';
import 'package:fluttersample/Features/Movie/bloc/movielistbloc.dart';
import 'package:fluttersample/Features/Movie/bloc/MovieProvider/movie_api_provider.dart';
import '../../../bloc/Events/MovieListEvent.dart';
import 'MovieTile.dart';
import '../../../../MovieDetail/MovieDetail.dart';
import 'HorizontalColumn.dart';
import '../../../../../models/Item.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  final bool isHorizontal;
  const MyApp({Key? key, required this.isHorizontal}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(child: RandomWords(isHorizontal: widget.isHorizontal));
  }
}

class RandomWords extends StatefulWidget {
  final bool isHorizontal;
  RandomWords({Key? key, required this.isHorizontal}) : super(key: key);
  final int count = 10;
  final api = MovieAPIProvider();

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  void initState() {
    super.initState();
    print("initState");
  }
  // #enddocregion RWS-var

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder
    List<Result> movies = [];
    return BlocConsumer<MovieListBloc, MovieListState>(
      buildWhen: (previous, current) =>
          (current.status == MovieListStatus.failure ||
              current.status == MovieListStatus.success ||
              current.status == MovieListStatus.loading),
      builder: (context, state) {
        if (state.status == MovieListStatus.initial) {
          print("initial state called");
          context.read<MovieListBloc>().add(GetMovies());
          return Text("Initial");
        } else if (state.status == MovieListStatus.loading) {
          return CircularProgressIndicator();
        } else if (state.status == MovieListStatus.success) {
          movies = state.movies;
          return Center(
            child: ListView.separated(
                scrollDirection:
                    widget.isHorizontal ? Axis.vertical : Axis.horizontal,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                itemBuilder: (context, i) {
                  // #docregion listTile

                  return getMovieTile(
                      i, state.movies, widget.isHorizontal, context);
                  // #enddocregion listTile
                },
                itemCount: state.movies.length,
                separatorBuilder: (context, index) {
                  return Divider(height: 20);
                }),
          );
        } else if (state.status == MovieListStatus.failure) {
          return Text("Error");
        } else {
          return Text("Show detail");
        }
      },
      listener: (context, state) {
        print("Listner called");
        if (state.status == MovieListStatus.showDetail) {
          print("Show detail listener");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MovieDetail(movie: movies[state.idSelected])));
        }
      },
    );
  }

  Widget getMovieTile(
      int index, List<Result> list, bool isHorizontal, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: MediaQuery.of(context).size.width - 20,
      child: GestureDetector(
        child: isHorizontal
            ? MovieTile(movie: list[index])
            : MovieHorizontalTile(movie: list[index]),
        onTap: () =>
            context.read<MovieListBloc>().add(GetMovieDetail(selected: index)),
      ),
    );
  }
}
