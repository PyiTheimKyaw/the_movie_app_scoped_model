// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model.dart';
import 'package:the_movie_app_by_myself/data/models/movie_model_impl.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/genre_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/pages/movie_details_page.dart';
import 'package:the_movie_app_by_myself/rescources/colors.dart';
import 'package:the_movie_app_by_myself/rescources/dimens.dart';
import 'package:the_movie_app_by_myself/rescources/strings.dart';
import 'package:the_movie_app_by_myself/viewitems/actor_view.dart';
import 'package:the_movie_app_by_myself/viewitems/banner_view.dart';
import 'package:the_movie_app_by_myself/viewitems/movie_view.dart';
import 'package:the_movie_app_by_myself/viewitems/showcase_view.dart';
import 'package:the_movie_app_by_myself/widgets/actors_and_creators_section_view.dart';
import 'package:the_movie_app_by_myself/widgets/see_more_text.dart';
import 'package:the_movie_app_by_myself/widgets/title_text.dart';
import 'package:the_movie_app_by_myself/widgets/title_text_with_see_more_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0, left: 0, bottom: 0, right: MARGIN_MEDIUM_2),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScopedModelDescendant<MovieModelImpl>(
                builder:
                    (BuildContext context, Widget child, MovieModelImpl model) {
                  return BannerSectionView(
                    movieList: model.mPopularMovies?.take(7).toList() ?? [],
                  );
                },
              ),
              SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant<MovieModelImpl>(
                builder:
                    (BuildContext context, Widget child, MovieModelImpl model) {
                  return BestPopularMoviesAndSerialsSectionView(
                    onTapMovie: (movieId) =>
                        _navigateToMovieDetailsScreen(context, movieId, model),
                    nowPlayingMovies: model.mNowPlayingMovies,
                  );
                },
              ),
              SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant<MovieModelImpl>(
                builder:
                    (BuildContext context, Widget child, MovieModelImpl model) {
                  return GenreSectionView(
                    onTapMovie: (movieId) =>
                        _navigateToMovieDetailsScreen(context, movieId, model),
                    genreList: model.mGenresList,
                    moviesByGenre: model.mMoviesByGenre,
                    onChooseGenre: (genreId) {
                      if (genreId != null) {
                        model.getMoviesByGenre(genreId);
                      }
                    },
                  );
                },
              ),
              SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant<MovieModelImpl>(
                builder:
                    (BuildContext context, Widget child, MovieModelImpl model) {
                  return ShowcasesSection(
                    topRatedMovies: model.mTopRatedMovies,
                  );
                },
              ),
              SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant<MovieModelImpl>(
                builder:
                    (BuildContext context, Widget child, MovieModelImpl model) {
                  return ActorsAndCreatorsSectionView(
                    BEST_ACTORS_TITLE,
                    BEST_ACTORS_SEE_MORE,
                    actorList: model.mActors,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToMovieDetailsScreen(
    BuildContext context, int? movieId, MovieModelImpl model) {
  if (movieId != null) {
    model.getMovieDetails(movieId);
    model.getMovieDetailsFromDatabase(movieId);
    model.getCreditsByMovie(movieId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(),
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  GenreSectionView({
    required this.onTapMovie,
    required this.genreList,
    required this.moviesByGenre,
    required this.onChooseGenre,
  });

  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_CARD_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index) {
                onChooseGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) {
              onTapMovie(movieId);
            },
            movieList: moviesByGenre,
          ),
        ),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.all(MARGIN_LARGE),
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1X,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  final List<MovieVO>? topRatedMovies;

  ShowcasesSection({required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child:
              TitleTextWithSeeMoreView(SHOW_CASES_TITLE, SHOW_CASES_SEE_MORE),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: MARGIN_MEDIUM),
            children: topRatedMovies
                    ?.map(
                        (topRatedMovies) => ShowCaseView(movie: topRatedMovies))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? nowPlayingMovies;

  BestPopularMoviesAndSerialsSectionView(
      {required this.onTapMovie, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: (movieId) {
            this.onTapMovie(movieId);
          },
          movieList: nowPlayingMovies,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onTapMovie(movieList?[index].id),
                  child: MovieView(
                    // onTapMovie: () {
                    //   onTapMovie();
                    // },
                    movie: movieList?[index],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map((movie) => BannerView(
                          movie: movie,
                        ))
                    .toList() ??
                [],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: widget.movieList?.length ?? 1,
          // dotsCount: 2,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}
