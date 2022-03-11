import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_app_by_myself/data/vos/actor_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/genre_vo.dart';
import 'package:the_movie_app_by_myself/data/vos/movie_vo.dart';
import 'package:the_movie_app_by_myself/network/api_constants.dart';
import 'package:the_movie_app_by_myself/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_app_by_myself/network/the_movie_api.dart';

import 'movie_data_agent.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;

    //     .then((response) {
    //   response.results?.forEach((movie) {
    //     print("Movie ==============> ${movie.toString()}");
    //   });
    // }).catchError((error) {});
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mApi
        .getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map((getCreditsByMovieResponse) =>
            [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew])
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mApi.getMovieDetails(movieId.toString(), API_KEY);
  }

// @override
// void getNowPlayingMovies(int page) {
//   mApi
//       .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
//       .then((value) {
//     debugPrint("Now Playing Movies ================> ${value.toString()}");
//   }).catchError((error) {
//     debugPrint("Error ============> ${error.toString()}");
//   });
// }
}

