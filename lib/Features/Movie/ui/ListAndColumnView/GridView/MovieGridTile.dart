import 'package:flutter/material.dart';
import '../../../../../models/Item.dart';

import 'package:flutter/material.dart';
import 'package:fluttersample/models/Item.dart';
import 'package:http/http.dart';
import '../../../../CircleImage.dart';

class MovieGridTile extends StatelessWidget {
  final Result movie;

  const MovieGridTile({Key? key, required this.movie}) : super(key: key);

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
          SizedBox(width: 10),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
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
