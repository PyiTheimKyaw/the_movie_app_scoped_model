// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_this

import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';
import 'package:the_movie_app_by_myself/viewitems/actor_view.dart';
import 'package:the_movie_app_by_myself/widgets/title_text_with_see_more_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<ActorVO>? actorList;

  ActorsAndCreatorsSectionView(
    this.titleText,
    this.seeMoreText, {
    this.seeMoreButtonVisibility = true,
    required this.actorList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
        top: MARGIN_CARD_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Container(
            height: BEST_ACTORS_HRIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              // ignore: prefer_const_literals_to_create_immutables
              children: actorList
                      ?.map(
                        (actor) => ActorView(
                          actor: actor,
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
