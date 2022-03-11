// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model_impl.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/network/api_constants.dart';
import 'package:the_movie_app_by_myself/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';
import 'package:the_movie_app_by_myself/rescources/strings.dart';
import 'package:the_movie_app_by_myself/widgets/actors_and_creators_section_view.dart';
import 'package:the_movie_app_by_myself/widgets/gradient_view.dart';
import 'package:the_movie_app_by_myself/widgets/rating_view.dart';
import 'package:the_movie_app_by_myself/widgets/title_text.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MovieModelImpl>(
        builder: (BuildContext context, Widget child, MovieModelImpl model) {
          return Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: CustomScrollView(
              slivers: [
                MovieDetailsSliverAppBarView(
                  () => Navigator.pop(context),
                  movie: model.movieDetails,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2,
                        ),
                        child: TrailerSection(
                          genreList:
                              model.movieDetails?.getGenreListAsStringList() ??
                                  [],
                          storyLine: model.movieDetails?.overView ?? "",
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      ActorsAndCreatorsSectionView(
                        MOVIE_DETAILS_SCREEN_ACOTRS_TITLE,
                        '',
                        seeMoreButtonVisibility: false,
                        actorList: model.cast,
                      ),
                      SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                        child: AboutFilmSectionView(
                          movieVO: model.movieDetails,
                        ),
                      ),
                      ActorsAndCreatorsSectionView(
                        MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                        MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                        actorList: model.crew,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? movieVO;

  AboutFilmSectionView({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText('ABOUT FILM'),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Original Title:',
          movieVO?.title ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Type:',
          movieVO?.getGenreListAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Production:',
          movieVO?.getProductionCountriesAsCommaSeparatedString() ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Premiere:',
          movieVO?.releaseDate ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView(
          'Descripton:',
          movieVO?.overView ?? "",
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAILS_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;
  final String storyLine;

  TrailerSection({required this.genreList, required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(
          storyLine: this.storyLine,
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              MOVIE_DETAILS_STORYLINE_PLAY_TRAILER_TITLE,
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
              MOVIE_DETAILS_STORYLINE_RATE_MOVIE_TITLE,
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR_2X,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  final String storyLine;

  StoryLineView({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          storyLine,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          '2hr 30mins',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        ...genreList.map((genre) => GenreChipView(genre)).toList(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO? movie;

  MovieDetailsSliverAppBarView(this.onTapBack, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      backgroundColor: PRIMARY_COLOR,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(
                imageUrl: movie?.posterPath ?? "",
              ),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: MARGIN_XXLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(
                  () => this.onTapBack(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE,
                ),
                child: MovieDetailsAppBarInfoView(
                  movie: movie,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO? movie;

  MovieDetailsAppBarInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(
              year: movie?.releaseDate?.substring(0, 4) ?? "",
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText('${movie?.voteCount} VOTES'),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  movie?.voteAverage.toString() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SiZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          movie?.title ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;

  MovieDetailsYearView({required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Text(
          year,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XLARGE,
        height: MARGIN_XLARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  String imageUrl;

  MovieDetailsAppBarImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$IMAGE_BASE_URL$imageUrl',
      fit: BoxFit.cover,
    );
  }
}
