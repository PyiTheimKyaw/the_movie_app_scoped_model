import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_fill,
      color: PLAY_BUTTON_COLOR,
      size: BANNER_PLAY_BUTTON_SIZE,
    );
  }
}
