import 'dart:async';

import 'package:the_movie_app_by_myself/data/models/movie_model_impl.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/genre_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';

import '../data/models/movie_model.dart';

class HomeBloc{
  ///Reactive Streams
  late StreamController<List<MovieVO>> mNowPlayingStreamController;
  late StreamController<List<MovieVO>> mPopularMoviesListStreamController;
  late StreamController<List<GenreVO>> mGenreListStreamController;
  late StreamController<List<ActorVO>> mActorsStreamController;
  late StreamController<List<MovieVO>> mTopRatedMoviesListStreamController;
  late StreamController<List<MovieVO>> mMoviesByGenreListStreamController;
  ///Model
  MovieModel mMovieModel=MovieModelImpl();

  HomeBloc(){
    ///Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase();
  }

  void dispose(){
    mNowPlayingStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mTopRatedMoviesListStreamController.close();
    mMoviesByGenreListStreamController.close();
  }

}