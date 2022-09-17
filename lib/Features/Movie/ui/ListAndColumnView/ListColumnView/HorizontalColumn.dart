import 'package:flutter/material.dart';
import 'package:fluttersample/models/Item.dart';
import 'package:http/http.dart';
import '../../../../CircleImage.dart';

class MovieHorizontalTile extends StatelessWidget {
  final Result movie;

  const MovieHorizontalTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: movie.posterPath != null
                        ? NetworkImage("https://image.tmdb.org/t/p/original" +
                            movie.posterPath!)
                        : NetworkImage("https://picsum.photos/200/300")),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
          ),
          SizedBox(height: 20),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Release date :" + movie.releaseDate,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Description :" + movie.overview,
                  style: TextStyle(color: Colors.grey[800]),
                )
              ],
            ),
          ))
        ],
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(20, 20, 20, 20),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
