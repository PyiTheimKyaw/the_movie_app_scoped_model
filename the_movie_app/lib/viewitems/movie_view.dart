// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/network/api_constants.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_movie_app_by_myself/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  //final Function onTapMovie;
  final MovieVO? movie;
  MovieView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            //"https://media.comicbook.com/2016/07/wolverine-192778.jpg",
            // "https://www.babajikathulluu.com/wp-content/uploads/2019/04/Avengers_960x540.jpg",
            "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
           movie?.title ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              Text(
                '8.9',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              RatingView(),
            ],
          ),
        ],
      ),
    );
  }
}
