// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/network/api_constants.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';
import 'package:the_movie_app_by_myself/widgets/gradient_view.dart';
import 'package:the_movie_app_by_myself/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final MovieVO? movie;


  BannerView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BannerImageView(imageUrl: movie?.posterPath ?? "",),
        ),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(title: movie?.title ?? "", ),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        ),
      ],
    );
  }
}

class BannerTitleView extends StatelessWidget {
  final String title;


  BannerTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Official Review',
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
 final String imageUrl;


 BannerImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imageUrl",
      fit: BoxFit.cover,
    );
  }
}
