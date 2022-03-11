// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/widgets/see_more_text.dart';
import 'package:the_movie_app_by_myself/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titletext;
  final String seemoretext;
  final bool seeMoreButtonVisibility;
  TitleTextWithSeeMoreView(this.titletext, this.seemoretext,
      {this.seeMoreButtonVisibility = true});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(titletext),
        Spacer(),
        Visibility(
          visible: seeMoreButtonVisibility,
          child: SeeMoreText(seemoretext),
        ),
      ],
    );
  }
}
