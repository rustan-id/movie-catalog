import 'package:flutter/material.dart';
import 'package:movie_catalog/colors.dart';

import 'package:movie_catalog/screens/movie_details_screen.dart';

import 'package:movie_catalog/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetails(
                    movie: movie,
                  ),
            ),
          );
        },
        child: _buildCard());
  }

  Card _buildCard() {
    return Card(
      elevation: 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: FadeInImage.assetNetwork(
              fadeInDuration: Duration(milliseconds: 750),
              image: movie.coverImageMedium,
              placeholder: 'assets/images/cover_placeholder.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(7.0, 3.0, 0.0, 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    movie.title.replaceAll(' ', '').trim().length < 13
                        ? movie.title
                        : movie.title.substring(0, 13) + '...',
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.0),
                    child: Text(
                      movie.year.toString(),
                      style: TextStyle(color: kIconColor, fontSize: 13.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
