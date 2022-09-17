import 'package:flutter/material.dart';
import 'package:fluttersample/models/Item.dart';
import 'package:http/http.dart';
import '../CircleImage.dart';

class SimilarMovie extends StatelessWidget {
  final Result movie;

  const SimilarMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 110,
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
            alignment: Alignment.center,
            child: Text(
              movie.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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
