import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttersample/models/Item.dart';

import '../Movie/bloc/MovieProvider/movie_api_provider.dart';
import 'SimilarMovieCell.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;

  MovieDetail({Key? key, required this.movie}) : super(key: key);
  final api = MovieAPIProvider();
  @override
  Widget build(BuildContext context) {
    final api = MovieAPIProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                constraints: BoxConstraints.expand(width: 350, height: 500),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 15, 14, 14),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        fit: BoxFit.fill,
                        image: movie.posterPath != null
                            ? NetworkImage(
                                "https://image.tmdb.org/t/p/original" +
                                    movie.posterPath!)
                            : NetworkImage("https://picsum.photos/200/300")),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.originalTitle,
                      maxLines: 20,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                    Text(movie.overview,
                        maxLines: 20,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color.fromRGBO(255, 255, 255, 1)))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Similar movies",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(width: 350, height: 200),
                child: FutureBuilder(
                  future: api.fetchSimilarItems(movie.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Item item = snapshot.data as Item;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                        itemBuilder: (context, i) {
                          // #docregion listTile

                          return getMovieTile(i, item.results, context);
                          // #enddocregion listTile
                        },
                        itemCount: item.results.length,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMovieTile(int index, List<Result> list, BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: MediaQuery.of(context).size.width / 3,
        child: SimilarMovie(movie: list[index]));
  }
}
