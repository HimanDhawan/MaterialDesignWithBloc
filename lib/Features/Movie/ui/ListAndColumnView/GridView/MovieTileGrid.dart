import 'package:flutter/material.dart';
import 'package:fluttersample/Features/Movie/bloc/MovieProvider/movie_api_provider.dart';
import '../ListColumnView/MovieTile.dart';
import '../../../../../models/Item.dart';
import 'MovieGridTile.dart';
import '../../../../MovieDetail/MovieDetail.dart';

class MovieGridListView extends StatelessWidget {
  const MovieGridListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = MovieAPIProvider();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: FutureBuilder(
        future: api.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Item item = snapshot.data as Item;

            return Center(
              child: GridView.builder(
                itemCount: item.results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  mainAxisExtent: 180,
                ),
                itemBuilder: (context, index) {
                  return getMovieTile(index, item.results, context);
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("Not state"),
            );
          }
        },
      ),
    );
  }

  Widget getMovieTile(int index, List<Result> list, BuildContext context) {
    return GestureDetector(
      child: MovieGridTile(movie: list[index]),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(movie: list[index]))),
    );
  }
}
