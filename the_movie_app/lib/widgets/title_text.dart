// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';

class TitleText extends StatelessWidget {
  final String text;
  TitleText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: HOME_SCREEN_LIST_TITLE_COLOR,
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
